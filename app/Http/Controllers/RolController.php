<?php

namespace App\Http\Controllers;

use App\Http\Requests\RolRequest;
use App\Models\Rol;
use Illuminate\Http\Request;
use Inertia\Inertia;

class RolController extends Controller
{
    public function index(Request $request)
    {
        $filters = $request->only(['search']);

        $roles = Rol::filter($filters)
            ->latest()
            ->paginate(10)
            ->withQueryString();

        // dd($roles->toArray());

        return Inertia::render('roles/Index', [
            'roles' => [
                'data' => $roles->items(),
                'meta' => [
                    'total' => $roles->total(),
                    'current_page' => $roles->currentPage(),
                    'last_page' => $roles->lastPage(),
                    'per_page' => $roles->perPage(),
                ],
                'links' => $roles->links(),
            ],
        ]);
    }

    public function create(Rol $rol)
    {
        return Inertia::render('roles/create');
    }

    public function store(RolRequest $request)
    {
        Rol::create([
            'slug' => $request->slug,
            'name' => $request->name
        ]);

        return redirect()->route('roles.index')->with('success', 'Rol creado con éxito.');
    }

    public  function edit(Rol $rol)
    {
        return Inertia::render('roles/edit', compact('rol'));
    }

    public function update(Request $request, Rol $rol)
    {
        $rol->update([
            'slug' => $request->slug,
            'name' => $request->name
        ]);
        return redirect()->route('roles.index')->with('success', 'Rol actualizado con éxito.');
    }

    public function destroy(Rol $rol)
    {
        $rol->delete();
        return redirect()->route('roles.index')->with('success', 'Rol eliminado con éxito.');
    }
}
