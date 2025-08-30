import { ICategoriesResponse } from '../interfaces/categories.interface';

interface Success {
    ok: true;
    data: ICategoriesResponse;
}
interface Error {
    ok: false;
    message?: string;
}

export type GetAllCategoriesResponse = Success | Error;
