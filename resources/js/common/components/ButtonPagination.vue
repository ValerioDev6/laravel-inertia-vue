<template>
    <div class="flex items-center justify-between border-t pt-3 text-sm text-muted-foreground">
        <Button
            :disabled="currentPage === 1"
            @click="onPreviousPage"
            class="flex items-center space-x-1.5 rounded-lg bg-blue-800 px-4 py-1.5 text-white transition-all hover:bg-blue-950 disabled:bg-gray-300"
        >
            <ChevronLeft :size="20" />
            <span>Anteriores</span>
        </Button>

        <!-- Info de página actual -->
        <div class="flex items-center px-4 py-1.5 text-sm text-gray-600">Página {{ currentPage }} de {{ totalPages }}</div>

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
import { ChevronLeft, ChevronRight } from 'lucide-vue-next';

interface Props {
    currentPage: number;
    totalPages: number;
    onPageChange: (page: number) => void;
}

const props = defineProps<Props>();

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

<style scoped></style>
