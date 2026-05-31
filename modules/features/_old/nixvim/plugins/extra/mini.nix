{ den, ... }:
{
  den.aspects.nixvim.homeManager =
    { lib, ... }:
    with lib.nixvim;
    {
      programs.nixvim = {
        plugins.mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            # movement
            surround = { }; # prefix sa
            ai = {
              custom_textobjects = {
                "=" = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@assignment.outer',
                    i = '@assignment.inner',
                  })
                '';
                a = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@parameter.outer',
                    i = '@parameter.inner',
                  })
                '';
                i = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@conditional.outer',
                    i = '@conditional.inner',
                  })
                '';
                l = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@loop.outer',
                    i = '@loop.inner',
                  })
                '';
                f = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@call.outer',
                    i = '@call.inner',
                  })
                '';
                m = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@function.outer',
                    i = '@function.inner',
                  })
                '';
                c = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@class.outer',
                    i = '@class.inner',
                  })
                '';
                t = mkRaw ''
                  require('mini.ai').gen_spec.treesitter({
                    a = '@comment.outer',
                    i = '@comment.inner',
                  })
                '';
              };
            };
            # ui
            icons = { };
            cursorword = { };
            hipatterns = { };
            indentscope.draw.animation = mkRaw "require('mini.indentscope').gen_animation.none()";
            trailspace = { };
            map = { };
          };
        };
        keymaps = [
          {
            mode = "n";
            key = "<leader>tmm";
            action = mkRaw "MiniMap.toggle";
            options.desc = "Toggle minimap";
          }
        ];
      };
    };
}
