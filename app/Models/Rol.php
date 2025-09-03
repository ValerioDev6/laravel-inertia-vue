<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Rol extends Model
{
    protected $table = 'roles';
    protected $fillable = [
        'slug',
        'name',
    ];


    // SCOPE

    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? false, function ($query, $search) {
            $query->where('name', 'like', "%{$search}%")
                ->orWhere('slug', 'like', "%{$search}%");
        });

        // Filtros adicionales si los necesitas
        // $query->when($filters['name'] ?? false, function ($query, $name) {
        //     $query->where('name', 'like', "%{$name}%");
        // });

        // $query->when($filters['slug'] ?? false, function ($query, $slug) {
        //     $query->where('slug', 'like', "%{$slug}%");
        // });
        return $query;
    }
}
