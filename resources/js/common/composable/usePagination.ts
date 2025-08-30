import { ref } from 'vue';

export const usePagination = () => {
    // ✅ Estado interno, no depende de la URL
    const page = ref(1);

    const goToPage = (newPage: number) => {
        if (newPage >= 1) {
            page.value = newPage;
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    };

    const nextPage = () => {
        page.value += 1;
        window.scrollTo({ top: 0, behavior: 'smooth' });
    };

    const previousPage = () => {
        if (page.value > 1) {
            page.value -= 1;
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    };

    const resetPage = () => {
        page.value = 1;
    };

    return {
        page,
        goToPage,
        nextPage,
        previousPage,
        resetPage,
    };
};
