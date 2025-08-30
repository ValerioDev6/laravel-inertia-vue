<script setup lang="ts">
import ButtonPagination from '@/common/components/ButtonPagination.vue';
import { usePagination } from '@/common/composable/usePagination';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import DataTable from '@/components/ui/data-table/DataTable.vue';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { columns } from '@/utils/TableColumns/usuario.columns';
import { Head, Link } from '@inertiajs/vue3';
import { BadgePlus, Filter, RefreshCw, Search, Users, X } from 'lucide-vue-next';
import { ref, watch } from 'vue';
import { useUsersComposable } from './composables/useUsers.composable';

const { users, loading, pagination, getUsers, searchTearm, stateFilter, emailFilter, debounceSearch } = useUsersComposable();
const { page, goToPage, resetPage } = usePagination();
const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Usuarios',
        href: '/users',
    },
];

const localSearch = ref('');
const localStateFilter = ref('');
const localEmailFilter = ref('');

const stateOptions = [
    { value: 'A', label: 'Activo' },
    { value: 'I', label: 'Inactivo' },
];

watch(
    page,
    (newPage) => {
        getUsers(searchTearm.value, newPage, stateFilter.value, emailFilter.value);
    },
    { immediate: true },
);

watch(localSearch, (newValue) => {
    debounceSearch(newValue);
});

const applyFilters = async () => {
    await getUsers(localSearch.value, 1, localStateFilter.value, localEmailFilter.value);
};

// Función para limpiar todos los filtros
const clearFilters = async () => {
    localSearch.value = '';
    localStateFilter.value = '';
    localEmailFilter.value = '';
    await getUsers('', 1, '', '');
};

// Función para refrescar la página manteniendo filtros
const handleRefresh = async () => {
    await getUsers(searchTearm.value, page.value, stateFilter.value, emailFilter.value);
};

const handlePageChange = (newPage: number) => {
    goToPage(newPage);
};
</script>

<template>
    <Head title="Usuarios" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header simple -->
            <div class="flex items-center justify-between">
                <div class="flex items-center gap-2">
                    <Users class="h-6 w-6" />
                    <h2 class="text-2xl font-bold">Usuarios</h2>
                </div>
                <div>
                    <Link href="/usuarios/create">
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

                <!-- Filtro por email -->
                <div class="min-w-[180px] flex-1 space-y-1">
                    <Label for="email" class="text-xs text-muted-foreground">Email</Label>
                    <Input id="email" v-model="localEmailFilter" type="email" placeholder="email@ejemplo.com" class="h-9" />
                </div>

                <!-- Select de estado -->
                <div class="min-w-[140px] space-y-1">
                    <Label class="text-xs text-muted-foreground">Estado</Label>
                    <Select v-model="localStateFilter">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Estado" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem v-for="option in stateOptions" :key="option.value" :value="option.value">
                                {{ option.label }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Botones -->
                <div class="flex gap-2">
                    <Button @click="applyFilters" :disabled="loading" size="sm">
                        <Filter class="mr-2 h-4 w-4" />
                        Filtrar
                    </Button>

                    <Button @click="clearFilters" :disabled="loading" variant="outline" size="sm">
                        <X class="mr-2 h-4 w-4" />
                        Limpiar
                    </Button>
                </div>
            </div>

            <!-- Filtros activos (si existen) -->
            <div v-if="searchTearm || stateFilter || emailFilter" class="flex flex-wrap items-center gap-2">
                <span class="text-sm text-muted-foreground">Filtros:</span>

                <Badge v-if="searchTearm" variant="secondary" class="gap-1">
                    "{{ searchTearm }}"
                    <Button
                        @click="
                            localSearch = '';
                            debounceSearch('');
                        "
                        variant="ghost"
                        size="sm"
                        class="ml-1 h-auto p-0 hover:bg-transparent"
                    >
                        <X class="h-3 w-3" />
                    </Button>
                </Badge>

                <Badge v-if="emailFilter" variant="secondary" class="gap-1">
                    {{ emailFilter }}
                    <Button
                        @click="
                            localEmailFilter = '';
                            applyFilters();
                        "
                        variant="ghost"
                        size="sm"
                        class="ml-1 h-auto p-0 hover:bg-transparent"
                    >
                        <X class="h-3 w-3" />
                    </Button>
                </Badge>

                <Badge v-if="stateFilter" variant="secondary" class="gap-1">
                    {{ stateOptions.find((opt) => opt.value === stateFilter)?.label }}
                    <Button
                        @click="
                            localStateFilter = '';
                            applyFilters();
                        "
                        variant="ghost"
                        size="sm"
                        class="ml-1 h-auto p-0 hover:bg-transparent"
                    >
                        <X class="h-3 w-3" />
                    </Button>
                </Badge>
            </div>

            <!-- Tabla de datos -->
            <div class="flex-1">
                <div v-if="loading" class="flex items-center justify-center py-8">
                    <RefreshCw class="mr-2 h-5 w-5 animate-spin" />
                    <span class="text-sm">Cargando usuarios...</span>
                </div>

                <div v-else-if="users.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                    <Users class="mb-2 h-8 w-8 text-muted-foreground" />
                    <p class="text-sm text-muted-foreground">No se encontraron usuarios</p>
                </div>

                <DataTable v-else :columns="columns" :data="users" />
            </div>

            <!-- Info simple de paginación -->
            <div v-if="!loading && users.length > 0">
                <span>{{ pagination.total }} usuarios en total</span>
                <ButtonPagination :current-page="page" :total-pages="pagination.last_page" :on-page-change="handlePageChange" />
            </div>
        </div>
    </AppLayout>
</template>
