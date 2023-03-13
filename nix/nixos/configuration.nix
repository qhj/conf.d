{ config, pkgs, lib, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
  };

  users = {
    groups.qhj.gid = 1000;
    users.qhj = {
      isNormalUser = true;
      group = "qhj";
      extraGroups = [
        "wheel"
	(lib.mkIf config.virtualisation.libvirtd.enable "libvirtd")
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    parted
    age
  ];

}

