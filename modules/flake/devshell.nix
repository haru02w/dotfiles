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
          nh
        ];

        shellHook = ''
          export SOPS_AGE_KEY_FILE="''${SOPS_AGE_KEY_FILE:-$HOME/.config/sops/age/keys.txt}"

          # Point nh at this flake (repo root) for os/home rebuilds.
          flakeRoot="$(${pkgs.git}/bin/git rev-parse --show-toplevel 2>/dev/null || echo "$PWD")"
          export NH_OS_FLAKE="$flakeRoot"
          export NH_HOME_FLAKE="$flakeRoot"
        '';
      };
    };
}
