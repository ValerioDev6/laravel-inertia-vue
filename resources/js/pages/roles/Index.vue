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
import CreateRolModal from './modal/CreateRolModal.vue';
interface Rol {
    id: number;
    name: string;
    slug: string;
}
interface Props {
    roles: {
        data: Rol[];
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
        title: 'Roles',
        href: '/roles',
    },
];
// estados
const loading = ref<boolean>(false);
const localSearch = ref<string>('');

const createModal = ref();
const editModal = ref();

const openCreateModal = () => {
    createModal.value.open();
};

const handleRoleCreated = () => {
    handleRefresh();
};

const filtersRoles = () => {
    const filters: any = {
        search: '',
    };
    if (localSearch.value.trim()) {
        filters.search = localSearch.value.trim();
    }

    router.get(route('roles.index'), filters, {
        preserveState: true,
        preserveScroll: true,
    });
};

const clearFilters = () => {
    localSearch.value = '';
    router.get(route('roles.index'), {}, { preserveState: true });
};

const handleRefresh = () => {
    loading.value = true;
    router.reload({
        onFinish: () => (loading.value = false),
    });
};
const confirmDelete = (id: number) => {};
const goToPage = (page: number) => {
    const currentFilters: any = {};

    if (localSearch.value.trim()) {
        currentFilters.search = localSearch.value.trim();
    }

    router.get(route('roles.index'), { ...currentFilters, page }, { preserveScroll: true });
};
</script>

<template>
    <Head title="Roles" />
    <!-- <Transition name="slide-fade"> -->
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header -->
            <div class="flex items-center gap-4">
                <div>
                    <!-- Tu contenido existente -->

                    <Button variant="outline" @click="openCreateModal">
                        <BadgePlus class="mr-2 h-4 w-4" />
                        crear rol
                    </Button>

                    <!-- El modal -->
                    <CreateRolModal ref="createModal" @created="handleRoleCreated" />
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
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" @keyup.enter="filtersRoles" />
                    </div>
                </div>

                <!-- Botones de acción -->
                <div class="flex gap-2">
                    <Button @click="filtersRoles" :disabled="loading" variant="default" size="sm">
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

                <div v-else-if="props.roles.data.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                    <Package class="mb-2 h-8 w-8 text-muted-foreground" />
                    <p class="text-sm text-muted-foreground">No se encontraron roles</p>
                </div>
                <div class="rounded-mrd border">
                    <Table>
                        <TableHeader>
                            <TableHead>Id</TableHead>
                            <TableHead>Slug</TableHead>
                            <TableHead>Nombre Rol</TableHead>
                            <TableHead class="text-center">Acciones</TableHead>
                        </TableHeader>
                        <TableBody>
                            <TableRow v-for="rol in props.roles.data" :key="rol.id">
                                <TableCell> {{ rol.id }} </TableCell>
                                <TableCell> {{ rol.slug }} </TableCell>
                                <TableCell> {{ rol.name }} </TableCell>
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
                                                <AlertDialogTitle>¿Eliminar rol?</AlertDialogTitle>
                                                <AlertDialogDescription>
                                                    Esta acción eliminará el rol <strong>{{ rol.name }}</strong> de forma permanente.
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
        <div v-if="!loading && props.roles.data.length > 0" class="flex items-center justify-between">
            <span class="text-sm text-muted-foreground"> {{ props.roles.meta.total }} productos en total </span>

            <!-- PAGINACIÓN COMPLETA -->
            <div class="flex items-center gap-3">
                <!-- Página actual info -->
                <div class="text-sm text-muted-foreground">Página {{ props.roles.meta.current_page }} de {{ props.roles.meta.last_page }}</div>

                <!-- Controles de paginación -->
                <div class="flex items-center gap-2">
                    <!-- Botón Anterior -->
                    <Button
                        size="sm"
                        variant="outline"
                        @click="goToPage(props.roles.meta.current_page - 1)"
                        :disabled="props.roles.meta.current_page <= 1"
                    >
                        ← Anterior
                    </Button>

                    <!-- Input para página específica -->
                    <div class="flex items-center gap-1">
                        <span class="text-sm">Ir a:</span>
                        <input
                            type="number"
                            :value="props.roles.meta.current_page"
                            @keyup.enter="goToPage($event.target.value)"
                            :min="1"
                            :max="props.roles.meta.last_page"
                            class="w-16 rounded border px-2 py-1 text-center text-sm"
                        />
                    </div>

                    <!-- Botón Siguiente -->
                    <Button
                        size="sm"
                        variant="outline"
                        @click="goToPage(props.roles.meta.current_page + 1)"
                        :disabled="props.roles.meta.current_page >= props.roles.meta.last_page"
                    >
                        Siguiente →
                    </Button>
                </div>
            </div>
        </div>
    </AppLayout>
    <!-- </Transition> -->
</template>
<style scoped></style>
