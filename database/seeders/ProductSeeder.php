<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Product;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Primero verificamos que existan categorías
        $categories = Category::all();

        if ($categories->isEmpty()) {
            $this->command->warn('No hay categorías disponibles. Creando algunas...');
            $this->createSampleCategories();
            $categories = Category::all();
        }

        // Array de productos de ejemplo
        $products = [
            [
                'name' => 'iPhone 14 Pro',
                'description' => 'Smartphone Apple con pantalla Super Retina XDR de 6.1 pulgadas',
                'price' => 1199.99,
                'stock' => 25
            ],
            [
                'name' => 'Samsung Galaxy S23',
                'description' => 'Teléfono Android con cámara de 50MP y pantalla Dynamic AMOLED',
                'price' => 899.99,
                'stock' => 30
            ],
            [
                'name' => 'MacBook Air M2',
                'description' => 'Laptop ultradelgada con chip M2 y pantalla Liquid Retina de 13.6"',
                'price' => 1299.99,
                'stock' => 15
            ],
            [
                'name' => 'Dell XPS 13',
                'description' => 'Laptop premium con procesador Intel Core i7 y 16GB RAM',
                'price' => 1099.99,
                'stock' => 20
            ],
            [
                'name' => 'Sony WH-1000XM5',
                'description' => 'Auriculares inalámbricos con cancelación de ruido activa',
                'price' => 399.99,
                'stock' => 50
            ],
            [
                'name' => 'AirPods Pro 2',
                'description' => 'Auriculares inalámbricos Apple con cancelación de ruido',
                'price' => 249.99,
                'stock' => 40
            ],
            [
                'name' => 'iPad Pro 12.9"',
                'description' => 'Tablet profesional con chip M2 y pantalla Liquid Retina XDR',
                'price' => 1099.99,
                'stock' => 18
            ],
            [
                'name' => 'Nintendo Switch OLED',
                'description' => 'Consola portátil/sobremesa con pantalla OLED de 7 pulgadas',
                'price' => 349.99,
                'stock' => 35
            ],
            [
                'name' => 'Canon EOS R5',
                'description' => 'Cámara mirrorless profesional con sensor full-frame de 45MP',
                'price' => 3899.99,
                'stock' => 8
            ],
            [
                'name' => 'Logitech MX Master 3',
                'description' => 'Mouse inalámbrico ergonómico para productividad avanzada',
                'price' => 99.99,
                'stock' => 60
            ]
        ];

        // Crear cada producto con categoría aleatoria
        foreach ($products as $productData) {
            Product::create([
                'name' => $productData['name'],
                'description' => $productData['description'],
                'price' => $productData['price'],
                'stock' => $productData['stock'],
                'categorie_id' => $categories->random()->id,
            ]);
        }

        $this->command->info('✅ Se crearon ' . count($products) . ' productos con categorías aleatorias');
    }

    private function createSampleCategories(): void
    {
        $categories = [
            ['name' => 'Electrónicos', 'description' => 'Dispositivos electrónicos y gadgets'],
            ['name' => 'Computadoras', 'description' => 'Laptops, PCs y accesorios'],
            ['name' => 'Audio', 'description' => 'Auriculares, altavoces y equipos de sonido'],
            ['name' => 'Gaming', 'description' => 'Consolas, videojuegos y accesorios'],
            ['name' => 'Fotografía', 'description' => 'Cámaras, lentes y equipos fotográficos'],
        ];

        foreach ($categories as $category) {
            Category::create($category);
        }

        $this->command->info('✅ Se crearon categorías de ejemplo');
    }
}
