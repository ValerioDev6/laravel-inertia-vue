<template>
    <Head title="Crear Categorias" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <h2>Crear Categorias</h2>

            <form @submit.prevent="onSubmit" class="grid max-w-lg gap-4">
                <!-- name -->
                <div class="grid gap-2">
                    <Label for="name">Nombre Categoria</Label>
                    <Input id="name" v-model="form.name" type="text" placeholder="Nombre categorias.." autofocus />
                    <InputError :message="form.errors.name" />
                </div>

                <!-- Description -->
                <div class="grid gap-2">
                    <Label for="description">Descripcion Categoria</Label>
                    <Textarea id="description" v-model="form.description" type="text" placeholder="Descripcion categorias.." autofocus />
                    <InputError :message="form.errors.description" />
                </div>

                <!-- Botón -->
                <Button type="submit" :disabled="form.processing">
                    <LoaderCircle v-if="form.processing" class="mr-2 h-4 w-4 animate-spin" />
                    Crear categorias
                </Button>
            </form>
        </div>
    </AppLayout>
</template>

<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import Button from '@/components/ui/button/Button.vue';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import { LoaderCircle } from 'lucide-vue-next';
import { route } from 'ziggy-js';
const breadcrumbs = [
    { title: 'Categorias', href: '/categories' },
    { title: 'Crear Categoria', href: '/categories/create' },
];

const form = useForm({
    name: '',
    description: '',
});

const onSubmit = () => {
    form.post(route('categories.store'), {
        forceFormData: true,
        onSuccess: () => form.reset(),
    });
};
</script>

<style scoped></style>
