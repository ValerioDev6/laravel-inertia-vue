<?php

namespace App\Http\Controllers;

use App\Http\Resources\ProductResource;
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
        $search = $request->get('search');
        $categoryId = $request->get('category_id');

        $products = Product::with('category')
            ->when($search, function ($query, $search) {
                return $query->where('name', 'like', "%{$search}%")
                    ->orWhere('description', 'like', "%{$search}%");
            })
            ->latest()
            ->paginate(5)
            ->withQueryString();

        $products = ProductResource::collection($products);

        return Inertia::render('products/Index', compact('products'));
    }
}
