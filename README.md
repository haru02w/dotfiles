# dotfiles

My Nix flake. The file-structure generates the configuration: every `.nix`
under a discovered path is auto-imported, so adding a file is the same as
enabling a module.

## Build

```sh
# NixOS host
sudo nixos-rebuild switch --flake .#<host>

# Home-Manager only (e.g. work machine)
home-manager switch --flake .#<user>@<host>

# Dev shell, formatter, templates
nix develop
nix fmt
nix flake new -t .#<template> <dest>
```

## Hosts

| Host           | Kind                           | User          |
| -------------- | ------------------------------ | ------------- |
| `zephyrus`     | NixOS (ASUS Zephyrus)          | `haru02w`     |
| `zephyrus-wsl` | NixOS-WSL                      | `haru02w`     |
| `vm`           | NixOS (QEMU guest)             | `haru02w`     |
| `QIN-120868`   | Home-Manager (work, non-NixOS) | `joaomillane` |

## Layout

```
flake.nix
lib/        # helpers (auto-import, host/user discovery, pkgs-for-system)
hosts/      # per-host config (./hosts/<host>/{nixos,home-manager/<user>}/...)
modules/    # auto-imported NixOS / home-manager / nixvim modules
profiles/   # composable bundles, pulled in via the symlink chain (see below)
pkgs/       # flake packages (nixvim)
overlays/   # nixpkgs overlays
templates/  # `nix flake new -t self#<template>`
secrets/    # sops-encrypted (see `.sops.yaml`)
```

### Profile composition (symlinks)

Profiles are not auto-discovered by the flake. Each host pulls them in via a
`profile` symlink under `hosts/<host>/{nixos,home-manager/<user>}/`, and
profiles themselves symlink to the ones they extend:

```
host  ──►  desktop  ──►  cli  ──►  global
                  (or)
host  ──────────►  cli  ──►  global
```

`lib/default.nix:listFilesRecursive` follows symlinks, so the auto-import
walks the whole chain.

### Adding a host

1. `mkdir -p hosts/<host>/nixos` (and/or `hosts/<host>/home-manager/<user>`).
2. Create `hosts/<host>/default.nix` — settings file consumed by the flake:
   ```nix
   _: {
     arch = "x86_64-linux";
   }
   ```
3. Drop host-specific `.nix` files in the subdirs (e.g.
   `hardware-configuration.nix`, `setup/default.nix`). Everything under the
   dir auto-imports.
4. Link the deepest profile to inherit:
   ```sh
   ln -s ../../../profiles/desktop/nixos        hosts/<host>/nixos/profile
   ln -s ../../../../profiles/cli/home-manager  hosts/<host>/home-manager/<user>/profile
   ```
5. Add the row to the Hosts table above.
6. Build with the commands in [Build](#build).

## Secrets

Secrets live in `secrets/secrets.yaml`, encrypted with the age key listed in
`.sops.yaml`. On a fresh machine, drop the matching private key at:

```
~/.config/sops/age/keys.txt
```

before the first rebuild. `users.mutableUsers = false` means the login password
is read from sops at activation — without the key, the rebuild will fail.
