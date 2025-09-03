<?php

namespace Database\Seeders;

use App\Models\Customer;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OrderSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 🔥 Crear 15 órdenes con datos aleatorios
        for ($i = 1; $i <= 15; $i++) {

            // Obtener IDs aleatorios que existen en la DB
            $randomCustomerId = Customer::inRandomOrder()->first()?->id ?? 1;
            $randomUserId = User::inRandomOrder()->first()?->id ?? 1;

            // Crear la orden principal
            $order = Order::create([
                'order_number' => 'ORD-' . date('Ymd') . '-' . str_pad($i, 4, '0', STR_PAD_LEFT),
                'comments' => fake()->sentence(6), // Comentario aleatorio
                'total' => 0, // Se calculará después
                'customer_id' => $randomCustomerId,
                'user_id' => $randomUserId,
                'state' => fake()->randomElement(['A', 'I']), // Estado aleatorio
            ]);

            // 🛒 Crear detalles aleatorios para cada orden (entre 1 y 5 productos)
            $numberOfProducts = fake()->numberBetween(1, 5);
            $totalOrder = 0;

            for ($j = 1; $j <= $numberOfProducts; $j++) {

                // Obtener producto aleatorio
                $randomProduct = Product::inRandomOrder()->first();

                if ($randomProduct) {
                    $quantity = fake()->numberBetween(1, 10);
                    $price = fake()->randomFloat(2, 5, 500); // Precio entre 5.00 y 500.00

                    // Crear detalle de orden
                    OrderDetail::create([
                        'order_id' => $order->id,
                        'product_id' => $randomProduct->id,
                        'quantity' => $quantity,
                        'price' => $price,
                    ]);

                    // Sumar al total
                    $totalOrder += ($quantity * $price);
                }
            }

            // Actualizar el total de la orden
            $order->update(['total' => $totalOrder]);

            // Mostrar progreso (opcional)
            echo "Orden {$i}/15 creada: {$order->order_number} - Total: $" . number_format($totalOrder, 2) . "\n";
        }

        echo "\n🎉 ¡15 órdenes creadas exitosamente con productos aleatorios!\n";
    }
}
