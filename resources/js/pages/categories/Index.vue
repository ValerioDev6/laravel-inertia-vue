<script setup lang="ts">
import ButtonPagination from '@/common/components/ButtonPagination.vue';
import { usePagination } from '@/common/composable/usePagination';
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
import Button from '@/components/ui/button/Button.vue';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head, Link, router } from '@inertiajs/vue3';
import { BadgePlus, Eye, Pencil, RefreshCw, Search, Trash2, Users, X } from 'lucide-vue-next';
import { watch } from 'vue';
import { route } from 'ziggy-js';
import { useCategories } from './composable/useCategories';
const { page, goToPage, resetPage } = usePagination();
const { categories, loading, searchTearm, pagination, getCategories, localSearch, refreshPage } = useCategories();
const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Categories',
        href: '/categories',
    },
];

watch(page, (newPage) => {
    getCategories(searchTearm.value, newPage);
});

const clearFilters = () => {
    localSearch.value = '';
};

const handleRefresh = async () => {
    await refreshPage();
};

const confirmDelete = (id: number) => {
    router.delete(route('categories.destroy', { category: id }), {
        preserveScroll: true,
        onSuccess: () => {
            refreshPage();
        },
        onError: () => {},
    });
};
const handlePageChange = (newPage: number) => {
    goToPage(newPage);
};
</script>

<template>
    <Head title="Productos" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="p2 rounded-x flex h-full flex-1 flex-col gap-4 overflow-x-auto p-2">
            <!-- Header simple -->
            <div class="flex items-center justify-between">
                <div>
                    <Link :href="route('categories.create')">
                        <Button variant="outline" size="sm" class="mr-2">
                            <BadgePlus class="mr-2 h-4 w-4" />
                            Crear
                        </Button>
                    </Link>

                    <Button @click="handleRefresh" :disabled="loading" variant="outline" size="sm">
                        <RefreshCw :class="['mr-2 h-4 w-4', loading && 'animate-spin']" />
                        Actualizar
                    </Button>
                </div>
            </div>

            <!-- Filtros compactos en una línea -->
            <div class="flex flex-wrap items-end gap-3 rounded-lg border bg-muted/30 p-4">
                <!-- Campo de búsqueda general -->
                <div class="min-w-[200px] flex-1 space-y-1">
                    <Label for="search" class="text-xs text-muted-foreground">Búsqueda general</Label>
                    <div class="relative">
                        <Search class="absolute top-1/2 left-3 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" />
                    </div>
                </div>

                <!-- Botón limpiar -->
                <div class="flex gap-2">
                    <Button @click="clearFilters" :disabled="loading" variant="outline" size="sm">
                        <X class="mr-2 h-4 w-4" />
                        Limpiar
                    </Button>
                </div>
            </div>

            <!-- Tabla de datos -->
            <div class="flex-1">
                <div v-if="loading" class="flex items-center justify-center py-8">
                    <RefreshCw class="mr-2 h-5 w-5 animate-spin" />
                    <span class="text-sm">Cargando categorias...</span>
                </div>

                <div v-else-if="categories.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                    <Users class="mb-2 h-8 w-8 text-muted-foreground" />
                    <p class="text-sm text-muted-foreground">No se encontraron categorias</p>
                </div>

                <div class="rounded-md border">
                    <Table>
                        <TableHeader>
                            <TableRow>
                                <TableHead>ID</TableHead>
                                <TableHead>Nombre</TableHead>
                                <TableHead>Descripción</TableHead>
                                <TableHead class="text-center">Acciones</TableHead>
                            </TableRow>
                        </TableHeader>

                        <TableBody>
                            <TableRow v-for="category in categories" :key="category.id">
                                <TableCell class="text-left font-medium">{{ category.id }}</TableCell>
                                <TableCell class="text-left font-medium">{{ category.name }}</TableCell>
                                <TableCell class="text-left">{{ category.description.slice(0, 20) }}</TableCell>
                                <TableCell class="flex justify-center gap-2">
                                    <Button size="sm" variant="outline"> <Eye class="h-4 w-4" /> </Button>
                                    <Link :href="route('categories.edit', category.id)">
                                        <Button size="sm" variant="outline"> <Pencil class="h-4 w-4" /> </Button>
                                    </Link>
                                    <AlertDialog>
                                        <AlertDialogTrigger as-child>
                                            <Button size="sm" variant="destructive">
                                                <Trash2 class="h-4 w-4" />
                                            </Button>
                                        </AlertDialogTrigger>

                                        <AlertDialogContent>
                                            <AlertDialogHeader>
                                                <AlertDialogTitle>¿Eliminar categoría?</AlertDialogTitle>
                                                <AlertDialogDescription>
                                                    Esta acción eliminará la categoría <strong>{{ category.name }}</strong> de forma permanente.
                                                </AlertDialogDescription>
                                            </AlertDialogHeader>
                                            <AlertDialogFooter>
                                                <AlertDialogCancel>Cancelar</AlertDialogCancel>
                                                <AlertDialogAction @click="confirmDelete(category.id)"> Sí, eliminar </AlertDialogAction>
                                            </AlertDialogFooter>
                                        </AlertDialogContent>
                                    </AlertDialog>
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </div>
            </div>

            <!-- Info simple de paginación -->
            <div v-if="!loading && categories.length > 0">
                <span class="text-sm text-muted-foreground">{{ pagination.total }} usuarios en total</span>
                <ButtonPagination :current-page="page" :total-pages="pagination.last_page" :on-page-change="handlePageChange" />
            </div>
        </div>
    </AppLayout>
</template>
<style scoped></style>
