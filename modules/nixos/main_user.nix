{ lib, ... }:
with lib;
{
  options.users.main_user = mkOption {
    type = types.str;
    default = "alice";
    example = "haru02w";
  };
}
