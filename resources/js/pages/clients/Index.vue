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
import Button from '@/components/ui/button/Button.vue';
import Input from '@/components/ui/input/Input.vue';
import Label from '@/components/ui/label/Label.vue';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';

import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head, Link, router } from '@inertiajs/vue3';
import { BadgePlus, Eye, Package, Pencil, RefreshCw, Search, Trash2, X } from 'lucide-vue-next';
import { ref } from 'vue';
import { route } from 'ziggy-js';
import { Customer } from './interfaces/customer.interface';

interface Props {
    customers: {
        data: Customer[];
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
        title: 'Clientes',
        href: '/clients',
    },
];

const loading = ref<boolean>(false);
const localSearch = ref<string>('');
const localEmail = ref<string>('');
const localDocument = ref<string>('');

const filtersCustomer = () => {
    const filters: any = {
        search: '',
        email: '',
        document: '',
    };
    if (localSearch.value.trim()) {
        filters.search = localSearch.value.trim();
    }
    if (localEmail.value.trim()) {
        filters.email = localEmail.value.trim();
    }
    if (localDocument.value.trim()) {
        filters.document = localDocument.value.trim();
    }

    router.get(route('clients.index'), filters, {
        preserveState: true,
        preserveScroll: true,
    });
};

const clearFilters = () => {
    localSearch.value = '';
    localEmail.value = '';
    localDocument.value = '';

    router.get(route('clients.index'), {}, { preserveState: true });
};

const goToPage = (page: number) => {
    const currentFilters: any = {};

    if (localSearch.value.trim()) {
        currentFilters.search = localSearch.value.trim();
    }

    if (localEmail.value.trim()) {
        currentFilters.email = localEmail.value.trim();
    }
    if (localDocument.value.trim()) {
        currentFilters.document = localDocument.value.trim();
    }

    router.get(route('roles.index'), { ...currentFilters, page }, { preserveScroll: true });
};
const confirmDelete = (id: number) => {};

const handleRefresh = () => {
    loading.value = true;
    router.reload({
        onFinish: () => (loading.value = false),
    });
};
</script>

<template>
    <Head title="Clientes" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header -->
            <div class="flex items-center gap-4">
                <div>
                    <Link :href="route('clients.create')">
                        <Button variant="outline">
                            <BadgePlus class="mr-2 h-4 w-4" />
                            crear clientes
                        </Button>
                    </Link>
                </div>

                <Button @click="handleRefresh" :disabled="loading" variant="outline" size="sm">
                    <RefreshCw :class="['mr-2 h-4 w-4', loading && 'animate-spin']" />
                    Actualizar
                </Button>
            </div>

            <!-- Filtros -->
            <div class="flex flex-wrap items-end gap-3 rounded-lg border bg-muted/30 p-4">
                <!-- Búsqueda por nombre -->
                <div class="min-w-[200px] flex-1 space-y-1">
                    <Label for="search" class="text-xs text-muted-foreground">Buscar Roles</Label>
                    <div class="relative">
                        <Search class="absolute top-1/2 left-3 h-4 w-4 -translate-y-1/2 text-muted-foreground" />
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" @keyup.enter="filtersCustomer" />
                    </div>
                </div>

                <!-- Botones de acción -->
                <div class="flex gap-2">
                    <Button @click="filtersCustomer" :disabled="loading" variant="default" size="sm">
                        <Search class="mr-2 h-4 w-4" />
                        Filtrar
                    </Button>
                    <Button @click="clearFilters" :disabled="loading" variant="outline" size="sm">
                        <X class="mr-2 h-4 w-4" />
                        Limpiar
                    </Button>
                </div>
            </div>

            <div class="flex-1">
                <div v-if="loading" class="flex items-center justify-center py-8">
                    <RefreshCw class="mr-2 h-5 w-5 animate-spin" />
                    <span class="text-sm">Cargando roles...</span>
                </div>

                <div v-else-if="props.customers.data.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                    <Package class="mb-2 h-8 w-8 text-muted-foreground" />
                    <p class="text-sm text-muted-foreground">No se encontraron clientes</p>
                </div>
                <div class="rounded-mrd border">
                    <Table>
                        <TableHeader>
                            <TableHead>Id</TableHead>
                            <TableHead>Nombre</TableHead>
                            <TableHead>Apellidos</TableHead>
                            <TableHead>Correo</TableHead>
                            <TableHead>Documento</TableHead>
                            <TableHead class="text-center">Acciones</TableHead>
                        </TableHeader>
                        <TableBody>
                            <TableRow v-for="rol in props.customers.data" :key="rol.id">
                                <TableCell> {{ rol.id }} </TableCell>
                                <TableCell> {{ rol.name }} </TableCell>
                                <TableCell> {{ rol.lastname }} </TableCell>
                                <TableCell> {{ rol.email }} </TableCell>
                                <TableCell> {{ rol.document }} </TableCell>

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
                                                <AlertDialogTitle>¿Eliminar cliente?</AlertDialogTitle>
                                                <AlertDialogDescription>
                                                    Esta acción eliminará el cliente<strong>{{ rol.name }}</strong> de forma permanente.
                                                </AlertDialogDescription>
                                            </AlertDialogHeader>
                                            <AlertDialogFooter>
                                                <AlertDialogCancel>Cancelar</AlertDialogCancel>
                                                <AlertDialogAction @click="confirmDelete(rol.id)"> Sí, eliminar </AlertDialogAction>
                                            </AlertDialogFooter>
                                        </AlertDialogContent>
                                    </AlertDialog>
                                </TableCell>
                            </TableRow>
                        </TableBody>
                    </Table>
                </div>
            </div>
        </div>

        <!-- Paginación e info -->
        <div v-if="!loading && props.customers.data.length > 0" class="flex items-center justify-between">
            <span class="text-sm text-muted-foreground"> {{ props.customers.meta.total }} productos en total </span>

            <!-- PAGINACIÓN COMPLETA -->
            <div class="flex items-center gap-3">
                <!-- Página actual info -->
                <div class="text-sm text-muted-foreground">
                    Página {{ props.customers.meta.current_page }} de {{ props.customers.meta.last_page }}
                </div>

                <!-- Contcustomers de paginación -->
                <div class="flex items-center gap-2">
                    <!-- Botón Anterior -->
                    <Button
                        size="sm"
                        variant="outline"
                        @click="goToPage(props.customers.meta.current_page - 1)"
                        :disabled="props.customers.meta.current_page <= 1"
                    >
                        ← Anterior
                    </Button>

                    <!-- Input para página específica -->
                    <div class="flex items-center gap-1">
                        <span class="text-sm">Ir a:</span>
                        <input
                            type="number"
                            :value="props.customers.meta.current_page"
                            @keyup.enter="goToPage($event.target.value)"
                            :min="1"
                            :max="props.customers.meta.last_page"
                            class="w-16 rounded border px-2 py-1 text-center text-sm"
                        />
                    </div>

                    <!-- Botón Siguiente -->
                    <Button
                        size="sm"
                        variant="outline"
                        @click="goToPage(props.customers.meta.current_page + 1)"
                        :disabled="props.customers.meta.current_page >= props.customers.meta.last_page"
                    >
                        Siguiente →
                    </Button>
                </div>
            </div>
        </div>
    </AppLayout>
</template>
<style scoped></style>
