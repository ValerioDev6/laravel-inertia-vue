<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;
    protected $table = 'customers';
    protected $fillable = [
        'name',
        'lastname',
        'document',
        'phone',
        'email'
    ];

    // Scope para filtros limpios
    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? false, function ($query, $search) {
            $query->where('name', 'like', "%{$search}%");
        });

        $query->when($filters['email'] ?? false, function ($query, $email) {
            $query->where('email', $email);
        });

        $query->when($filters['document'] ?? false, function ($query, $document) {
            $query->where('document', $document);
        });

        return $query;
    }
}
