@extends('layouts.app')

@section('content')

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Products</h1>
    </div>


    <div class="card">
        {{-- can be filtered by 1 or more field --}}
        <form action="{{route('search')}}" method="post" class="card-header">
            @csrf
            <div class="form-row justify-content-between">
                <div class="col-md-2">
                    <input type="text" name="title" id="title" placeholder="Product Title" class="form-control" value="">
                </div>
                <div class="col-md-2">
                    <select name="variant" id="select" class="form-control">
                        <option value="" selected>Select variant</option>
                    @forelse($product_variants as $item)
                        <option value="{{$item->id}}">{{$item->variant}}</option>
                    @empty
                    @endforelse
                    </select>
                </div>

                <div class="col-md-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Price Range</span>
                        </div>
                        <input type="number" name="price_from" aria-label="First name" placeholder="From" class="form-control">
                        <input type="number" name="price_to" aria-label="Last name" placeholder="To" class="form-control">
                    </div>
                </div>
                <div class="col-md-2">
                    <input type="date" name="date" placeholder="Date" class="form-control">
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary float-right"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </form>

        <div class="card-body">
            <div class="table-response">
                <table class="table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Variant</th>
                        <th width="150px">Action</th>
                    </tr>
                    </thead>

                    <tbody>
                    @forelse($products as $row)
                    <tr>
                        <td>{{$row->id}}</td>
                        <td>{{$row->title}} <br> Created at : {{$row->created_at->format('d-M-Y')}}</td>
                        <td>{{$row->description}}</td>
                        <td>
                            <dl class="row mb-0" style="height: 80px; overflow: hidden" id="variant">

                                <dt class="col-sm-3 pb-0">
                                @forelse($row->prices as $price)
                                    {{$price->product_variant_one ? $price->product_variant_one->variant.'/' :null}}
                                    {{$price->product_variant_two ? $price->product_variant_two->variant.'/' :null}}
                                    {{$price->product_variant_three ? $price->product_variant_three->variant.'/' :null}}
                                    <br>
                                @empty
                                @endforelse
                                </dt>
                                <dd class="col-sm-9">
                                @forelse($row->prices as $price)
                                    <dl class="row mb-0">
                                        <dt class="col-sm-4 pb-0">Price : {{ number_format($price->price,2) }}</dt>
                                        <dd class="col-sm-8 pb-0">InStock : {{ number_format($price->stock,2) }}</dd>
                                    </dl>
                                @empty
                                @endforelse
                                </dd>
                            </dl>
                            <button onclick="$('#variant').toggleClass('h-auto')" class="btn btn-sm btn-link">Show more</button>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="{{ route('product.edit', $row->id) }}" class="btn btn-success">Edit</a>
                            </div>
                        </td>
                    </tr>
                    @empty
                    <tr><td>No Data available</td></tr>
                    @endforelse
                    </tbody>

                </table>
            </div>

        </div>

        <div class="card-footer">
            <div class="d-flex justify-content-between">
                <div>
                    @php
                        $showing = $products->perPage() * ($products->currentPage()-1) + 1;
                        $to = $products->perPage() * $products->currentPage();
                        $total = $products->total();
                    @endphp
                    <p>
                        Showing {{$showing > $total ? $total : $showing}}
                        to 
                        {{$to > $total ? $total : $to}}
                        out of 
                        {{$total}}
                    </p>
                </div>
                <div>
                    {{ $products->links()}}
                </div>
            </div>
        </div>

        {{-- <div class="card-footer">
            <div class="row justify-content-between">
                <div class="col-md-6">
                    <p>Showing 1 to 10 out of 100</p>
                </div>
                <div class="col-md-6">
                    {{ $products->appends($params)->links()}}
                </div>
            </div>
        </div> --}}
    </div>

@endsection
@section('page-scripts')
    <script src="{{asset('js/product_variants_update.js')}}"></script>
@endsection
