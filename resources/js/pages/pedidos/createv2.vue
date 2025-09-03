<template>
    <Head title="Crear Orden" />
    <AppLayout
        :breadcrumbs="[
            { title: 'Órdenes', href: '/pedidos' },
            { title: 'Nueva Orden', href: '/pedidos/create' },
        ]"
    >
        <div class="container mx-auto max-w-6xl py-8">
            <!-- Header -->
            <div class="mb-8">
                <h1 class="mb-2 text-3xl font-bold text-gray-900">Nueva Orden de Pedido</h1>
                <p class="text-gray-600">Complete la información para registrar una nueva orden</p>
            </div>

            <form @submit.prevent="submitOrder" class="space-y-8">
                <div class="grid grid-cols-1 gap-8 lg:grid-cols-3">
                    <!-- Información Principal -->
                    <div class="space-y-6 lg:col-span-2">
                        <!-- Cliente -->
                        <Card>
                            <CardHeader>
                                <CardTitle class="flex items-center gap-2">
                                    <User class="h-5 w-5" />
                                    Información del Cliente
                                </CardTitle>
                            </CardHeader>
                            <CardContent class="space-y-4">
                                <div class="space-y-2">
                                    <Label for="customer">Cliente *</Label>
                                    <Select v-model="form.customer_id" required>
                                        <SelectTrigger>
                                            <SelectValue placeholder="Seleccione un cliente" />
                                        </SelectTrigger>
                                        <SelectContent>
                                            <SelectItem v-for="customer in customers" :key="customer.id" :value="customer.id.toString()">
                                                {{ customer.name }}
                                            </SelectItem>
                                        </SelectContent>
                                    </Select>
                                    <p v-if="form.errors.customer_id" class="text-sm text-red-500">
                                        {{ form.errors.customer_id }}
                                    </p>
                                </div>

                                <div class="space-y-2">
                                    <Label for="comments">Comentarios</Label>
                                    <Textarea v-model="form.comments" placeholder="Observaciones o comentarios adicionales..." rows="4" />
                                </div>
                            </CardContent>
                        </Card>

                        <!-- Productos -->
                        <Card>
                            <CardHeader>
                                <CardTitle class="flex items-center gap-2">
                                    <Package class="h-5 w-5" />
                                    Productos
                                </CardTitle>
                            </CardHeader>
                            <CardContent>
                                <!-- Agregar Producto -->
                                <div class="mb-6 rounded-lg border bg-gray-50 p-4">
                                    <h3 class="mb-4 flex items-center gap-2 font-medium">
                                        <Plus class="h-4 w-4" />
                                        Agregar Producto
                                    </h3>
                                    <div class="grid grid-cols-1 gap-4 md:grid-cols-4">
                                        <div class="md:col-span-2">
                                            <Select v-model="newProduct.product_id">
                                                <SelectTrigger>
                                                    <SelectValue placeholder="Seleccione producto" />
                                                </SelectTrigger>
                                                <SelectContent>
                                                    <SelectItem v-for="product in availableProducts" :key="product.id" :value="product.id.toString()">
                                                        {{ product.name }} - ${{ product.price }} (Stock: {{ product.stock }})
                                                    </SelectItem>
                                                </SelectContent>
                                            </Select>
                                        </div>
                                        <div>
                                            <Input v-model.number="newProduct.quantity" type="number" min="1" placeholder="Cantidad" />
                                        </div>
                                        <div>
                                            <Button type="button" @click="addProduct" :disabled="!canAddProduct" class="w-full">
                                                <Plus class="mr-1 h-4 w-4" />
                                                Agregar
                                            </Button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Lista de Productos -->
                                <div v-if="form.products.length === 0" class="py-12 text-center">
                                    <ShoppingCart class="mx-auto mb-4 h-16 w-16 text-gray-300" />
                                    <h3 class="mb-2 text-lg font-medium text-gray-900">No hay productos agregados</h3>
                                    <p class="text-gray-500">Use el selector de arriba para agregar productos</p>
                                </div>

                                <div v-else class="space-y-3">
                                    <div
                                        v-for="(item, index) in form.products"
                                        :key="index"
                                        class="flex items-center gap-4 rounded-lg border bg-white p-4 transition-shadow hover:shadow-sm"
                                    >
                                        <div class="flex-1">
                                            <h4 class="font-medium text-gray-900">
                                                {{ getProductName(item.product_id) }}
                                            </h4>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <div class="flex items-center gap-2">
                                                <Label class="text-sm text-gray-600">Cant:</Label>
                                                <Input v-model.number="item.quantity" type="number" min="1" class="w-20" />
                                            </div>
                                            <div class="flex items-center gap-2">
                                                <Label class="text-sm text-gray-600">Precio:</Label>
                                                <Input v-model.number="item.price" type="number" step="0.01" min="0" class="w-24" />
                                            </div>
                                            <div class="min-w-[80px] text-right font-semibold text-green-600">
                                                ${{ (item.quantity * item.price).toFixed(2) }}
                                            </div>
                                            <Button
                                                type="button"
                                                variant="ghost"
                                                size="sm"
                                                @click="removeProduct(index)"
                                                class="text-red-500 hover:text-red-700"
                                            >
                                                <Trash2 class="h-4 w-4" />
                                            </Button>
                                        </div>
                                    </div>
                                </div>
                            </CardContent>
                        </Card>
                    </div>

                    <!-- Resumen -->
                    <div class="space-y-6">
                        <Card class="sticky top-4">
                            <CardHeader>
                                <CardTitle class="flex items-center gap-2">
                                    <Calculator class="h-5 w-5" />
                                    Resumen de Orden
                                </CardTitle>
                            </CardHeader>
                            <CardContent class="space-y-4">
                                <div class="space-y-3">
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Productos:</span>
                                        <span class="font-medium">{{ form.products.length }} items</span>
                                    </div>
                                    <div class="flex justify-between text-sm">
                                        <span class="text-gray-600">Cantidad total:</span>
                                        <span class="font-medium">{{ totalQuantity }} unidades</span>
                                    </div>
                                    <Separator />
                                    <div class="flex items-center justify-between">
                                        <span class="text-lg font-semibold">Total:</span>
                                        <span class="text-2xl font-bold text-green-600"> ${{ totalOrder.toFixed(2) }} </span>
                                    </div>
                                </div>

                                <div class="space-y-3 pt-4">
                                    <Button type="submit" :disabled="form.processing || form.products.length === 0" class="w-full" size="lg">
                                        <Loader2 v-if="form.processing" class="mr-2 h-5 w-5 animate-spin" />
                                        <Save v-else class="mr-2 h-5 w-5" />
                                        {{ form.processing ? 'Creando Orden...' : 'Crear Orden' }}
                                    </Button>

                                    <Button type="button" variant="outline" class="w-full" as-child>
                                        <Link href="/pedidos">
                                            <X class="mr-2 h-4 w-4" />
                                            Cancelar
                                        </Link>
                                    </Button>
                                </div>
                            </CardContent>
                        </Card>

                        <!-- Información adicional -->
                        <Card>
                            <CardHeader>
                                <CardTitle class="flex items-center gap-2 text-sm">
                                    <Info class="h-4 w-4" />
                                    Información
                                </CardTitle>
                            </CardHeader>
                            <CardContent>
                                <div class="space-y-2 text-sm text-gray-600">
                                    <p>• El número de orden se generará automáticamente</p>
                                    <p>• Los precios pueden ser ajustados manualmente</p>
                                    <p>• La orden se guardará con estado "Activa"</p>
                                </div>
                            </CardContent>
                        </Card>
                    </div>
                </div>
            </form>
        </div>
    </AppLayout>
</template>

<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { computed, ref, watch } from 'vue';

// shadcn/ui components
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Separator } from '@/components/ui/separator';
import { Textarea } from '@/components/ui/textarea';

// Iconos
import { Calculator, Info, Loader2, Package, Plus, Save, ShoppingCart, Trash2, User, X } from 'lucide-vue-next';

// Interfaces
interface Customer {
    id: number;
    name: string;
}

interface Product {
    id: number;
    name: string;
    price: string;
    stock: number;
}

interface ProductForm {
    product_id: string;
    quantity: number;
    price: number;
}

// Props
const props = defineProps<{
    customers: Customer[];
    products: Product[];
}>();

// Form usando Inertia
const form = useForm({
    customer_id: '',
    comments: '',
    products: [] as ProductForm[],
});

// Estado para nuevo producto
const newProduct = ref({
    product_id: '',
    quantity: 1,
    price: 0,
});

// Productos disponibles
const availableProducts = computed(() => {
    const usedProductIds = form.products.map((p) => p.product_id);
    return props.products.filter((product) => !usedProductIds.includes(product.id.toString()));
});

// Validar si se puede agregar producto
const canAddProduct = computed(() => {
    return newProduct.value.product_id && newProduct.value.quantity > 0 && newProduct.value.quantity <= getMaxStock();
});

// Total de productos
const totalOrder = computed(() => {
    return form.products.reduce((total, item) => {
        return total + item.quantity * item.price;
    }, 0);
});

// Cantidad total
const totalQuantity = computed(() => {
    return form.products.reduce((total, item) => total + item.quantity, 0);
});

// Auto-completar precio cuando se selecciona producto
watch(
    () => newProduct.value.product_id,
    (productId) => {
        if (productId) {
            const product = props.products.find((p) => p.id.toString() === productId);
            if (product) {
                newProduct.value.price = parseFloat(product.price);
            }
        }
    },
);

// Funciones
const getMaxStock = () => {
    if (!newProduct.value.product_id) return 1;
    const product = props.products.find((p) => p.id.toString() === newProduct.value.product_id);
    return product ? product.stock : 1;
};

const addProduct = () => {
    if (!canAddProduct.value) return;

    form.products.push({
        product_id: newProduct.value.product_id,
        quantity: newProduct.value.quantity,
        price: newProduct.value.price,
    });

    // Reset
    newProduct.value = {
        product_id: '',
        quantity: 1,
        price: 0,
    };
};

const removeProduct = (index: number) => {
    form.products.splice(index, 1);
};

const getProductName = (productId: string) => {
    const product = props.products.find((p) => p.id.toString() === productId);
    return product ? product.name : 'Producto no encontrado';
};

const submitOrder = () => {
    if (form.products.length === 0) return;

    form.post('/pedidos', {
        preserveScroll: true,
    });
};
</script>
