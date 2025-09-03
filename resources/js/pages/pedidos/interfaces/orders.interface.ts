export interface Orders {
    id: number;
    order_number: string;
    comments: string;
    total: string;
    state: State;
    state_label: StateLabel;
    created_at: Date;
    created_at_human: Date;
    customer: Customer;
    user: User;
}

export interface Customer {
    full_name: string;
}

export enum State {
    A = 'A',
    I = 'I',
}

export enum StateLabel {
    Activa = 'Activa',
    Inactiva = 'Inactiva',
}

export interface User {
    name: string;
}
