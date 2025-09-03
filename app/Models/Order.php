<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Order extends Model
{
    use HasFactory;

    protected $table = 'orders';

    protected $fillable = [
        'order_number',
        'comments',
        'total',
        'customer_id',
        'user_id',
        'state'
    ];

    protected $casts = [
        'total' => 'decimal:2'
    ];

    // ------------------- Relaciones -------------
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function details(): HasMany
    {
        return $this->hasMany(OrderDetail::class, 'order_id');
    }

    // ------------------- Métodos útiles -------------
    public function generateOrderNumber()
    {
        return 'ORD-' . date('Ymd') . '-' . str_pad($this->id, 4, '0', STR_PAD_LEFT);
    }

    public function calculateTotal()
    {
        return $this->details->sum(function ($detail) {
            return $detail->quantity * $detail->price;
        });
    }

    // Scope para filtros
    public function scopeFilter($query, array $filters)
    {
        $query->when($filters['search'] ?? false, function ($query, $search) {
            $query->where('order_number', 'like', "%{$search}%")
                ->orWhereHas('customer', function ($q) use ($search) {
                    $q->where('name', 'like', "%{$search}%");
                });
        });

        $query->when($filters['customer_id'] ?? false, function ($query, $customerId) {
            $query->where('customer_id', $customerId);
        });

        $query->when($filters['user_id'] ?? false, function ($query, $userId) {
            $query->where('user_id', $userId);
        });


        return $query;
    }
}
