import { useDebounceFn } from '@vueuse/core';
import { onMounted, ref, watch } from 'vue';
import { IUser } from '../interfaces/users.interface';
import { UsersService } from '../services/usuarios.service';

export const useUsersComposableV2 = () => {
    const usersService = new UsersService();

    const users = ref<IUser[]>([]);
    const loading = ref<boolean>(false);

    // ✅ Filtros locales dentro del composable
    const localSearch = ref<string>('');
    const localEmailFilter = ref<string>('');
    const localStateFilter = ref<string>('');

    // Estados internos para el servicio
    const searchTerm = ref<string>('');
    const stateFilter = ref<string>('');
    const emailFilter = ref<string>('');

    const pagination = ref({
        total: 0,
        per_page: 10,
        last_page: 1,
        current_page: 1,
        next_page_url: null as string | null,
        prev_page_url: null as string | null,
    });

    const getUsers = async (search: string = '', page: number = 1, state: string = '', email: string = '') => {
        loading.value = true;
        try {
            const result = await usersService.getAllUsers(search, email, state, page);
            if (result.ok) {
                users.value = result.data.data;
                pagination.value = {
                    total: result.data.info.total,
                    per_page: result.data.info.per_page,
                    last_page: result.data.info.last_page,
                    current_page: page,
                    next_page_url: result.data.info.next_page_url,
                    prev_page_url: result.data.info.prev_page_url,
                };
                searchTerm.value = search;
                stateFilter.value = state;
                emailFilter.value = email;
            }
        } catch (error) {
            users.value = [];
        } finally {
            loading.value = false;
        }
    };

    // ✅ UN SOLO DEBOUNCE UNIVERSAL para TODOS los filtros
    const debounceFilters = useDebounceFn((search: string, email: string, state: string) => {
        getUsers(search, 1, state, email); // Siempre página 1 cuando filtramos
    }, 1000);

    // ✅ WATCH para filtros - DENTRO del composable (lógica)
    watch(
        [localSearch, localEmailFilter, localStateFilter],
        ([search, email, state]) => {
            // Aplicar debounce solo si tiene sentido buscar
            const searchValid = search.length >= 3 || search.length === 0;
            const emailValid = email.length >= 3 || email.length === 0;

            if (searchValid && emailValid) {
                debounceFilters(search, email, state);
            }
        },
        { flush: 'post' },
    );

    const onPageChange = async (event: any) => {
        const newPage = event.page + 1;
        await getUsers(searchTerm.value, newPage, stateFilter.value, emailFilter.value);
    };

    const refreshPage = async () => {
        await getUsers(searchTerm.value, pagination.value.current_page, stateFilter.value, emailFilter.value);
    };

    onMounted(async () => {
        await getUsers();
    });

    return {
        // Estados
        users,
        loading,
        pagination,
        searchTerm,
        emailFilter,
        stateFilter,
        // ✅ Filtros locales para v-model
        localSearch,
        localEmailFilter,
        localStateFilter,
        // Métodos
        getUsers,
        refreshPage,
        onPageChange,
    };
};
