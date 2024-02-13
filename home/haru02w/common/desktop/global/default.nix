{ colorScheme, ... }: {
  imports = [
    ./firefox.nix
    ./packages.nix
    ./services.nix
  ];
  inherit colorScheme;
}
