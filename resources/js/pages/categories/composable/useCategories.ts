import { useDebounceFn } from '@vueuse/core';
import { onMounted, ref, watch } from 'vue';
import { ICategories } from '../interfaces/categories.interface';
import { CategoriesService } from '../services/categorias.service';

export const useCategories = () => {
    const categoriesService = new CategoriesService();

    const categories = ref<ICategories[]>([]);
    const loading = ref<boolean>(false);

    const searchTearm = ref<string>('');
    const localSearch = ref<string>('');

    const pagination = ref({
        total: 0,
        per_page: 10,
        last_page: 1,
        current_page: 1,
        next_page_url: null as string | null,
        prev_page_url: null as string | null,
    });

    const getCategories = async (search: string = '', page: number = 1) => {
        loading.value = true;
        try {
            const result = await categoriesService.getAllCategories(search, page);
            if (result.ok) {
                categories.value = result.data.data;
                pagination.value = {
                    total: result.data.info.total,
                    per_page: result.data.info.per_page,
                    last_page: result.data.info.last_page,
                    current_page: page,
                    next_page_url: result.data.info.next_page_url,
                    prev_page_url: result.data.info.prev_page_url,
                };
                searchTearm.value = search;
            }
        } catch (error) {
            categories.value = [];
        } finally {
            loading.value = false;
        }
    };

    const onPageChange = async (event: any) => {
        const newPage = event.page + 1;
        await getCategories(searchTearm.value, newPage);
    };

    const refreshPage = async () => {
        await getCategories(searchTearm.value);
    };

    const debounceFilters = useDebounceFn((search: string) => {
        getCategories(search, 1);
    }, 1000);

    watch(
        [localSearch],
        ([search]) => {
            // Aplicar debounce solo si tiene sentido buscar
            const searchValid = search.length >= 3 || search.length === 0;

            if (searchValid) {
                debounceFilters(search);
            }
        },
        { flush: 'post' },
    );

    onMounted(async () => {
        await getCategories();
    });

    return {
        // estados
        categories,
        loading,
        pagination,
        searchTearm,

        // filtros locales
        localSearch,

        // metodosk
        getCategories,
        refreshPage,
        onPageChange,
    };
};
