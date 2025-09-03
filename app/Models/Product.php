<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Product extends Model
{
    protected $table = 'products';

    protected $fillable = [
        'name',
        'description',
        'stock',
        'price',
        'categorie_id',
    ];


    // SCOPE para filtros limpios
    public function scopeFilter($query, array $filters)
    {
        // Filtro por búsqueda (nombre y descripción)
        $query->when($filters['search'] ?? false, function ($query, $search) {
            $query->where('name', 'like', "%{$search}%")
                ->orWhere('description', 'like', "%{$search}%");
        });

        // Filtro por categoría (por ID)
        $query->when($filters['category_id'] ?? false, function ($query, $categoryId) {
            $query->where('categorie_id', $categoryId);
        });

        return $query;
    }


    /** -------------- ACCESOR -------------- */
    public function getStockStatusAttribute(): string
    {
        if ($this->stock <= 0) {
            return 'Sin stock';
        } elseif ($this->stock < 10) {
            return 'Stock bajo (' . $this->stock . ')';
        } else {
            return 'En stock (' . $this->stock . ')';
        }
    }

    /** -------------- RELACIONES ----------  */

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'categorie_id');
    }
}
