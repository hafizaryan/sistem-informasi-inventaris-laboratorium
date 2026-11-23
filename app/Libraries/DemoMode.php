<?php

namespace App\Libraries;

/**
 * Mode demo lokal.
 *
 * Aktif hanya jika CI_ENVIRONMENT=development DAN sitaris.demoMode=true.
 * Di environment lain nilai sitaris.demoMode diabaikan.
 */
class DemoMode
{
    public static function enabled(): bool
    {
        if (ENVIRONMENT !== 'development') {
            return false;
        }

        $value = env('sitaris.demoMode', false);

        return $value === true || (is_string($value) && strtolower(trim($value)) === 'true');
    }
}
