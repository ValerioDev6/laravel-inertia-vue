<?php

namespace Database\Seeders;

use App\Models\Rol;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $roles = [
            [
                'slug' => 'super-admin',
                'name' => 'Super Administrador',
            ],
            [
                'slug' => 'admin',
                'name' => 'Administrador',
            ],
            [
                'slug' => 'manager',
                'name' => 'Gerente',
            ],
            [
                'slug' => 'editor',
                'name' => 'Editor',
            ],
            [
                'slug' => 'moderator',
                'name' => 'Moderador',
            ],
            [
                'slug' => 'user',
                'name' => 'Usuario',
            ],
            [
                'slug' => 'client',
                'name' => 'Cliente',
            ],
            [
                'slug' => 'guest',
                'name' => 'Invitado',
            ],
            [
                'slug' => 'sales-manager',
                'name' => 'Gerente de Ventas',
            ],
            [
                'slug' => 'support-agent',
                'name' => 'Agente de Soporte',
            ],
            [
                'slug' => 'content-creator',
                'name' => 'Creador de Contenido',
            ],
            [
                'slug' => 'financial-manager',
                'name' => 'Gerente Financiero',
            ]
        ];


        foreach ($roles as $rolData) {
            Rol::create([
                'slug' => $rolData['slug'],
                'name' => $rolData['name']
            ]);
        }

        $this->command->info('✅ Se crearon ' . count($roles) . ' roles con exito');
    }
}
