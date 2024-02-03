# My dotfiles using NixOS

## Notes to myself
 - `sudo nixos-rebuild switch --flake .`
   rebuild the nixos config
 - `home-manager switch --flake .` if not in NixOS (probably won't work anyway)
   rebuild home-manager stuff
 - Zephyrus disk layout:
   - "$DISK"p1 /boot fat32 1G
   - "$DISK"p2 swap 16G
   - "$DISK"p3 luks -> btrfs
     - subvol=root /
     - subvol=nix /nix
     - subvol=persist /persist

## TODO:
 - Learn more about declarative Containers/VMs
 - Learn more about CI/CD tools like Hydra
 - Learn more about devenv and use it in project templates
