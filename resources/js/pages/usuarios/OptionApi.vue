<script lang="ts">
import Button from '@/components/ui/button/Button.vue';
import DataTable from '@/components/ui/data-table/DataTable.vue';
import Input from '@/components/ui/input/Input.vue';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { columns } from '@/utils/TableColumns/usuario.columns';
import { Head as HeadComponent } from '@inertiajs/vue3';
import axios from 'axios';
import { Eraser } from 'lucide-vue-next';
export default {
    components: {
        AppLayout,
        HeadComponent,
        DataTable,
        Input,
        Button,
        Select,
        SelectContent,
        SelectItem,
        SelectTrigger,
        SelectValue,
        Eraser,
    },
    data() {
        return {
            breadcrumbs: [{ title: 'Usuarios', href: '/usuarios' }] as BreadcrumbItem[],

            fillBsqUsuario: {
                cNombre: '',
                cCorreo: '',
                cEstado: '',
                nIdUsuario: 0,
            },

            listarUsuarios: [],
            loading: false,

            listEstados: [
                // { value: '', label: 'Todos' },
                { value: 'A', label: 'Activo' },
                { value: 'I', label: 'Inactivo' },
            ],

            columns, // Columnas de la tabla
        };
    },

    mounted() {
        // Cargar usuarios al iniciar
        this.buscarUsuarios();
    },

    methods: {
        async buscarUsuarios() {
            this.loading = true;

            try {
                const response = await axios.get('/api/usuarios', {
                    params: {
                        cNombre: this.fillBsqUsuario.cNombre,
                        cCorreo: this.fillBsqUsuario.cCorreo,
                        cEstado: this.fillBsqUsuario.cEstado,
                        nIdUsuario: this.fillBsqUsuario.nIdUsuario,
                    },
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                    },
                });
                if (response.data.success) {
                    this.listarUsuarios = response.data.data;
                    console.log(response.data.data);
                }
            } catch (error) {
                console.error('Error al cargar usuarios:', error);
            } finally {
                this.loading = false;
            }
        },

        limpiarFiltros() {
            this.fillBsqUsuario = {
                cNombre: '',
                cCorreo: '',
                cEstado: '',
                nIdUsuario: 0,
            };
            this.buscarUsuarios();
        },
    },
};
</script>
<template>
    <HeadComponent title="Usuarios" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <!-- Filtros de búsqueda -->
            <div class="mb-4 grid grid-cols-1 gap-4 md:grid-cols-4">
                <Input v-model="fillBsqUsuario.cNombre" type="text" placeholder="Buscar por nombre" />
                <Input v-model="fillBsqUsuario.cCorreo" type="text" placeholder="Buscar por correo" />
                <!-- <Select v-model="fillBsqUsuario.cEstado">
                    <SelectTrigger>
                        <SelectValue placeholder="Seleccionar estado" />
                    </SelectTrigger>

                    <SelectContent>
                        <SelectItem v-for="estado in listEstados" :key="estado.value" :value="estado.value">
                            {{ estado.label }}
                        </SelectItem>
                    </SelectContent>
                </Select> -->
                <Select v-model="fillBsqUsuario.cEstado">
                    <SelectTrigger>
                        <SelectValue placeholder="Estado Usuario" />
                    </SelectTrigger>
                    <SelectContent>
                        <SelectItem v-for="estado in listEstados" :key="estado.value" :value="estado.value">
                            {{ estado.label }}
                        </SelectItem>
                    </SelectContent>
                </Select>
                <!-- <select v-model="fillBsqUsuario.cEstado" class="rounded border px-3 py-2">
                    <option v-for="estado in listEstados" :key="estado.value" :value="estado.value">
                        {{ estado.label }}
                    </option>
                </select> -->

                <Button @click="limpiarFiltros" class="w-20"> <Eraser /> </Button>
                <Button @click="buscarUsuarios" :disabled="loading">
                    {{ loading ? 'Buscando...' : 'Buscar' }}
                </Button>
            </div>

            <div v-if="loading" class="py-4 text-center">Cargando...</div>
            <DataTable v-else :columns="columns" :data="listarUsuarios" />

            <div class="mt-2 text-sm text-gray-600">Total usuarios: {{ listarUsuarios.length }}</div>
        </div>
    </AppLayout>
</template>
