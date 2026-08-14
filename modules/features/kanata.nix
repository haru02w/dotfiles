{
  den.aspects.kanata = {
    nixos = {
      services.kanata = {
        enable = true;
        keyboards.internal = {
          extraDefCfg = ''
            concurrent-tap-hold yes
            process-unmapped-keys yes
          '';
          config = ''
            (defsrc
              a    s    d    f    j    k    l    ;
            )

            (defvar
              tap-timeout  200
              hold-timeout 200
              left-keys  (q w e r t a s d f g z x c v b)
              right-keys (y u i o p h j k l ; n m , . /)
            )

            (defalias
              a (tap-hold-tap-keys $tap-timeout $hold-timeout a lmet $left-keys)
              s (tap-hold-tap-keys $tap-timeout $hold-timeout s lalt $left-keys)
              d (tap-hold-tap-keys $tap-timeout $hold-timeout d lctl $left-keys)
              f (tap-hold-tap-keys $tap-timeout $hold-timeout f lsft $left-keys)
              j (tap-hold-tap-keys $tap-timeout $hold-timeout j rsft $right-keys)
              k (tap-hold-tap-keys $tap-timeout $hold-timeout k rctl $right-keys)
              l (tap-hold-tap-keys $tap-timeout $hold-timeout l ralt $right-keys)
              scln (tap-hold-tap-keys $tap-timeout $hold-timeout ; rmet $right-keys)
            )

            (deflayer default
              @a   @s   @d   @f   @j   @k   @l   @scln
            )
          '';
        };
      };
    };
  };
}
