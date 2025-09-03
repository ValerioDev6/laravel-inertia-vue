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
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head, Link, router } from '@inertiajs/vue3';
import { BadgePlus, Eye, Package, Pencil, RefreshCw, Search, Trash2, X } from 'lucide-vue-next';
import { ref, watch } from 'vue';
import { route } from 'ziggy-js';
import type { Category, Product } from './interfaces/products.interface';

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
    categories: Category[];
}

const props = defineProps<Props>();

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Products',
        href: '/products',
    },
];

// Estados
const loading = ref(false);
const localSearch = ref('');
const localCategoryId = ref('');

const filterProducts = () => {
    const filters: any = {
        search: '',
        category_id: '',
    };

    if (localSearch.value.trim()) {
        filters.search = localSearch.value.trim();
    }

    if (localCategoryId.value) {
        filters.category_id = localCategoryId.value;
    }

    router.get(route('products.index'), filters, {
        preserveState: true,
        preserveScroll: true,
    });
};

// Funciones
const clearFilters = () => {
    localSearch.value = '';
    localCategoryId.value = '';
    router.get(route('products.index'), {}, { preserveState: true });
};

const handleRefresh = () => {
    loading.value = true;
    router.reload({
        onFinish: () => (loading.value = false),
    });
};

const confirmDelete = (id: number) => {
    router.delete(route('products.destroy', { product: id }), {
        preserveScroll: true,
        onSuccess: () => {
            // Producto eliminado
        },
        onError: () => {
            // Error
        },
    });
};

const goToPage = (page: number) => {
    const currentFilters: any = {};

    if (localSearch.value.trim()) {
        currentFilters.search = localSearch.value.trim();
    }

    if (localCategoryId.value) {
        currentFilters.category_id = localCategoryId.value;
    }

    router.get(route('products.index'), { ...currentFilters, page }, { preserveScroll: true });
};

watch(localCategoryId, (newValue) => {
    filterProducts();
});
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
                <!-- Búsqueda por nombre -->
                <div class="min-w-[200px] flex-1 space-y-1">
                    <Label for="search" class="text-xs text-muted-foreground">Buscar productos</Label>
                    <div class="relative">
                        <Search class="absolute top-1/2 left-3 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" @keyup.enter="filterProducts" />
                    </div>
                </div>

                <!-- Filtro por categoría -->
                <div class="min-w-[200px] space-y-1">
                    <Label for="category" class="text-xs text-muted-foreground">Filtrar por categoría</Label>
                    <Select v-model="localCategoryId">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Seleccionar categoría" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todas las categorías</SelectItem>
                            <SelectItem v-for="category in categories" :key="category.id" :value="category.id.toString()">
                                {{ category.name }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Botones de acción -->
                <div class="flex gap-2">
                    <Button @click="filterProducts" :disabled="loading" variant="default" size="sm">
                        <Search class="mr-2 h-4 w-4" />
                        Filtrar
                    </Button>
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
                                <TableHead>Fecha de Creacion</TableHead>

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
                                <TableCell class="font-medium"> {{ product.created_at }} </TableCell>

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
