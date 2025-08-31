import { ICategories } from '@/pages/categories/interfaces/categories.interface';
import type { ColumnDef } from '@tanstack/vue-table';
import { h } from 'vue';

export const columns: ColumnDef<ICategories>[] = [
    {
        accessorKey: 'id',
        header: () => h('div', { class: 'text-left' }, 'ID'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('id')),
    },
    {
        accessorKey: 'name',
        header: () => h('div', { class: 'text-left' }, 'Nombre'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('name')),
    },
    {
        accessorKey: 'description',
        header: () => h('div', { class: 'text-left' }, 'Nombre'),
        cell: ({ row }) => h('div', { class: 'text-left font-medium hover:bg-muted' }, row.getValue('name')),
    },
];
