{
  services.openssh = {
    enable = true;
    settings = {
      permitRootLogin = "no";
    };
  };
}
