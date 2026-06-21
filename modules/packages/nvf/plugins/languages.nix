{
  perSystem =
    { pkgs, ... }:
    {
      nvf.module.config.vim = {
        languages = {
          enableTreesitter = true;
          enableFormat = true;
          enableDAP = true;
          enableExtraDiagnostics = true;

          assembly.enable = true;
          clang.enable = true;
          python.enable = true;
          rust.enable = true;
          go.enable = true;
          html.enable = true;
          css.enable = true;
          typescript.enable = true;
          markdown.enable = true;
          dart = {
            enable = true;
            flutter-tools.enable = false;
          };
          java.enable = true;
          nix = {
            enable = true;
            lsp.servers = [ "nixd" ];
          };
          bash.enable = true;
          lua.enable = true;
          json.enable = true;
          yaml.enable = true;
          toml.enable = true;
          sql.enable = true;
          docker.enable = true;
        };

        extraPackages = with pkgs; [
          # toolchains not auto-pulled by nvf's languages.* modules
          go
          gcc
          python3
          rustc
          cargo
          nodejs
          jdk
          dart
        ];
      };
    };
}
