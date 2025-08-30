<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;

class File extends Model
{
    protected $table = 'files';

    protected $fillable = [
        'filename',
        'path'
    ];

    /** ------------------- Relaciones ------------- */

    public function user(): HasOne
    {
        return $this->hasOne(User::class, 'file_id');
    }
}
