<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProductRequest;
use App\Http\Resources\ProductResource;
use App\Models\Category;
use App\Models\Product;
use Inertia\Inertia;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index2(Request $request)
    {
        $products = Product::with('category')->latest()->paginate(4);
        $products = ProductResource::collection($products);
        return Inertia::render('products/Index', compact('products'));
    }

    public function index(Request $request)
    {
        $filters = $request->only(['search', 'category_id']);
        $products = Product::with('category')
            ->filter($filters)
            ->latest()
            ->paginate(10)
            ->withQueryString();

        $products = ProductResource::collection($products);
        // dd($products->toArray());
        $categories = Category::select('id', 'name')
            ->orderBy('name')
            ->get();

        return Inertia::render('products/Index', compact('products', 'categories'));
    }

    public function create()
    {
        $categories = Category::select("id", "name")->ordeBy("name")->get();

        return Inertia::render('products/create', compact('categories'));
    }

    public function store(ProductRequest $request)
    {
        Product::create([
            'name' => $request->name,
            'description' => $request->description,
            'stock' => $request->stock,
            'price' => $request->price,
            'categorie_id' => $request->categorie_id,
        ]);
        return redirect()->route('products.index')->with('success', 'Producto creado con exito!');
    }

    public function edit(Product $product)
    {
        $categories = Category::select('id', 'name')
            ->orderBy('name')
            ->get();
        $product = Product::with('category');
        return Inertia::render('products/edit', compact('product', 'categories'));
    }

    public function update(Request $request, Product $product)
    {
        $product->update([
            'name' => $request->name,
            'description' => $request->description,
            'stock' => $request->stock,
            'price' => $request->price,
            'categorie_id' => $request->categorie_id,
        ]);
        return redirect()->route('products.index')->with('success', 'Producto actualizado con exito!');
    }

    public function destroy() {}
}
