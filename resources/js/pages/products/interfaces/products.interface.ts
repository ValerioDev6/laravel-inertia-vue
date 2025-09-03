export interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
    stock_status?: string;
    category: {
        id: number;
        name: string;
    };
    created_at: string;
}

export interface Category {
    id: number;
    name: string;
}
