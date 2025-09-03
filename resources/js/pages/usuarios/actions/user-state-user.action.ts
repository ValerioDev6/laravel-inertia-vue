import { BASE_API } from '@/config/axios';

export const useStateUser = async (idUsuario: number, state: string) => {
    try {
        const result = await BASE_API.post('/usuarios/state', {
            IdUsuario: idUsuario,
            cState: state,
        });
        return result.data;
    } catch (error) {
        console.error('Error al actualizar estado:', error);
        throw error;
    }
};
