<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductVariantPrice extends Model
{
    protected $guarded = [];

    public function product_variant_one()
    {
        return $this->belongsTo('App\Models\ProductVariant','product_variant_1');
    }
    public function product_variant_two()
    {
        return $this->belongsTo('App\Models\ProductVariant','product_variant_2');
    }
    public function product_variant_three()
    {
        return $this->belongsTo('App\Models\ProductVariant','product_variant_3');
    }
}
