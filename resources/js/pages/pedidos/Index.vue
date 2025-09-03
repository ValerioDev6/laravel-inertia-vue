<script setup lang="ts">
import ButtonPagination from '@/common/components/ButtonPagination.vue';
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
import Select from '@/components/ui/select/Select.vue';
import SelectContent from '@/components/ui/select/SelectContent.vue';
import SelectItem from '@/components/ui/select/SelectItem.vue';
import SelectTrigger from '@/components/ui/select/SelectTrigger.vue';
import SelectValue from '@/components/ui/select/SelectValue.vue';
import { Table, TableBody, TableCell, TableHead, TableHeader, TableRow } from '@/components/ui/table';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import { BadgePlus, Eye, Package, Pencil, RefreshCw, Search, Trash2, X } from 'lucide-vue-next';
import { ref, watch } from 'vue';
import { route } from 'ziggy-js';
import { Orders } from './interfaces/orders.interface';

interface Props {
    orders: {
        data: Orders[];
        link: any;
        meta: {
            total: number;
            current_page: number;
            last_page: number;
            per_page: number;
        };
    };
    customers: any[];
    users: any[];
}
const props = defineProps<Props>();

const loading = ref<boolean>(false);
const localSearch = ref<string>('');
const localCustomerId = ref('');
const localUserId = ref('');

const filterOrders = () => {
    const filters: any = {
        search: '',
        customer_id: '',
        user_id: '',
    };

    if (localSearch.value.trim()) {
        filters.search = localSearch.value.trim();
    }

    if (localCustomerId.value) {
        filters.customer_id = localCustomerId.value;
    }

    if (localUserId.value) {
        filters.user_id = localUserId.value;
    }

    router.get(route('pedidos.index'), filters, {
        preserveState: true,
        preserveScroll: true,
    });
};

// Funciones
const clearFilters = () => {
    localSearch.value = '';
    localCustomerId.value = '';
    localUserId.value = '';
    router.get(route('pedidos.index'), {}, { preserveState: true });
};

const handleRefresh = () => {
    loading.value = true;
    router.reload({
        onFinish: () => (loading.value = false),
    });
};

const confirmDelete = (id: number) => {
    // router.delete(route('products.destroy', { product: id }), {
    //     preserveScroll: true,
    //     onSuccess: () => {
    //         // Producto eliminado
    //     },
    //     onError: () => {
    //         // Error
    //     },
    // });
};

const goToPage = (page: number) => {
    const currentFilters: any = {};

    if (localSearch.value.trim()) {
        currentFilters.search = localSearch.value.trim();
    }

    if (localCustomerId.value) {
        currentFilters.customer_id = localCustomerId.value;
    }

    if (localUserId.value) {
        currentFilters.user_id = localUserId.value;
    }

    router.get(route('pedidos.index'), { ...currentFilters, page }, { preserveScroll: true });
};
watch(localSearch, (newValue) => {
    // Opcional: agregar debounce para evitar muchas peticiones
    setTimeout(() => {
        filterOrders();
    }, 300); // Espera 300ms después de que el usuario deje de escribir
});
</script>

<template>
    <Head title="Pedidos" />
    <AppLayout
        :breadcrumbs="[
            {
                title: 'Pedidos',
                href: '/pedidos',
            },
        ]"
    >
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Header -->
            <div class="flex items-center justify-between">
                <div>
                    <Link :href="route('pedidos.create')">
                        <Button variant="outline" size="sm" class="mr-2">
                            <BadgePlus class="mr-2 h-4 w-4" />
                            Crear orden
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
                        <Input id="search" v-model="localSearch" placeholder="Buscar por nombre..." class="h-9 pl-9" @keyup.enter="filterOrders" />
                    </div>
                </div>

                <!-- Filtro por Cliente -->
                <div class="min-w-[200px] space-y-1">
                    <Label for="customer" class="text-xs text-muted-foreground">Filtrar por Clientes</Label>
                    <Select v-model="localCustomerId">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Seleccionar cliente" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todas los clientes</SelectItem>
                            <SelectItem v-for="customer in customers" :key="customer.id" :value="customer.id.toString()">
                                {{ customer.name }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Filtro por Users -->
                <div class="min-w-[200px] space-y-1">
                    <Label for="user" class="text-xs text-muted-foreground">Filtrar por Usuario</Label>
                    <Select v-model="localUserId">
                        <SelectTrigger class="h-9">
                            <SelectValue placeholder="Seleccionar usuario" />
                        </SelectTrigger>
                        <SelectContent>
                            <SelectItem value="all">Todos los Usuarios</SelectItem>
                            <SelectItem v-for="user in users" :key="user.id" :value="user.id.toString()">
                                {{ user.name }}
                            </SelectItem>
                        </SelectContent>
                    </Select>
                </div>

                <!-- Botones de acción -->
                <div class="flex gap-2">
                    <Button @click="filterOrders" :disabled="loading" variant="default" size="sm">
                        <Search class="mr-2 h-4 w-4" />
                        Filtrar
                    </Button>
                    <Button @click="clearFilters" :disabled="loading" variant="outline" size="sm">
                        <X class="mr-2 h-4 w-4" />
                        Limpiar
                    </Button>
                </div>

                <!-- Contenido -->
                <div class="flex-1">
                    <div v-if="loading" class="flex items-center justify-center py-8">
                        <RefreshCw class="mr-2 h-5 w-5 animate-spin" />
                        <span class="text-sm">Cargando productos...</span>
                    </div>

                    <div v-else-if="props.orders.data.length === 0" class="flex flex-col items-center justify-center py-8 text-center">
                        <Package class="mb-2 h-8 w-8 text-muted-foreground" />
                        <p class="text-sm text-muted-foreground">No se encontraron ordenes</p>
                    </div>
                    <div v-else class="rounded-md border">
                        <Table>
                            <TableHeader>
                                <TableRow>
                                    <TableHead>ID</TableHead>
                                    <TableHead>Número de Orden</TableHead>
                                    <TableHead>Cliente</TableHead>
                                    <TableHead>Total</TableHead>
                                    <TableHead>Estado</TableHead>
                                    <TableHead>Usuario</TableHead>
                                    <TableHead>Fecha de Creación</TableHead>
                                    <TableHead class="text-center">Acciones</TableHead>
                                </TableRow>
                            </TableHeader>

                            <TableBody>
                                <TableRow v-for="order in props.orders.data" :key="order.id">
                                    <TableCell class="font-medium">
                                        {{ order.id }}
                                    </TableCell>

                                    <TableCell>
                                        <div>
                                            <p class="font-medium">{{ order.order_number }}</p>
                                            <p class="text-sm text-muted-foreground">{{ order.comments?.slice(0, 50) }}...</p>
                                        </div>
                                    </TableCell>

                                    <TableCell>
                                        <span class="inline-flex items-center rounded-full bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700">
                                            {{ order.customer.full_name }}
                                        </span>
                                    </TableCell>

                                    <TableCell class="font-medium"> ${{ order.total }} </TableCell>

                                    <TableCell>
                                        <span
                                            :class="[
                                                'inline-flex items-center rounded-full px-2 py-1 text-xs font-medium',
                                                order.state === 'A' ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700',
                                            ]"
                                        >
                                            {{ order.state_label }}
                                        </span>
                                    </TableCell>

                                    <TableCell class="font-medium"> {{ order.user.name }} </TableCell>

                                    <TableCell class="font-medium"> {{ order.created_at }} </TableCell>

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
                                                    <AlertDialogTitle>¿Eliminar orden?</AlertDialogTitle>
                                                    <AlertDialogDescription>
                                                        Esta acción eliminará la orden <strong>{{ order.order_number }}</strong> de forma permanente.
                                                    </AlertDialogDescription>
                                                </AlertDialogHeader>
                                                <AlertDialogFooter>
                                                    <AlertDialogCancel>Cancelar</AlertDialogCancel>
                                                    <AlertDialogAction @click="confirmDelete(order.id)"> Sí, eliminar </AlertDialogAction>
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

            <!-- Info simple de paginación -->
            <div>
                <span class="text-sm text-muted-foreground">{{ props.orders.meta.total }} usuarios en total</span>
                <ButtonPagination
                    :current-page="props.orders.meta.current_page"
                    :total-pages="props.orders.meta.last_page"
                    :on-page-change="goToPage"
                />
            </div>
        </div>
    </AppLayout>
</template>
<style scoped></style>
