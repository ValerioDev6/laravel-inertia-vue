<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class OrderResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            // 📋 Datos básicos de la orden
            'id' => $this->id,
            'order_number' => $this->order_number,
            'comments' => $this->comments,
            'total' => number_format($this->total, 2), // Formato de moneda
            'state' => $this->state,
            'state_label' => $this->state == 'A' ? 'Activa' : 'Inactiva',
            'created_at' => $this->created_at->format('Y-m-d H:i:s'),
            'created_at_human' => $this->created_at->diffForHumans(), // "hace 2 horas"

            // 👤 Información del cliente
            'customer' => [
                'full_name' => $this->customer->name . ' ' . $this->customer->lastname,

            ],

            // 🧑‍💼 Información del usuario que creó la orden
            'user' => [
                'name' => $this->user->name,
            ],

            // 🛒 Detalles de productos en la orden
            // 'details' => $this->details->map(function ($detail) {
            //     return [
            //         'id' => $detail->id,
            //         'quantity' => $detail->quantity,
            //         'price' => number_format($detail->price, 2),
            //         'subtotal' => number_format($detail->quantity * $detail->price, 2),

            //         // 📦 Información del producto
            //         'product' => [
            //             'id' => $detail->product->id,
            //             'name' => $detail->product->name ?? 'Producto sin nombre',
            //             'description' => $detail->product->description ?? null,
            //             'sku' => $detail->product->sku ?? null,
            //             // Agrega más campos de product según tengas
            //         ],
            //     ];
            // }),

            // 📊 Información calculada
            // 'summary' => [
            //     'total_items' => $this->details->sum('quantity'),
            //     'total_products' => $this->details->count(),
            //     'total_amount' => number_format($this->total, 2),
            //     'average_item_price' => $this->details->count() > 0
            //         ? number_format($this->total / $this->details->sum('quantity'), 2)
            //         : '0.00',
            // ],
        ];
    }
}
