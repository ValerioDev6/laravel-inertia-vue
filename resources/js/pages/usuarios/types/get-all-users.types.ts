import { IUsersResponse } from '../interfaces/users.interface';

interface Success {
    ok: true;
    data: IUsersResponse;
}

interface Error {
    ok: false;
    message?: string;
}

export type GetAllUsersResponse = Success | Error;
