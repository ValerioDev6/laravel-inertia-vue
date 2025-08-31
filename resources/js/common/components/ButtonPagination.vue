<template>
    <div class="flex items-center justify-between border-t text-sm text-muted-foreground">
        <!-- Botón Anterior -->
        <Button
            :disabled="currentPage === 1"
            @click="onPreviousPage"
            class="flex items-center space-x-1.5 rounded-lg bg-blue-800 px-4 py-1.5 text-white transition-all hover:bg-blue-950 disabled:bg-gray-300"
        >
            <ChevronLeft :size="20" />
            <span>Anteriores</span>
        </Button>

        <!-- Centro: Info + Input para saltar a página -->
        <div class="flex items-center gap-4">
            <!-- Info de página actual -->
            <div class="flex items-center px-4 py-1.5 text-sm text-gray-600">Página {{ currentPage }} de {{ totalPages }}</div>

            <!-- Input para ir a página específica -->
            <div class="flex items-center gap-2">
                <span class="text-xs text-gray-500">Ir a:</span>
                <Input
                    v-model.number="pageInput!"
                    @keyup.enter="goToSpecificPage"
                    type="number"
                    min="1"
                    :max="totalPages"
                    placeholder=""
                    class="h-8 w-20 text-center text-sm"
                />
                <Button
                    @click="goToSpecificPage"
                    :disabled="!isValidPageInput"
                    class="h-8 rounded bg-blue-600 px-4 text-xs text-white hover:bg-blue-700 disabled:bg-gray-300"
                >
                    Ir
                </Button>
            </div>
        </div>

        <!-- Botón Siguiente -->
        <Button
            :disabled="currentPage >= totalPages"
            @click="onNextPage"
            class="flex items-center space-x-1.5 rounded-lg bg-blue-800 px-4 py-1.5 text-white transition-all hover:bg-blue-950 disabled:bg-gray-300"
        >
            <span>Siguientes</span>
            <ChevronRight :size="20" />
        </Button>
    </div>
</template>

<script setup lang="ts">
import Button from '@/components/ui/button/Button.vue';
import Input from '@/components/ui/input/Input.vue';
import { ChevronLeft, ChevronRight } from 'lucide-vue-next';
import { computed, ref } from 'vue';

interface Props {
    currentPage: number;
    totalPages: number;
    onPageChange: (page: number) => void;
}

const props = defineProps<Props>();

// Input para página específica
const pageInput = ref<number | null>(null);

// Validar si el input es válido
const isValidPageInput = computed(() => {
    return pageInput.value && pageInput.value >= 1 && pageInput.value <= props.totalPages && pageInput.value !== props.currentPage;
});

// Función para ir a página específica
const goToSpecificPage = () => {
    if (isValidPageInput.value && pageInput.value) {
        props.onPageChange(pageInput.value);
        pageInput.value = null; // Limpiar input después de usar
    }
};

// Funciones de navegación existentes
const onPreviousPage = () => {
    if (props.currentPage > 1) {
        props.onPageChange(props.currentPage - 1);
    }
};

const onNextPage = () => {
    if (props.currentPage < props.totalPages) {
        props.onPageChange(props.currentPage + 1);
    }
};
</script>
