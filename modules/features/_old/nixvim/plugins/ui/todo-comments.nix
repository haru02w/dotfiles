{ den, ... }: {
  den.aspects.nixvim.homeManager.programs.nixvim = {
    plugins.todo-comments.enable = true;
  };
}
