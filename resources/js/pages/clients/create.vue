<template>
    <Head title="Crear Clientes" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <h2 class="text-xl font-semibold">Crear Usuario</h2>

            <form @submit.prevent="submit" class="grid max-w-lg gap-4">
                <!-- Nombre -->
                <div class="grid gap-2">
                    <Label for="name">Nombre</Label>
                    <Input id="name" v-model="form.name" type="text" placeholder="Juan Pérez" autofocus />
                    <InputError :message="form.errors.name" />
                </div>

                <!-- LastName -->
                <div class="grid gap-2">
                    <Label for="lastname">Last Name</Label>
                    <Input id="lastname" v-model="form.lastname" type="text" placeholder="Juan Pérez" autofocus />
                    <InputError :message="form.errors.lastname" />
                </div>

                <!-- Documento -->
                <div class="grid gap-2">
                    <Label for="document">Document</Label>
                    <Input id="document" v-model="form.document" type="text" placeholder="Juan Pérez" autofocus />
                    <InputError :message="form.errors.document" />
                </div>

                <!-- Nombre -->
                <div class="grid gap-2">
                    <Label for="phone">Phone</Label>
                    <Input id="phone" v-model="form.phone" type="text" placeholder="Juan Pérez" autofocus />
                    <InputError :message="form.errors.phone" />
                </div>
                <!-- Email -->
                <div class="grid gap-2">
                    <Label for="email">Correo electrónico</Label>
                    <Input id="email" v-model="form.email" type="email" placeholder="correo@ejemplo.com" />
                    <InputError :message="form.errors.email" />
                </div>

                <!-- Botón -->
                <Button type="submit" :disabled="form.processing">
                    <LoaderCircle v-if="form.processing" class="mr-2 h-4 w-4 animate-spin" />
                    Crear Usuario
                </Button>
            </form>
        </div>
    </AppLayout>
</template>

<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, useForm } from '@inertiajs/vue3';
import { LoaderCircle } from 'lucide-vue-next';

const breadcrumbs = [
    { title: 'Clientes', href: '/clients' },
    { title: 'Crear Cliente', href: '/clients/create' },
];

const form = useForm({
    name: '',
    lastname: '',
    document: '',
    phone: '',
    email: '',
});

const submit = () => {
    form.post('/clients', {
        forceFormData: true,
    });
};
</script>

<style scoped></style>
