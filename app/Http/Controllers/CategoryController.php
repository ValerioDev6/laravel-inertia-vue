<?php

namespace App\Http\Controllers;

use App\Http\Requests\CategoryRequest;
use App\Http\Requests\UpdateCategoryRequest;
use App\Http\Resources\CategoryResource;
use App\Models\Category;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {

        return Inertia::render('categories/Index');
    }

    /**
     * Obtiene una lsita paginadad de categorias con busqueda
     *
     * Retorna las categorias por ID descencente con capacaidad de busqueda por nombre.
     *
     * @param Request $request - Contioene parametros para busqueda
     * @return JsonResponse
     * @response 200 {
     *   "success": true,
     *   "data": [
     *     {
     *       "id": 1,
     *       "name": "Tecnología",
     *       "created_at": "2025-01-01T00:00:00Z"
     *     }
     *   ],
     *   "info": {
     *     "total": 50,
     *     "per_page": 10,
     *     "current_page": 1,
     *     "last_page": 5,
     *     "next_page_url": "http://example.com/api/categories?page=2",
     *     "prev_page_url": null
     *   }
     * }
     *
     * @throws \Exception Si hay error en la consulta a la base de datos
     *
     **/
    public function lista(Request $request): JsonResponse
    {
        $search = $request->get('search');
        $query = Category::select('categories.*')
            ->when($search, function ($q) use ($search) {
                $q->where(function ($sub) use ($search) {
                    $sub->where('categories.name', 'LIKE', "%{$search}%");
                });
            })
            ->orderBy('categories.id', "desc");

        $categories = $query->paginate(10);


        return response()->json([
            'success' => true,
            'data' => CategoryResource::collection(($categories)),
            'info' => [
                'total'         => $categories->total(),
                'per_page'      => $categories->perPage(),
                'last_page'     => $categories->lastPage(),
                'next_page_url' => $categories->nextPageUrl(),
                'prev_page_url' => $categories->previousPageUrl(),
                'current_page'  => $categories->currentPage(),
            ],
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('categories/create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CategoryRequest $request)
    {
        Category::create([
            'name' => $request->name,
            'description' => $request->description
        ]);

        return redirect()->route('categories.index')->with('success', 'Categoria creada con exito!');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Category $category)
    {
        // $category = Category::findOrFail($category->id);
        return Inertia::render('categories/edit', compact('category'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateCategoryRequest $request, Category $category)
    {
        $category->update([
            'name' => $request->name,
            'description' => $request->description
        ]);

        return redirect()
            ->route('categories.index')
            ->with('success', 'Categoría actualizada con éxito.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        $category = Category::findOrFail($category->id);
        $category->delete();

        return redirect()
            ->route('categories.index')
            ->with('success', 'Categoría eliminada con éxito.');
    }
}
