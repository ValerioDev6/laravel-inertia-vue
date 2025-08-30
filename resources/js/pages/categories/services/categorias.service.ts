import { BASE_API } from '@/config/axios';

export class CategoriesService {
    async getAllCategories(search: string, page?: number) {
        try {
            const { data } = await BASE_API.get('/api/categories', {
                params: {
                    search,
                    page,
                },
            });

            return {
                ok: true,
                data: data,
            };
        } catch (error) {
            return {
                ok: false,
                message: `Error al obtener categories: ${error}`,
            };
        }
    }
}
