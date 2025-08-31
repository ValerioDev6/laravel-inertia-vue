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
