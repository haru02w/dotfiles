{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) getExe';
in {
  imports = [./setup];

  modules.programs.sops.enable = true;
  programs.git = {
    enable = true;
    userName = "Haru02w";
    userEmail = "haru02w@protonmail.com";
  };

  modules.presets.desktop-v2 = {
    enable = true;
    sway.extraKeybindings = {
      "XF86Launch4" = "exec '${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar'";
      "XF86KbdBrightnessUp" = "exec ${pkgs.asusctl}/bin/asusctl -n";
      "XF86KbdBrightnessDown" = "exec ${pkgs.asusctl}/bin/asusctl -p";
    };
  };
  wayland.windowManager.sway.extraConfig = ''
    bindswitch --locked lid:on exec ${getExe' config.services.kanshi.package "kanshictl"} switch docked
    bindswitch --locked lid:off exec ${getExe' config.services.kanshi.package "kanshictl"} switch docked-lid-closed
  '';
  programs.waybar.settings.mainBar = {
    modules-left = lib.mkBefore ["custom/fanprofiles"];
    "custom/fanprofiles" = {
      interval = "once";
      signal = 8;
      format = "{}";
      exec-on-event = false;
      on-click = "${pkgs.asusctl}/bin/asusctl profile -n; ${pkgs.procps}/bin/pkill -RTMIN+8 waybar";
      exec = let
        script = pkgs.writeShellScriptBin "fanprofiles.sh" ''
          RETURN=$(${pkgs.asusctl}/bin/asusctl profile -p)

          if [[ $RETURN = *"Performance"* ]]
          then
              echo "󱑴"
          elif [[ $RETURN = *"Balanced"* ]]
          then
              echo "󱑳"
          elif [[ $RETURN = *"Quiet"* ]]
          then
              echo "󱑲"
          fi
        '';
      in "${script}/bin/fanprofiles.sh"; # WARN
      escape = true;
    };
  };

  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.4;
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.4;
            mode = "1920x1080@60";
            status = "enable";
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
      {
        profile.name = "docked-lid-closed";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "HDMI-A-1";
            mode = "1920x1080@60";
            status = "enable";
          }
        ];
      }
    ];
  };

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/haru02w/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}
