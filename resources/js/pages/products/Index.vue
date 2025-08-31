<script setup lang="ts">
import {
    AlertDialog,
    AlertDialogAction,
    AlertDialogCancel,
    AlertDialogContent,
    AlertDialogDescription,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogTitle,
    AlertDialogTrigger,
} from '@/components/ui/alert-dialog';
import { Button } from '@/components/ui/button';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head, Link, router } from '@inertiajs/vue3';
import { BadgePlus, Eye, Package, Pencil, RefreshCw, Search, Trash2, X } from 'lucide-vue-next';
import { ref } from 'vue';
import { route } from 'ziggy-js';

interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
    stock_status?: string;
    category: {
        name: string;
    };
    created_at: string;
}

interface Props {
    products: {
        data: Product[];
        links: any;
        meta: {
            total: number;
            current_page: number;
            last_page: number;
            per_page: number;
        };
    };
}

const props = defineProps<Props>();

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Products',
        href: '/products',
    },
];

// Estados locales
const loading = ref(false);
const localSearch = ref('');
const filterProducts = () => {
    const params = localSearch.value.trim() ? { search: localSearch.value.trim() } : {};

    router.get(route('products.index'), params, {
        preserveState: true,
        preserveScroll: true,
        onStart: () => (loading.value = true),
        onFinish: () => (loading.value = false),
    });
};

// Métodos
const handleRefresh = async () => {
    loading.value = true;
    router.reload({
        onFinish: () => {
            loading.value = false;
        },
    });
};

const clearFilters = () => {
    localSearch.value = '';
};

const confirmDelete = (id: number) => {
    router.delete(route('products.destroy', { product: id }), {
        preserveScroll: true,
        onSuccess: () => {
            // Producto eliminado exitosamente
        },
        onError: () => {
            // Error al eliminar
        },
    });
};
const goToPage = (page) => {
    router.get(
        route('products.index'),
        { page },
        {
            preserveScroll: true,
        },
    );
};
</script>

<template>
    <Head title="Productos" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header -->
            <div class="flex items-center justify-between">
                <div>
                    <Link>
                        <Button variant="outline" size="sm" class="mr-2">
                            <BadgePlus class="mr-2 h-4 w-4" />
                            Crear Producto
                        </Button>
                    </Link>

                    <Button @click="handleRefresh" :disabled="loading" variant="outline" size="sm">
                        <RefreshCw :class="['mr-2 h-4 w-4', loading && 'animate-spin']" />
                        Actualizar
                    </Button>
                </div>
            </div>

            <!-- Filtros -->
            <div class="flex flex-wrap items-end gap-3 rounded-lg border bg-muted/30 p-4">
                <div class="min-w-[200px] flex-1 space-y-1">
                    <Label for="search" class="text-xs text-muted-foreground">Buscar productos</Label>
                    <div class="relative">
                        <Search class="absolute top-1/2 left-3 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" @keyup.enter="filterProducts" />
                    </div>
                </div>

                <div class="flex gap-2">
                    <Button @click="clearFilters" :disabled="loading" variant="outline" size="sm">
                        <X class="mr-2 h-4 w-4" />
                        Limpiar
                    </Button>
                </div>
            </div>

            <!-- Contenido -->
            <div class="flex-1">
                <div v-if="loading" class="flex items-center justify-center py-8">
                    <RefreshCw class="mr-2 h-5 w-5 animate-spin" />
                    <span class="text-sm">Cargando productos...</span>
                </div>

                <div v-else-if="props.products.data.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                    <Package class="mb-2 h-8 w-8 text-muted-foreground" />
                    <p class="text-sm text-muted-foreground">No se encontraron productos</p>
                </div>

                <!-- ✅ TABLA CON DATOS -->
                <div v-else class="rounded-md border">
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>ID</TableHead>
                                <TableHead>Producto</TableHead>
                                <TableHead>Categoría</TableHead>
                                <TableHead>Precio</TableHead>
                                <TableHead>Stock</TableHead>
                                <TableHead class="text-center">Acciones</TableHead>
                            </TableRow>
                        </TableHeader>

                        <TableBody>
                            <TableRow v-for="product in props.products.data" :key="product.id">
                                <TableCell class="font-medium">
                                    {{ product.id }}
                                </TableCell>

                                <TableCell>
                                    <div>
                                        <p class="font-medium">{{ product.name }}</p>
                                        <p class="text-sm text-muted-foreground">{{ product.description?.slice(0, 50) }}...</p>
                                    </div>
                                </TableCell>

                                <TableCell>
                                    <span class="inline-flex items-center rounded-full bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700">
                                        {{ product.category.name }}
                                    </span>
                                </TableCell>

                                <TableCell class="font-medium"> ${{ product.price }} </TableCell>

                                <TableCell>
                                    <span
                                        :class="[
                                            'inline-flex items-center rounded-full px-2 py-1 text-xs font-medium',
                                            product.stock > 10
                                                ? 'bg-green-50 text-green-700'
                                                : product.stock > 0
                                                  ? 'bg-yellow-50 text-yellow-700'
                                                  : 'bg-red-50 text-red-700',
                                        ]"
                                    >
                                        {{ product.stock_status || `${product.stock} unidades` }}
                                    </span>
                                </TableCell>

                                <TableCell class="flex justify-center gap-2">
                                    <Button size="sm" variant="outline">
                                        <Eye class="h-4 w-4" />
                                    </Button>

                                    <Link>
                                        <Button size="sm" variant="outline">
                                            <Pencil class="h-4 w-4" />
                                        </Button>
                                    </Link>

                                    <!-- Alert Dialog para eliminar -->
                                    <AlertDialog>
                                        <AlertDialogTrigger as-child>
                                            <Button size="sm" variant="destructive">
                                                <Trash2 class="h-4 w-4" />
                                            </Button>
                                        </AlertDialogTrigger>

                                        <AlertDialogContent>
                                            <AlertDialogHeader>
                                                <AlertDialogTitle>¿Eliminar producto?</AlertDialogTitle>
                                                <AlertDialogDescription>
                                                    Esta acción eliminará el producto <strong>{{ product.name }}</strong> de forma permanente.
                                                </AlertDialogDescription>
                                            </AlertDialogHeader>
                                            <AlertDialogFooter>
                                                <AlertDialogCancel>Cancelar</AlertDialogCancel>
                                                <AlertDialogAction @click="confirmDelete(product.id)"> Sí, eliminar </AlertDialogAction>
                                            </AlertDialogFooter>
                                        </AlertDialogContent>
                                    </AlertDialog>
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </div>
            </div>

            <!-- Paginación e info -->
            <div v-if="!loading && props.products.data.length > 0" class="flex items-center justify-between">
                <span class="text-sm text-muted-foreground"> {{ props.products.meta.total }} productos en total </span>

                <!-- PAGINACIÓN COMPLETA -->
                <div class="flex items-center gap-3">
                    <!-- Página actual info -->
                    <div class="text-sm text-muted-foreground">
                        Página {{ props.products.meta.current_page }} de {{ props.products.meta.last_page }}
                    </div>

                    <!-- Controles de paginación -->
                    <div class="flex items-center gap-2">
                        <!-- Botón Anterior -->
                        <Button
                            size="sm"
                            variant="outline"
                            @click="goToPage(props.products.meta.current_page - 1)"
                            :disabled="props.products.meta.current_page <= 1"
                        >
                            ← Anterior
                        </Button>

                        <!-- Input para página específica -->
                        <div class="flex items-center gap-1">
                            <span class="text-sm">Ir a:</span>
                            <input
                                type="number"
                                :value="props.products.meta.current_page"
                                @keyup.enter="goToPage($event.target.value)"
                                :min="1"
                                :max="props.products.meta.last_page"
                                class="w-16 rounded border px-2 py-1 text-center text-sm"
                            />
                        </div>

                        <!-- Botón Siguiente -->
                        <Button
                            size="sm"
                            variant="outline"
                            @click="goToPage(props.products.meta.current_page + 1)"
                            :disabled="props.products.meta.current_page >= props.products.meta.last_page"
                        >
                            Siguiente →
                        </Button>
                    </div>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<style scoped></style>
