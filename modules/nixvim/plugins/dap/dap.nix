{ pkgs, lib, ... }:
with lib.nixvim; {
  extraPackages = with pkgs; [ lldb gdb ];
  plugins.dap = {
    enable = true;
    extensions = {
      dap-ui = {
        enable = true;
        floating.mappings.close = [ "<ESC>" "q" ];
      };
      dap-virtual-text.enable = true;
    };
    adapters = {
      executables = {
        gdb = {
          command = "${pkgs.gdb}/bin/gdb";
          args = [ "-i" "dap" ];
        };
        lldb.command = "${pkgs.lldb}/bin/lldb-dap";
      };
      servers = {
        codelldb = {
          port = 13000;
          executable = {
            command =
              "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
            args = [ "--port" "13000" ];
          };
        };
      };
    };
    configurations = let
      program = mkRaw ''
        function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
        end
      '';
      args = mkRaw ''
        function()
          local args_string = vim.fn.input("Input arguments: ")
          return vim.split(args_string, " ")
        end
      '';
      c-cpp-rust-config = [
        {
          name = "Launch (gdb)";
          type = "gdb";
          request = "launch";
          program = program;
          args = args;
          cwd = "\${workspaceFolder}";
          stopAtEntry = false;
        }
        {
          name = "Launch (LLDB)";
          type = "lldb";
          request = "launch";
          program = program;
          args = args;
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
        {
          name = "Launch (codelldb)";
          type = "codelldb";
          request = "launch";
          program = program;
          args = args;
          cwd = "\${workspaceFolder}";
          stopOnEntry = false;
        }
      ];
    in {
      c = c-cpp-rust-config;
      cpp = c-cpp-rust-config;
      rust = c-cpp-rust-config;
    };
  };

  extraConfigLua = ''
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<F3>";
      action = mkRaw "dapui.toggle";
      options = {
        silent = true;
        desc = "toggle dap ui";
      };
    }
    {
      mode = "n";
      key = "<F5>";
      action = mkRaw "dap.continue";
      options = {
        silent = true;
        desc = "debug: continue program";
      };
    }
    {
      mode = "n";
      key = "<F4>";
      action = mkRaw "dap.terminate";
      options = {
        silent = true;
        desc = "debug: terminate program";
      };
    }
    {
      mode = "n";
      key = "<F6>";
      action = mkRaw "dap.pause";
      options = {
        silent = true;
        desc = "debug: pause program";
      };
    }
    {
      mode = "n";
      key = "<F8>";
      action = mkRaw
        "function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      options = {
        silent = true;
        desc = "debug: conditional breakpoint";
      };
    }
    {
      mode = "n";
      key = "<F9>";
      action = mkRaw "dap.toggle_breakpoint";
      options = {
        silent = true;
        desc = "debug: toggle breakpoint";
      };
    }

    {
      mode = "n";
      key = "<F10>";
      action = mkRaw "dap.step_over";
      options = {
        silent = true;
        desc = "debug: conditional breakpoint";
      };
    }
    {
      mode = "n";
      key = "<F11>";
      action = mkRaw "dap.step_into";
      options = {
        silent = true;
        desc = "debug: step into";
      };
    }
    {
      mode = "n";
      key = "<F12>";
      action = mkRaw "dap.step_out";
      options = {
        silent = true;
        desc = "debug: step out";
      };
    }
  ];
}
