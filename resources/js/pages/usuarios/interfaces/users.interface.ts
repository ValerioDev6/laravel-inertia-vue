export interface IUsersResponse {
    success: boolean;
    data: IUser[];
    info: Info;
}

export interface IUser {
    id: number;
    name: string;
    email: string;
    state: string;
    file: string | null;
}

export interface Info {
    total: number;
    per_page: number;
    last_page: number;
    next_page_url: string | null;
    prev_page_url: string | null;
    current_page: number;
}
// export interface File {
//    path: string;
//}
