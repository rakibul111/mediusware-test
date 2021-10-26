<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductImage;
use App\Models\ProductVariant;
use App\Models\ProductVariantPrice;
use App\Models\Variant;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductController1 extends Controller
{

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function index()
    {
        $products = Product::with(['prices'])->paginate(2);
        $product_variants = ProductVariant::all();
        return view('products.index', compact('products', 'product_variants'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function create()
    {
        $variants = Variant::all();
        return view('products.create', compact('variants'));
    }
    public function search(Request $request)
    {
        // can be filtered by 1 or more field
        $title = $request->title;
        $variant = $request->variant;
        $price_from = $request->price_from;
        $price_to = $request->price_to;
        $date = $request->date;

        $vp = [$price_from, $price_to, $variant];

        $product_variants = ProductVariant::all();

        try{
            $products = Product::with('prices')
                ->when($title, function ($query, $title) {
                    return $query->where('title', 'like', '%'.$title.'%');
                })
                ->when($date, function ($query, $date) {
                    return $query->whereDate('created_at', $date);
                })->whereHas('prices', function($q) use($vp){

                    $price_from = $vp[0] ;
                    $price_to = $vp[1] ;
                    $variant = $vp[2] ;

                    $q->when($price_from, function ($query, $price_from) {
                        return $query->where('price', '>=', intval($price_from));
                    })->when($price_to, function ($query, $price_to) {
                        return $query->where('price', '<=', intval($price_to));
                    })->when($variant, function ($query, $variant) {
                        return $query->whereRaw("(product_variant_1 = $variant or product_variant_2 = $variant or product_variant_3 = $variant)");
                    });
                })->paginate(2);
            $products->appends($request->all());

        } catch (Exception $e) {
            return $e->getMessage();
        }
        return view('products.index', compact('products', 'product_variants'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        try {
            // $this->validate($request, [
            //     'title'            =>'required',
            //     'sku'              =>'required'|'unique:products',
            //     'product_image'    =>'required'|'image|mimes:jpeg,png,jpg,gif,svg|max:2024',
            //     'product_variant'  =>'required',
            //     'product_variant_prices'  =>'required',
            // ]);

            $product = Product::create(['title' => $request->title, 'sku' => $request->sku, 'description' =>$request->description]);

            $product_image = new ProductImage();
            if($request->hasFile('product_image')){
                foreach($request->file('product_image') as $img){
                    $file = $img;
                    $filename = time().'-'.uniqid().'.'.$file->getClientOriginalExtension();
                    $file->move(public_path('uploads/products'), $filename);
                    // save filename to database
                    $product_image->create(['product_id' => $product->id, 'file_path' => $filename]);
                }
            }

            $product_variant = new ProductVariant();
            foreach($request->product_variant as $variant){
                $variant = json_decode($variant);
                foreach($variant->tags as $tag){
                    $product_variant->create(['variant'=>$tag, 'variant_id'=>$variant->option, 'product_id'=>$product->id]);
                }
            }

            foreach($request->product_variant_prices as $price){
                $pv_prices = new ProductVariantPrice();
                $price = json_decode($price);
                $attrs = explode("/", $price->title);

                $product_variant_ids= [];
                for( $i=0; $i<count($attrs)-1; $i++){
                    $product_variant_ids[] = ProductVariant::select('id')->where('variant', $attrs[$i])->latest()->first()->id;
                }

                for( $i=1; $i<=count($product_variant_ids); $i++){
                    $pv_prices->{'product_variant_'.$i} = $product_variant_ids[$i-1];
                }
                $pv_prices->price = $price->price;
                $pv_prices->stock = $price->stock;
                $pv_prices->product_id = $product->id;
                $pv_prices->save();
            }
        } catch (Exception $e) {
            return response($e);
        }
        return response('product added successfully');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function edit(Product $product)
    {
        $product = Product::with(['prices','product_variants'])->find($product->id);
        $variants = Variant::all();
        return view('products.edit', compact('variants', 'product'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        try{
            $p_id = $product->id;
            $product = Product::where('id', $product->id)->update(['title' => $request->title, 'sku' => $request->sku, 'description' =>$request->description]);

            //  if there is image
            if($request->hasFile('product_image')) {
                // remove previous image
                $this->removeImage($p_id);
                $product_image = new ProductImage();
                foreach($request->file('product_image') as $img){
                    $file = $img;
                    $filename = time().'-'.uniqid().'.'.$file->getClientOriginalExtension();
                    $file->move(public_path('uploads/products'), $filename);
                    // save filename to database
                    $product_image->create(['product_id' => $p_id, 'file_path' => $filename]);
                }
            }
            // same variant will be updated new will added 
            // deleted tags will be deleted
            $product_variant = new ProductVariant();
            foreach($request->product_variant as $variant){
                $variant = json_decode($variant);
                $product_variants = $product_variant->where('variant_id',$variant->option)->where('product_id', $p_id)->get();
                $num_tags = 0;
                $num_product_variants = count($product_variants);
                foreach($variant->tags as $index=>$tag){
                    $num_tags +=1;
                    if($num_product_variants >= $index+1){
                        $product_variants[$index]->update(['variant'=>$tag]);
                    }else{
                        $product_variant->create(['variant'=>$tag, 'variant_id'=>$variant->option, 'product_id'=>$p_id]);
                    }
                }
                // delete previous extra variants
                for($i=1; $i <= $num_product_variants - $num_tags; $i++ ){
                    $product_variants[$num_product_variants-$i]->delete();
                }
            }

            // same combination will be updated new will added 
            // deleted combination will be deleted
            $num_req_prices = 0;
            foreach($request->product_variant_prices as $index=>$price){
                $price = json_decode($price);
                $attrs = explode("/", $price->title);
                $product_variant_ids= [];
                for( $i=0; $i<count($attrs)-1; $i++){
                    $product_variant_ids[] = ProductVariant::select('id')->where('variant', $attrs[$i])->latest()->first()->id;
                }

                $new_pv_prices = new ProductVariantPrice();
                $pv_prices = ProductVariantPrice::where('product_id', $p_id)->get();
                $num_pv_prices = count($pv_prices);

                $num_req_prices+=1;

                if($num_pv_prices >= $index+1){
                    for( $i=1; $i<=count($product_variant_ids); $i++){
                        $pv_prices[$index]->{'product_variant_'.$i} = $product_variant_ids[$i-1];
                    }
                    $pv_prices[$index]->price = $price->price;
                    $pv_prices[$index]->stock = $price->stock;
                    $pv_prices[$index]->product_id = $p_id;
                    $pv_prices[$index]->save();
                }else{
                    for( $i=1; $i<=count($product_variant_ids); $i++){
                        $new_pv_prices[$index]->{'product_variant_'.$i} = $product_variant_ids[$i-1];
                    }
                    $new_pv_prices[$index]->price = $price->price;
                    $new_pv_prices[$index]->stock = $price->stock;
                    $new_pv_prices[$index]->product_id = $p_id;
                    $new_pv_prices[$index]->save();
                }
            }
            // delete previous extra combination
            for($i=1; $i <= $num_pv_prices - $num_req_prices; $i++ ){
                $pv_prices[$num_pv_prices-$i]->delete();
            }


        } catch (Exception $e) {
            return response($e);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        //
    }
    private function removeImage($p_id)
    {
        $product_image = ProductImage::where('product_id', $p_id)->get();
        foreach($product_image as $img){
            if($img->file_path != "" && \File::exists('uploads/products/' . $img->file_path)) {
                @unlink(public_path('uploads/products/' . $img->file_path));
            }
        }
        ProductImage::where('product_id', $p_id)->delete();
    }
}
