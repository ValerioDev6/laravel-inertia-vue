<?php

namespace App\Http\Controllers;

use App\Exports\OrdersExport;
use App\Http\Resources\OrderResource;
use App\Models\Customer;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\Product;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Maatwebsite\Excel\Facades\Excel;

class PedidoController extends Controller
{
    public function index(Request $request)
    {

        $filters = $request->only(['search', 'customer_id', 'user_id']);
        $orders = Order::with(['user', 'customer'])
            ->filter($filters)
            ->latest()
            ->paginate(10)
            ->withQueryString();
        $orders = OrderResource::collection($orders);

        $customers = Customer::select('id', 'name')
            ->orderBy('name')
            ->get();

        $users = User::select('id', 'name')
            ->orderBy('name')
            ->get();

        // dd($orders->toJson());

        return Inertia::render('pedidos/Index', compact('orders', 'users', 'customers'));
    }

    public function create()
    {
        $customers = Customer::select('id', 'name', 'lastname')
            ->orderBy('name')
            ->get()
            ->map(function ($customer) {
                return [
                    'id' => $customer->id,
                    'name' => $customer->name . ' ' . $customer->lastname,
                    'full_name' => $customer->name . ' ' . $customer->lastname
                ];
            });

        $products = Product::select('id', 'name', 'price', 'stock')
            // ->where('stock', '>', 0) // Solo productos con stock
            ->orderBy('name')
            ->get()
            ->map(function ($product) {
                return [
                    'id' => $product->id,
                    'name' => $product->name,
                    'price' => number_format($product->price, 2, '.', ''),
                    'stock' => $product->stock
                ];
            });

        return Inertia::render('pedidos/create', [
            'customers' => $customers,
            'products' => $products
        ]);
    }



    public function store(Request $request)
    {
        // Validación
        $validated = $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'comments' => 'nullable|string|max:255',

            // Validar array de productos
            'products' => 'required|array|min:1',
            'products.*.product_id' => 'required|exists:products,id',
            'products.*.quantity' => 'required|integer|min:1',
            'products.*.price' => 'required|numeric|min:0',
        ]);

        try {
            // 🔥 TRANSACCIÓN - Todo o nada
            DB::beginTransaction();

            // 1️⃣ Crear la orden principal
            $order = Order::create([
                'customer_id' => $validated['customer_id'],
                'user_id' => Auth::id(), // Usuario que crea la orden
                'comments' => $validated['comments'],
                'total' => 0, // Se calculará después
                'state' => 'A',
                'order_number' => null, // Se generará después de tener el ID
            ]);

            // 2️⃣ Generar número de orden
            $order->update([
                'order_number' => $order->generateOrderNumber()
            ]);

            $totalOrder = 0;

            // 3️⃣ Crear los detalles de la orden
            foreach ($validated['products'] as $productData) {
                $detail = OrderDetail::create([
                    'order_id' => $order->id,
                    'product_id' => $productData['product_id'],
                    'quantity' => $productData['quantity'],
                    'price' => $productData['price'],
                ]);

                // Sumar al total
                $totalOrder += ($detail->quantity * $detail->price);
            }

            // 4️⃣ Actualizar el total de la orden
            $order->update(['total' => $totalOrder]);

            // ✅ Confirmar transacción
            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Orden creada exitosamente',
                'data' => [
                    'order' => $order->load(['customer', 'details.product']),
                    'order_number' => $order->order_number,
                    'total' => $order->total
                ]
            ], 201);
        } catch (\Exception $e) {
            // ❌ Revertir cambios si algo falla
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Error al crear la orden: ' . $e->getMessage()
            ], 500);
        }
    }

    public function export()
    {
        return Excel::download(new OrdersExport, 'orders.xlsx');
    }
}
