{
  perSystem =
    { pkgs, ... }:
    {
      nixvim.module = {
        lsp.servers = {
          asm_lsp.enable = true; # assembly
          clangd.enable = true; # clang
          basedpyright.enable = true; # python
          gopls.enable = true; # go
          superhtml.enable = true; # html
          cssls.enable = true; # css
          ts_ls.enable = true; # typescript
          marksman.enable = true; # markdown
          dartls.enable = true; # dart (flutter-tools disabled)
          jdtls.enable = true; # java
          nixd.enable = true; # nix
          bashls.enable = true; # bash
          lua_ls.enable = true; # lua
          jsonls.enable = true; # json
          yamlls.enable = true; # yaml
          taplo.enable = true; # toml
          sqls.enable = true; # sql
          dockerls.enable = true; # docker
          terraformls.enable = true; # terraform
        };

        plugins = {
          # rust (rust-analyzer + codelldb dap)
          rustaceanvim.enable = true;

          # enableFormat
          conform-nvim = {
            enable = true;
            autoInstall.enable = true;
            settings.formatters_by_ft = {
              python = [ "black" ];
              go = [ "gofmt" ];
              rust = [ "rustfmt" ];
              css = [ "prettier" ];
              javascript = [ "prettier" ];
              javascriptreact = [ "prettier" ];
              typescript = [ "prettier" ];
              typescriptreact = [ "prettier" ];
              markdown = [ "deno_fmt" ];
              nix = [ "nixfmt" ];
              sh = [ "shfmt" ];
              bash = [ "shfmt" ];
              lua = [ "stylua" ];
              json = [ "jsonfmt" ];
              toml = [ "taplo" ];
              sql = [ "sqlfluff" ];
              terraform = [ "terraform_fmt" ];
            };
          };

          # enableExtraDiagnostics
          lint = {
            enable = true;
            autoInstall.enable = true;
            lintersByFt = {
              sh = [ "shellcheck" ];
              bash = [ "shellcheck" ];
              nix = [
                "statix"
                "deadnix"
              ];
              markdown = [ "markdownlint-cli2" ];
              lua = [ "luacheck" ];
              sql = [ "sqlfluff" ];
              dockerfile = [ "hadolint" ];
            };
          };

          # enableDAP
          dap-python.enable = true;
          dap-go.enable = true;
          dap-lldb.enable = true;
        };

        extraPackages = with pkgs; [
          # toolchains not auto-pulled by the lsp/formatter/linter modules
          go
          gcc
          python3
          rustc
          cargo
          rust-analyzer
          nodejs
          jdk
          dart
        ];
      };
    };
}
