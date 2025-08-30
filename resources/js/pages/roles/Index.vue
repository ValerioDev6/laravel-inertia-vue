<script setup lang="ts">
import AppLayout from '@/layouts/AppLayout.vue';
import { BreadcrumbItem } from '@/types';
import { Head } from '@inertiajs/vue3';

const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Roles',
        href: '/roles',
    },
];
</script>

<template>
    <Head title="Roles" />
    <!-- <Transition name="slide-fade"> -->
    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
            <h2>Roles</h2>
        </div>
    </AppLayout>
    <!-- </Transition> -->
</template>
<style scoped></style>
