export interface ICategoriesResponse {
    success: boolean;
    data: ICategories[];
    info: Info;
}

export interface ICategories {
    name: string;
    description: string;
    created_at: Date;
}
export interface Info {
    total: number;
    per_page: number;
    last_page: number;
    next_page_url: string;
    prev_page_url: null;
    current_page: number;
}
