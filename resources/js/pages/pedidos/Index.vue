<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Pedidos',
        href: '/pedidos',
    },
];
</script>

<template>
    <Head title="Pedidos" />
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <h2>pedidos</h2>
        </div>
    </AppLayout>
</template>
<style scoped></style>
