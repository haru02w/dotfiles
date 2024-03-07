# My dotfiles using NixOS
## Deploy:
  - if host has disko: 
    `sudo nix --experimental-features "nix-command flakes" run .#disko -- --mode disko --arg device '"/dev/disk"' path/to/disko.nix`
  - `sudo nixos-install --flake .#hostName`
  - if host has sops on user:
    1. `sudo ssh-keygen -t ed25519 -a 128 -f /mnt/persist/etc/ssh/ssh_host_ed25519_key`
    2. `nix-shell -p ssh-to-age --run 'cat /mnt/persist/etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age > pubkey.txt'`
    3. open `pubkey.txt` and add it to `.sops.yaml`
    4. copy backup age key to `~/.config/sops/age/keys.txt`
    5. `nix-shell -p sops --run 'sops updatekeys secrets/file.yaml`
    6. `sudo nixos-install --flake .#hostName` again

## TODO:
  - Create a split-monitor-workspaces fork myself and maintain it
  - Learn more about declarative Containers/VMs
  - Learn more about CI/CD tools like Hydra
  - Learn more about devenv and use it in project templates
