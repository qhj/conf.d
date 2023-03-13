{ pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/server.nix
  ];

  system.stateVersion = "22.11";

  boot.loader.efi.efiSysMountPoint = "/efi";

  time.timeZone = "Asia/Shanghai";

  networking = {
    hostName = "ms10";
    defaultGateway = "192.168.77.1";
    nameservers = [ "192.168.77.1" ];
    bridges.br0.interfaces = [ "enp3s0f0" ];
    interfaces.br0.ipv4.addresses = [{
      address = "192.168.77.2";
      prefixLength = 24;
    }];
  };

  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      nas = {
        path = "/smb";
        writeable = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  security.polkit.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
        };
      };
    };
  };
}
