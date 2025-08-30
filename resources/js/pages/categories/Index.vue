<script setup lang="ts">
import { usePagination } from '@/common/composable/usePagination';
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';
import { useCategories } from './composable/useCategories';
const { page, goToPage, resetPage } = usePagination();
const { categories } = useCategories();
const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Categories',
        href: '/categories',
    },
];
</script>

<template>
    <Head title="Productos" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <h2>Categorias</h2>
        </div>
    </AppLayout>
</template>
<style scoped></style>
