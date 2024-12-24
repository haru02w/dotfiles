{
  plugins.ollama = {
    enable = true;
    model = "llama3:8b";
  };
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>o";
      action = ":<c-u>lua require('ollama').prompt()<cr>";
      options = {
        silent = true;
        desc = "Ollama";
      };
    }
  ];
}
