import Badge from '@/components/ui/badge/Badge.vue';
import Button from '@/components/ui/button/Button.vue';
import { Link, router } from '@inertiajs/vue3';
import type { ColumnDef } from '@tanstack/vue-table';
import { Eye, Pencil, Trash2 } from 'lucide-vue-next';
import { h } from 'vue';

export interface User {
    id: number;
    name: string;
    email: string;
    state: string;
    file: string | null;
}

export const columns: ColumnDef<User>[] = [
    {
        accessorKey: 'id',
        header: () => h('div', { class: 'text-left' }, 'ID'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('id')),
    },
    {
        accessorKey: 'file',
        header: () => h('div', { class: 'text-center' }, 'Imagen'),
        cell: ({ row }) => {
            const imagePath = row.getValue('file') as string;
            if (imagePath) {
                const fullUrl = `${import.meta.env.VITE_BASE_URL}/storage/${imagePath}`;
                return h('img', {
                    src: fullUrl,
                    alt: 'Profile',
                    class: 'w-15 h-15 rounded-full mx-auto object-cover',
                });
            }
            return h('div', { class: 'text-center text-gray-400 text-xs' }, 'Sin imagen');
        },
    },
    {
        accessorKey: 'name',
        header: () => h('div', { class: 'text-left' }, 'Nombre'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('name')),
    },
    {
        accessorKey: 'email',
        header: () => h('div', { class: 'text-left' }, 'Email'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('email')),
    },

    {
        accessorKey: 'state',
        header: () => h('div', { class: 'text-center' }, 'Estado'),
        cell: ({ row }) => {
            const estado = row.getValue('state') as string;
            const isActivo = estado === 'A';

            return h(
                'div',
                { class: 'flex justify-center ' },
                h(
                    Badge,
                    {
                        class: isActivo ? 'bg-green-100 text-green-700 font-bold' : 'bg-red-100 text-red-700 font-bold',
                    },
                    () => (isActivo ? 'ACTIVO' : 'INACTIVO'),
                ),
            );
        },
    },
    {
        id: 'actions',
        header: () => h('div', { class: 'text-center' }, 'Acciones'),
        cell: ({ row }) => {
            const id = row.getValue('id');

            return h('div', { class: 'flex justify-center gap-2' }, [
                // Ver
                h(
                    Link,
                    {
                        href: `/usuarios/${id}`,
                    },
                    () => h(Button, { size: 'sm', variant: 'outline' }, () => h(Eye, { class: 'w-4 h-4' })),
                ),

                // Editar
                h(
                    Link,
                    {
                        href: `/usuarios/${id}/edit`,
                    },
                    () => h(Button, { size: 'sm', variant: 'outline' }, () => h(Pencil, { class: 'w-4 h-4' })),
                ),

                // Eliminar
                h(
                    Button,
                    {
                        size: 'sm',
                        variant: 'destructive',
                        onClick: () => {
                            if (confirm('¿Seguro que deseas eliminar este usuario?')) {
                                router.delete(`/usuarios/${id}`);
                            }
                        },
                    },
                    () => h(Trash2, { class: 'w-4 h-4' }),
                ),
            ]);
        },
    },
];
