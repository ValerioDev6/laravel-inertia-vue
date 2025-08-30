<script lang="ts" setup>
import InputError from '@/components/InputError.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import AppLayout from '@/layouts/AppLayout.vue';
import { Head, router } from '@inertiajs/vue3';
import { LoaderCircle } from 'lucide-vue-next';
import { toast } from 'sonner';
import { computed, ref } from 'vue';
import { route } from 'ziggy-js';

interface FileDB {
    file_id: number;
    path: string;
    filename: string;
}

interface User {
    id: number;
    name: string;
    email: string;
    password: string;
    state?: string;
    file?: FileDB | null;
}

const props = defineProps<{
    user: User;
}>();

const baseUrl = import.meta.env.VITE_BASE_URL;

// Estado manual (sin useForm)
const form = ref({
    name: props.user.name,
    email: props.user.email,
    password: '',
    imagen: null as File | null,
});

// Estado manual para errores y loading
const errors = ref<Record<string, string>>({});
const processing = ref(false);

const avatarUrl = computed(() => {
    if (!props.user?.file) return null;
    return `${baseUrl}/storage/${props.user.file.path}`;
});

const onFileChange = (e: Event) => {
    const target = e.target as HTMLInputElement;
    if (target.files?.length) {
        form.value.imagen = target.files[0];
    }
};

const submit = () => {
    errors.value = {};
    processing.value = true;

    // Crear FormData manualmente
    const formData = new FormData();
    formData.append('name', form.value.name);
    formData.append('email', form.value.email);
    formData.append('password', form.value.password);
    formData.append('_method', 'PUT');

    if (form.value.imagen) {
        formData.append('imagen', form.value.imagen);
    }

    // Usar Inertia router directamente
    router.post(route('usuarios.update', { user: props.user.id }), formData, {
        preserveScroll: true,
        onSuccess: () => {
            processing.value = false;
            errors.value = {};
            form.value.password = '';
            toast.success('¡Usuario actualizado con éxito!', {
                duration: 3000,
            });
        },
        onError: (responseErrors) => {
            processing.value = false;
            errors.value = responseErrors;
        },
    });
};
</script>

<template>
    <Head title="Editar Usuario" />

    <AppLayout
        :breadcrumbs="[
            { title: 'Usuarios', href: '/usuarios' },
            { title: 'Editar Usuario', href: `/usuarios/${props.user.id}/edit` },
        ]"
    >
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <h1 class="text-xl font-semibold">Editar Usuario</h1>

            <form @submit.prevent="submit" class="grid max-w-lg gap-4">
                <!-- Nombre -->
                <div class="grid gap-2">
                    <Label for="name">Nombre</Label>
                    <Input id="name" v-model="form.name" type="text" />
                    <InputError :message="errors.name" />
                </div>

                <!-- Email -->
                <div class="grid gap-2">
                    <Label for="email">Correo electrónico</Label>
                    <Input id="email" v-model="form.email" type="email" />
                    <InputError :message="errors.email" />
                </div>

                <!-- Password (opcional) -->
                <div class="grid gap-2">
                    <Label for="password">Contraseña</Label>
                    <Input id="password" v-model="form.password" type="password" placeholder="Dejar vacío si no cambia" />
                    <InputError :message="errors.password" />
                </div>

                <!-- Imagen -->
                <div class="grid gap-2">
                    <Label for="imagen">Avatar</Label>

                    <div class="flex items-center gap-4">
                        <!-- Imagen actual -->
                        <img v-if="avatarUrl" :src="avatarUrl" alt="Avatar" class="h-12 w-12 rounded-full border object-cover" />
                        <!-- Input para nueva imagen -->
                        <Input id="imagen" type="file" @change="onFileChange" accept="image/*" />
                    </div>

                    <InputError :message="errors.imagen" />
                </div>

                <!-- Botón -->
                <Button type="submit" :disabled="processing">
                    <LoaderCircle v-if="processing" class="mr-2 h-4 w-4 animate-spin" />
                    Actualizar Usuario
                </Button>
            </form>
        </div>
    </AppLayout>
</template>
