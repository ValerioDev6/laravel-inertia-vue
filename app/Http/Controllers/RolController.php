<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class RolController extends Controller
{
    public function index()
    {
        return Inertia::render('roles/Index');
    }
}
