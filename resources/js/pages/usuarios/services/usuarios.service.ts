import { BASE_API } from '@/config/axios';
import { GetAllUsersResponse } from '../types/get-all-users.types';

export class UsersService {
    async getAllUsers(search: string, email: string, state: string, page?: number): Promise<GetAllUsersResponse> {
        try {
            const { data } = await BASE_API.get('/api/usuarios', {
                params: {
                    search,
                    page,
                    state,
                    email,
                },
            });

            return {
                ok: true,
                data: data,
            };
        } catch (error) {
            return {
                ok: false,
                message: `Error al obtener usuarios: ${error}`,
            };
        }
    }
}
