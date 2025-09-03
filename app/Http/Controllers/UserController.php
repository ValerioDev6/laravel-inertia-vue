<?php

namespace App\Http\Controllers;

use App\Http\Requests\UpdateUserRequest;
use App\Http\Requests\UserRequest;
use App\Http\Resources\UserResource;
use App\Models\File;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Illuminate\Support\Str;
use Inertia\Response;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    public function index(Request $request)
    {
        // $query = User::query()
        //     ->with(['file']); // Carga relaciones necesarias (ejemplo)

        // // Filtros dinámicos
        // if ($request->filled('nIdUsuario')) {
        //     $query->where('id', $request->nIdUsuario);
        // }

        // if ($request->filled('cNombre')) {
        //     $query->where('name', 'like', '%' . $request->cNombre . '%');
        // }

        // if ($request->filled('cCorreo')) {
        //     $query->where('email', 'like', '%' . $request->cCorreo . '%');
        // }

        // if ($request->filled('cEstado')) {
        //     $query->where('status', $request->cEstado);
        // }

        // // Paginar en lugar de all()
        // $users = $query->paginate(12)->withQueryString();

        return Inertia::render('usuarios/listado');
    }

    // public function getListarUsuarios(Request $request)
    // {
    //     if (!$request->ajax()) redirect('/');
    //     // Obtener parámetros del request
    //     $cNombre = $request->cNombre ?? '';
    //     $cCorreo = $request->cCorreo ?? '';  // Era $request->CUsuario (error de mayúscula)
    //     $cEstado = $request->cEstado ?? '';
    //     $nIdUsuario = $request->nIdUsuario ?? 0;  // Este era el parámetro que faltaba

    //     // El stored procedure espera: (nidusuario, cnombre, ccorreo, cestado)
    //     $rpta = DB::select('CALL sp_Usuario_getListarUsuarios(?,?,?,?)', [
    //         $nIdUsuario,  // INT - ID del usuario (0 para todos)
    //         $cNombre,     // VARCHAR - nombre del usuario
    //         $cCorreo,     // VARCHAR - correo del usuario
    //         $cEstado      // CHAR - estado del usuario
    //     ]);

    //     return $rpta;
    // }

    public function lista(Request $request): JsonResponse
    {
        $search = $request->get("search");
        $state  = $request->get("state");
        $email  = $request->get("email");

        $query = User::with('file')
            ->select('users.*')
            ->when($search, function ($q) use ($search) {
                $q->where(function ($sub) use ($search) {
                    $sub->where('users.name', 'LIKE', "%{$search}%");
                });
            })
            ->when($email, function ($q) use ($email) {
                $q->where('users.email', 'LIKE', "%{$email}%");
            })
            ->when($state, function ($q) use ($state) {
                $q->where('users.state', $state);
            })
            ->orderBy("users.id", "desc");

        $users = $query->paginate(10);

        return response()->json([
            'success' => true,
            'data' => UserResource::collection($users),
            'info' => [
                'total'         => $users->total(),
                'per_page'      => $users->perPage(),
                'last_page'     => $users->lastPage(),
                'next_page_url' => $users->nextPageUrl(),
                'prev_page_url' => $users->previousPageUrl(),
                'current_page'  => $users->currentPage(),
            ],
        ]);
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create(): Response
    {
        return Inertia::render('usuarios/create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(UserRequest $request)
    {

        $fileId = null;

        if ($request->hasFile('imagen')) {
            $path = $request->file('imagen')->store('users', 'public');
            $file = File::create([
                'filename' => $request->file('imagen')->getClientOriginalName(),
                'path' => $path,
            ]);
            $fileId = $file->id;
        }
        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'file_id' => $fileId,
        ]);

        // ✅ Redirige con flash message
        return redirect()->route('usuarios.index')->with('success', 'Usuario creado con éxito.');
    }

    /**
     * Display the specified resource.
     */
    public function show(User $user)
    {

        return Inertia::render('usuarios/show', compact('user'));
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(User $user)
    {
        $user = User::with("file")->findOrFail($user->id);
        // $user->load("file");
        // dd($user->toArray());

        return Inertia::render('usuarios/edit', compact('user'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateUserRequest $request, User $user)
    {
        try {

            $fileId = $user->file_id;

            if ($request->hasFile('imagen')) {
                // Eliminar archivo anterior
                if ($user->file) {
                    Storage::disk('public')->delete($user->file->path);
                    $user->file->delete();
                }

                // Subir nuevo archivo
                $path = $request->file('imagen')->store('users', 'public');
                $file = File::create([
                    'filename' => $request->file('imagen')->getClientOriginalName(),
                    'path' => $path,
                ]);
                $fileId = $file->id;
            }

            // MÉTODO 1: Usando save() (más directo)
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            if ($request->filled('password')) {
                $user->password = Hash::make($request->password);
            }
            $user->file_id = $fileId;
            $user->save();

            return redirect()->route('usuarios.index')->with('success', 'Usuario actualizado con éxito.');
        } catch (\Exception $e) {
            return back()->with('error', 'Error al actualizar: ' . $e->getMessage());
        }
    }

    public function state(Request $request)
    {

        $idUsuario   = $request->IdUsuario;
        $cState      = $request->cState;

        DB::select('call sp_update_user_state(?,?)', [$idUsuario, $cState]);

        return response()->json([
            'success' => true,
            'message' => 'Usuario activado exitosamente',
        ]);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(User $user)
    {
        $user = User::findOrFail($user->id);
        $user->delete();
        return redirect()->route('usuarios.index')->whith('success', 'Usuarios Eliminado correctamente!');
    }
}
