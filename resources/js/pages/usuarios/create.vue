<template>
    <Head title="Crear Usuarios" />

    <AppLayout :breadcrumbs="breadcrumbs">
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <h1 class="text-xl font-semibold">Crear Usuario</h1>

            <form @submit.prevent="submit" class="grid max-w-lg gap-4">
                <!-- Nombre -->
                <div class="grid gap-2">
                    <Label for="name">Nombre</Label>
                    <Input id="name" v-model="form.name" type="text" placeholder="Juan Pérez" autofocus />
                    <InputError :message="form.errors.name" />
                </div>

                <!-- Email -->
                <div class="grid gap-2">
                    <Label for="email">Correo electrónico</Label>
                    <Input id="email" v-model="form.email" type="email" placeholder="correo@ejemplo.com" />
                    <InputError :message="form.errors.email" />
                </div>

                <!-- Password -->
                <div class="grid gap-2">
                    <Label for="password">Contraseña</Label>
                    <Input id="password" v-model="form.password" type="password" placeholder="********" />
                    <InputError :message="form.errors.password" />
                </div>

                <!-- Imagen -->
                <div class="grid gap-2">
                    <Label for="imagen">Avatar</Label>
                    <Input id="imagen" type="file" @change="onFileChange" accept="image/*" />
                    <InputError :message="form.errors.imagen" />
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
    { title: 'Usuarios', href: '/usuarios' },
    { title: 'Crear Usuario', href: '/usuarios/create' },
];

const form = useForm({
    name: '',
    email: '',
    password: '',
    imagen: null as File | null,
});

const onFileChange = (e: Event) => {
    const target = e.target as HTMLInputElement;
    if (target.files?.length) {
        form.imagen = target.files[0];
    }
};

const submit = () => {
    form.post('/usuarios', {
        forceFormData: true,
        onSuccess: () => form.reset('password'),
    });
};
</script>
