<?php

use App\Http\Controllers\CategoryController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\PedidoController;
use App\Http\Controllers\PermisosController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RolController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome');
})->name('home');

Route::get('dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');


Route::middleware(['auth', 'verified'])->group(function () {

    Route::get('/pedidos', [PedidoController::class, 'index'])->name('pedidos.index');
    Route::get('/clients', [ClientController::class, 'index'])->name('clients.index');
    // CATEGORIAS
    Route::get('/categories', [CategoryController::class, 'index'])->name('categories.index');

    Route::get('/products', [ProductController::class, 'index'])->name('products.index');
    Route::get('/products', [ProductController::class, 'index'])->name('products.index');
    // Route::resource('/usuarios', UserController::class);


    // USUARIOS
    Route::get('/usuarios', [UserController::class, 'index'])->name('usuarios.index');
    Route::get('/usuarios/create', [UserController::class, 'create'])->name('usuarios.create');
    Route::post('/usuarios', [UserController::class, 'store'])->name('usuarios.store');
    Route::get('/usuarios/{user}/edit ', [UserController::class, 'edit'])->name('usuarios.edit');
    Route::put('/usuarios/{user}', [UserController::class, 'update'])->name('usuarios.update');
    Route::delete('/usuarios/{user}', [UserController::class, 'destroy'])->name('usuarios.destroy');
    Route::post('/usuarios/state', [UserController::class, 'state'])->name('usuarios.state');

    Route::get('/roles', [RolController::class, 'index'])->name('roles.index');
    Route::get('/permisos', [PermisosController::class, 'index'])->name('permisos.index');

    Route::get('/reportes', [ReporteController::class, 'index'])->name('reportes.index');

    // RUTAS API PARA AXIOS (devuelven JSON)
    Route::prefix('api')->group(function () {
        Route::get('/usuarios', [UserController::class, 'lista'])->name('api.usuarios.lista');
        Route::get('/categories', [CategoryController::class, 'lista'])->name('api.categorias.lista');


        Route::get('/roles', [RolController::class, 'index'])->name('api.roles.index');
        Route::get('/clients', [ClientController::class, 'index'])->name('api.clients.index');
    });
});


Route::get('/api/usuarios', [UserController::class, 'lista'])->name('api.usuarios.lista');

require __DIR__ . '/settings.php';
require __DIR__ . '/auth.php';

// Fantastic (Ayu, Darcula, Gruvbox, Material, Monokai, Slime, Oceanic, One)
// https://123av.com/en/dm4/v/fc2-ppv-2172312
