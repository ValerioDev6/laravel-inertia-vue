<template>
    <Head title="Crear Pedido" />
    <AppLayout
        :breadcrumbs="[
            { title: 'Pedidos', href: '/pedidos' },
            { title: 'Crear Pedido', href: '/pedidos/create' },
        ]"
    >
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <!-- ENCABEZADO -->
            <div class="flex items-center justify-between">
                <div>
                    <h1 class="text-2xl font-semibold">Crear Nueva Orden</h1>
                    <p class="mt-1 text-sm text-muted-foreground">Selecciona un cliente y agrega productos</p>
                </div>
            </div>

            <!-- AREA DE SELECCION -->
            <div class="flex flex-wrap items-end gap-3 rounded-lg border bg-muted/30 p-4">
                <!-- por cliente -->
                <div class="min-w-[200px] space-y-1">
                    <Label for="customer" class="text-xs text-muted-foreground">Seleccione su Cliente</Label>
                    <Select v-model="localCustomerId">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Seleccionar cliente" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todos los clientes</SelectItem>
                            <SelectItem v-for="customer in customers" :key="customer.id" :value="customer.id.toString()">
                                {{ customer.name }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Selector de productos -->
                <div class="min-w-[200px] space-y-1">
                    <Label for="product" class="text-xs text-muted-foreground">Seleccionar Producto</Label>
                    <Select v-model="selectedProductId" :disabled="!localCustomerId || localCustomerId === 'all'">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Seleccionar producto" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem v-for="product in products" :key="product.id" :value="product.id.toString()">
                                {{ product.name }} - ${{ product.price }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Botón agregar -->
                <Button @click="addProduct" :disabled="!selectedProductId || loading" variant="default" size="sm" class="flex items-center gap-2">
                    <Plus class="h-4 w-4" />
                    Agregar
                </Button>
            </div>

            <!-- TABLA DE PRODUCTOS -->
            <div class="rounded-lg border bg-card">
                <div class="border-b p-4">
                    <h3 class="font-medium">Productos Agregados</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead class="border-b bg-muted/50">
                            <tr>
                                <th class="px-4 py-3 text-left text-sm font-medium">Producto</th>
                                <th class="px-4 py-3 text-left text-sm font-medium">Precio</th>
                                <th class="px-4 py-3 text-left text-sm font-medium">Cantidad</th>
                                <th class="px-4 py-3 text-left text-sm font-medium">Subtotal</th>
                                <th class="px-4 py-3 text-center text-sm font-medium">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y">
                            <tr v-if="orderProducts.length === 0">
                                <td colspan="5" class="px-4 py-8 text-center text-muted-foreground">No hay productos agregados</td>
                            </tr>
                            <tr v-for="(item, index) in orderProducts" :key="index">
                                <td class="px-4 py-3">{{ item.name }}</td>
                                <td class="px-4 py-3">${{ item.price }}</td>
                                <td class="px-4 py-3">
                                    <div class="flex items-center gap-2">
                                        <Button
                                            variant="outline"
                                            size="sm"
                                            @click="updateQuantity(index, item.quantity - 1)"
                                            :disabled="item.quantity <= 1"
                                        >
                                            -
                                        </Button>
                                        <span class="min-w-[2rem] text-center">{{ item.quantity }}</span>
                                        <Button variant="outline" size="sm" @click="updateQuantity(index, item.quantity + 1)"> + </Button>
                                    </div>
                                </td>
                                <td class="px-4 py-3 font-medium">${{ (item.price * item.quantity).toFixed(2) }}</td>
                                <td class="px-4 py-3 text-center">
                                    <Button variant="destructive" size="sm" @click="removeProduct(index)">
                                        <Trash class="h-4 w-4" />
                                    </Button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Total -->
                <div class="border-t p-4">
                    <div class="flex items-center justify-between">
                        <div class="space-y-2">
                            <Label for="comments" class="text-sm font-medium">Comentarios</Label>
                            <textarea
                                v-model="comments"
                                id="comments"
                                class="flex min-h-[60px] w-80 rounded-md border border-input bg-background px-3 py-2 text-sm"
                                placeholder="Comentarios opcionales..."
                            />
                        </div>
                        <div class="text-right">
                            <p class="text-lg font-medium">Total: ${{ totalOrder.toFixed(2) }}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ACCIONES -->
            <div class="flex justify-end gap-3 border-t pt-6">
                <Button variant="outline" @click="handleCancel"> Cancelar </Button>
                <Button
                    @click="createOrder"
                    :disabled="!localCustomerId || localCustomerId === 'all' || orderProducts.length === 0 || loading"
                    class="flex items-center gap-2"
                >
                    <Save class="h-4 w-4" />
                    {{ loading ? 'Guardando...' : 'Crear Orden' }}
                </Button>
            </div>
        </div>
    </AppLayout>
</template>

<script lang="ts" setup>
import { Button } from '@/components/ui/button';
import Label from '@/components/ui/label/Label.vue';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, router } from '@inertiajs/vue3';
import axios from 'axios';
import { Plus, Save, Trash } from 'lucide-vue-next';
import { computed, ref } from 'vue';

interface Customer {
    id: number;
    name: string;
    full_name: string;
}

interface Product {
    id: number;
    name: string;
    price: string;
    stock: number;
}

interface OrderProduct {
    product_id: number;
    name: string;
    quantity: number;
    price: number;
}

interface Props {
    customers: Customer[];
    products: Product[];
}

const props = defineProps<Props>();

// Estado local
const loading = ref(false);
const localCustomerId = ref('');
const selectedProductId = ref('');
const orderProducts = ref<OrderProduct[]>([]);
const comments = ref('');

// Total de la orden
const totalOrder = computed(() => {
    return orderProducts.value.reduce((sum, item) => sum + item.price * item.quantity, 0);
});

// Agregar producto
const addProduct = () => {
    if (!selectedProductId.value) return;

    const product = props.products.find((p) => p.id.toString() === selectedProductId.value);
    if (!product) return;

    const existingIndex = orderProducts.value.findIndex((item) => item.product_id === product.id);

    if (existingIndex >= 0) {
        orderProducts.value[existingIndex].quantity += 1;
    } else {
        orderProducts.value.push({
            product_id: product.id,
            name: product.name,
            quantity: 1,
            price: parseFloat(product.price),
        });
    }

    selectedProductId.value = '';
};

// Actualizar cantidad
const updateQuantity = (index: number, newQuantity: number) => {
    if (newQuantity < 1) return;
    orderProducts.value[index].quantity = newQuantity;
};

// Remover producto
const removeProduct = (index: number) => {
    orderProducts.value.splice(index, 1);
};

// Crear orden
const createOrder = async () => {
    if (!localCustomerId.value || localCustomerId.value === 'all' || orderProducts.value.length === 0) {
        alert('Selecciona un cliente específico y agrega productos');
        return;
    }

    loading.value = true;

    try {
        const orderData = {
            customer_id: parseInt(localCustomerId.value),
            comments: comments.value,
            products: orderProducts.value.map((item) => ({
                product_id: item.product_id,
                quantity: item.quantity,
                price: item.price,
            })),
        };

        const response = await axios.post('/pedidos', orderData);

        if (response.data.success) {
            alert('Orden creada exitosamente');
            router.visit('/pedidos');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Error al crear la orden');
    } finally {
        loading.value = false;
    }
};

const handleCancel = () => {
    router.visit('/pedidos');
};
</script>
