<script setup lang="ts">
import NavFooter from '@/components/NavFooter.vue';
import NavMain from '@/components/NavMain.vue';
import NavUser from '@/components/NavUser.vue';
import { Sidebar, SidebarContent, SidebarFooter, SidebarHeader, SidebarMenu, SidebarMenuButton, SidebarMenuItem } from '@/components/ui/sidebar';
import { dashboard } from '@/routes';
import { type NavItem } from '@/types';
import { Link } from '@inertiajs/vue3';
import { BarChart3, BookOpen, FolderTree, LayoutDashboard, Lock, Package, Shield, ShoppingCart, UserCog, Users } from 'lucide-vue-next';
import AppLogo from './AppLogo.vue';

const mainNavItems: NavItem[] = [
    {
        title: 'Dashboard',
        href: dashboard(),
        icon: LayoutDashboard, // 📊 Dashboard moderno
    },
    {
        title: 'Pedidos',
        href: '/pedidos',
        icon: ShoppingCart, // 🛒 Carrito de compras
    },
    {
        title: 'Clientes',
        href: '/clients',
        icon: Users, // 👥 Múltiples usuarios
    },
    {
        title: 'Categorías',
        href: '/categories',
        icon: FolderTree, // 📂 Carpetas organizadas
    },
    {
        title: 'Products',
        href: '/products',
        icon: Package, // 📦 Paquete/producto
    },
    {
        title: 'Usuarios',
        href: '/usuarios',
        icon: UserCog, // ⚙️👤 Usuario con configuración
    },
    {
        title: 'Roles',
        href: '/roles',
        icon: Shield, // 🛡️ Escudo de seguridad
    },
    {
        title: 'Permisos',
        href: '/permisos',
        icon: Lock, // 🔒 Candado de permisos
    },
    {
        title: 'Reportes',
        href: '/reportes',
        icon: BarChart3, // 📈 Gráfico de barras
    },
];

const footerNavItems: NavItem[] = [
    {
        title: 'Documentation',
        href: 'https://laravel.com/docs/starter-kits#vue',
        icon: BookOpen,
    },
];
</script>

<template>
    <Sidebar collapsible="icon" variant="inset">
        <SidebarHeader>
            <SidebarMenu>
                <SidebarMenuItem>
                    <SidebarMenuButton size="lg" as-child>
                        <Link :href="dashboard()">
                            <AppLogo />
                        </Link>
                    </SidebarMenuButton>
                </SidebarMenuItem>
            </SidebarMenu>
        </SidebarHeader>

        <SidebarContent>
            <NavMain :items="mainNavItems" />
        </SidebarContent>

        <SidebarFooter>
            <NavFooter :items="footerNavItems" />
            <NavUser />
        </SidebarFooter>
    </Sidebar>
    <slot />
</template>
