<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Http\Requests\ProductStoreRequest;

class ProductController extends Controller
{

  public function index()
  {
    $products = Product::all();

    return response()->json([
      "products" => $products
    ], 200);
  }

  public function store(ProductStoreRequest $request)
  {
    try {
      $name = $request->name;
      $price = $request->price;
      $img = $request->file('img');
      $newFileName = 'product' . now()->timestamp . '.' . $img->getClientOriginalExtension();
      $img->move(public_path('img/'), $newFileName);

      Product::create([
        'name' => $name,
        'img' => $newFileName,
        'price' => $price,
      ]);

      return response()->json([
        'result' => "Product successfully added: '$name'"
      ], 200);
    } catch (\Throwable $th) {
      return response()->json([
        'message' => "Something went wrong"
      ], 500);
    }
  }

  public function show($id)
  {
    $product = Product::find($id);

    if (!$product) {
      return response()->json([
        'product not found'
      ], 400);
    }
    return response()->json([
      'product' => $product
    ], 200);
  }
  public function update($id, ProductStoreRequest $request)
  {
      try {
          $product = Product::find($id);
          if (!$product) {
              return response()->json([
                  'message' => 'Product not found'
              ], 404);
          }
  
          $name = $request->name;
          $price = $request->price;
          $img = $request->file('img');
  
          // Jika ada file gambar yang diunggah, simpan gambar baru
          if ($img) {
              $newFileName = 'product' . now()->timestamp . '.' . $img->getClientOriginalExtension();
              $img->move(public_path('img/'), $newFileName);
              $product->img = $newFileName;
          }
  
          $product->name = $name;
          $product->price = $price;
          $product->save();
  
          return response()->json([
              'result' => "Product successfully updated: '$name'"
          ], 200);
      } catch (\Throwable $th) {
          return response()->json([
              'message' => "Something went wrong"
          ], 500);
      }
  }
  public function destroy($id)
  {
    $product = Product::find($id);

    if (!$product) {
      return response()->json([
        'product not found'
      ], 400);
    }

    $product->delete();
    return response()->json([
      'message' => "Product successfuly deleted"
    ], 200);
  }
}
