<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

import AppLayout from '@/layouts/AppLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { LoaderCircle } from 'lucide-vue-next';
import { ref } from 'vue';
import { route } from 'ziggy-js';

interface Category {
    id: number;
    name: string;
    description: string;
}

const props = defineProps<{
    category: Category;
}>();

const form = useForm({
    name: props.category.name,
    description: props.category.description,
});
const errors = ref<Record<string, string>>({});
const processing = ref(false);

const onSubmit = () => {
    if (!form.isDirty) {
        errors.value = { general: '⚠️ No hay cambios, no se envía.' };
        return;
    }
    errors.value = {};
    processing.value = true;

    form.put(route('categories.update', { category: props.category.id }), {
        onSuccess: () => {
            processing.value = false;
            errors.value = {};
            console.log('Categorias actualzidaa');
        },
        onError: (responseErrors) => {
            processing.value = false;
            errors.value = responseErrors;
        },
    });
};
</script>

<template>
    <Head title="Editar Categoria" />

    <AppLayout
        :breadcrumbs="[
            { title: 'Categorias', href: '/categories' },
            { title: 'Editar Categorias', href: `/categories/${props.category.id}/edit` },
        ]"
    >
        <div class="flex h-full flex-1 flex-col gap-6 rounded-xl p-6">
            <h1 class="text-xl font-semibold">Editar Usuario</h1>
            <p v-if="errors.general" class="text-red-500">{{ errors.general }}</p>

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
                <div class="flex justify-between p-2">
                    <Link :href="route('categories.index')">
                        <Button type="submit" variant="secondary" :disabled="processing">
                            <LoaderCircle v-if="processing" class="mr-2 h-4 w-4 animate-spin" />
                            Regresar
                        </Button>
                    </Link>
                    <Button type="submit" :disabled="processing">
                        <LoaderCircle v-if="processing" class="mr-2 h-4 w-4 animate-spin" />
                        Actualizar
                    </Button>
                </div>
            </form>
        </div>
    </AppLayout>
</template>

<style scoped></style>
