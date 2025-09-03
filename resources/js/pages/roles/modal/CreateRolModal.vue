<template>
    <Dialog v-model:open="isOpen">
        <DialogContent class="sm:max-w-[425px]">
            <form @submit.prevent="onSubmit">
                <DialogHeader>
                    <DialogTitle>Crear Rol</DialogTitle>
                    <DialogDescription> Completa los campos para crear un nuevo rol. </DialogDescription>
                </DialogHeader>
                <div class="grid gap-4 py-4">
                    <div class="grid gap-3">
                        <Label htmlFor="name">Name</Label>
                        <Input id="name" name="name" v-model="form.name" />
                        <InputError :message="form.errors.name" />
                    </div>
                    <div class="grid gap-3">
                        <Label htmlFor="slug">Slug</Label>
                        <Input id="slug" name="slug" v-model="form.slug" />
                        <InputError :message="form.errors.slug" />
                    </div>
                </div>
                <DialogFooter>
                    <DialogClose asChild>
                        <Button type="button" variant="outline" @click="close"> Cancel </Button>
                    </DialogClose>
                    <Button type="submit" :disabled="form.processing">
                        <LoaderCircle v-if="form.processing" class="mr-2 h-4 w-4 animate-spin" />
                        guardar rol
                    </Button>
                </DialogFooter>
            </form>
        </DialogContent>
    </Dialog>
</template>

<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import { Button } from '@/components/ui/button';
import { Dialog, DialogClose, DialogContent, DialogDescription, DialogFooter, DialogHeader, DialogTitle } from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { useForm } from '@inertiajs/vue3';
import { LoaderCircle } from 'lucide-vue-next';
import { ref } from 'vue';
import { route } from 'ziggy-js';

const isOpen = ref(false);

const form = useForm({
    slug: '',
    name: '',
});

const emit = defineEmits(['created']);

const open = () => {
    isOpen.value = true;
    form.clearErrors();
};

const close = () => {
    isOpen.value = false;
    form.reset();
};

const onSubmit = () => {
    form.post(route('roles.store'), {
        onSuccess: () => {
            close();
            emit('created');
        },
    });
};

defineExpose({ open, close });
</script>

<style scoped></style>
