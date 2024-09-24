{ pkgs, lib, ... }:
with lib.nixvim; {
  plugins.dap = {
    enable = true;
    extensions = {
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };
    adapters = {
      executables = {
        cppdbg = {
          command =
            "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
          id = "cppdbg";
        };
      };
      servers = {
        lldb = {
          port = "\${port}";
          executable = {
            command =
              "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
            args = [ "--port" "\${port}" ];
          };
        };
        codelldb = {
          port = "\${port}";
          executable = {
            command =
              "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
            args = [ "--port" "\${port}" ];
          };
        };
      };
    };
  };
  extraConfigLua = ''
    local dap, dapui = require('dap'), require('dapui')
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "''${workspaceFolder}",
        stopAtEntry = true,
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "''${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      },
    }
    dap.configurations.c = dap.configurations.cpp
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
      key = "<F17>";
      action = mkRaw "dap.terminate";
      options = {
        silent = true;
        desc = "debug: terminate program";
      };
    }
    {
      mode = "n";
      key = "<F17>"; # Shift + F5
      action = mkRaw "dap.terminate";
      options = {
        silent = true;
        desc = "debug: terminate program";
      };
    }
    {
      mode = "n";
      key = "<F29>"; # Control + F5
      action = mkRaw "dap.restart_frame";
      options = {
        silent = true;
        desc = "debug: restart program";
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
      key = "<F9>";
      action = mkRaw "dap.toggle_breakpoint";
      options = {
        silent = true;
        desc = "debug: toggle breakpoint";
      };
    }
    {
      mode = "n";
      key = "<F21>"; # Shift + F9
      action = mkRaw
        "function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      options = {
        silent = true;
        desc = "debug: conditional breakpoint";
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
      key = "<F10>";
      action = mkRaw "dap.step_into";
      options = {
        silent = true;
        desc = "debug: step into";
      };
    }
    {
      mode = "n";
      key = "<F23>"; # Shift + F11
      action = mkRaw "dap.step_out";
      options = {
        silent = true;
        desc = "debug: step out";
      };
    }
  ];
}
