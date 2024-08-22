{
  environment.persistence."/persist/home" = {
    directories = [
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      "Projects"
    ];
    files = [];
    allowOther = true;
  };
}
