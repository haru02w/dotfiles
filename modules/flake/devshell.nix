{
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          sops
          age
          ssh-to-age
          claude-code
          opencode
          nodejs
        ];

        shellHook = ''
          export SOPS_AGE_KEY_FILE="''${SOPS_AGE_KEY_FILE:-$HOME/.config/sops/age/keys.txt}"
        '';
      };
    };
}
