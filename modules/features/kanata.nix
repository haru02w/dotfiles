{
  den.aspects.kanata = {
    nixos = {
      services.kanata = {
        enable = true;
        # Only the laptop's built-in keyboard; external keyboards are untouched.
        keyboards.internal = {
          devices = [ "/dev/input/by-id/usb-ASUSTeK_Computer_Inc._N-KEY_Device-if02-event-kbd" ];
          config = ''
            (defsrc
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 del
              grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft z    x    c    v    b    n    m    ,    .    /    rsft
              lctl lmet lalt           spc            ralt rmet rctl
            )

            (defalias
              caps (tap-hold 200 200 esc lctl)
            )

            (deflayer base
              esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12 del
              grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
              @caps a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft  z    x    c    v    b    n    m    ,    .    /    rsft
              lctl  lalt lmet           spc            ralt rmet rctl
            )
          '';
        };
      };
    };
  };
}
