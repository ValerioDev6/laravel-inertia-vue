import { useDebounceFn } from '@vueuse/core';
import { onMounted, ref } from 'vue';
import { IUser } from '../interfaces/users.interface';
import { UsersService } from '../services/usuarios.service';

export const useUsersComposable = () => {
    const usersService = new UsersService();
    const users = ref<IUser[]>([]);
    const loading = ref<boolean>(false);
    const searchTearm = ref<string>('');
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
                searchTearm.value = search;
                stateFilter.value = state;
                emailFilter.value = email;
            }
        } catch (error) {
            users.value = [];
        } finally {
            loading.value = false;
        }
    };

    const onPageChange = async (event: any) => {
        const newPage = event.page + 1;
        await getUsers(searchTearm.value, newPage, stateFilter.value, emailFilter.value);
    };

    const refreshPage = async () => {
        await getUsers(searchTearm.value, pagination.value.current_page, stateFilter.value, emailFilter.value);
    };

    const debounceSearch = useDebounceFn((value: string) => {
        getUsers(value, 1, stateFilter.value, emailFilter.value);
    }, 1000);

    onMounted(async () => {
        await getUsers();
    });

    return {
        // estados
        users,
        loading,
        pagination,
        searchTearm,
        emailFilter,
        stateFilter,
        // metodos
        getUsers,
        refreshPage,
        onPageChange,
        debounceSearch,
    };
};
