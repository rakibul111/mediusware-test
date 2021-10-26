<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductVariantPriceRelationTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('product_variant_prices', function (Blueprint $table) {
            $table->foreign('product_variant_1')->references('id')->on('product_variants')->onDelete('cascade');
            $table->foreign('product_variant_2')->references('id')->on('product_variants')->onDelete('cascade');
            $table->foreign('product_variant_3')->references('id')->on('product_variants')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('product_variant_price_relation');
    }
}
