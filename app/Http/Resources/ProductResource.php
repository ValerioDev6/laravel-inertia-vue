<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'description' => $this->description,
            'stock' => $this->stock,
            'stock_status' => $this->stock_status,
            'price' => $this->price,
            'category' => [
                'name' => $this->category->name
            ],
            'created_at' => $this->created_at->format('Y-m-d A h:i')

        ];
    }
}
