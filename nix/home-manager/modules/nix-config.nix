{ config, pkgs, lib, ... }:

with lib;
{
  options = {
    useFlakes = mkOption {
      type = types.bool;
    };
  };

  config = mkIf (config.useFlakes) {
    nix = {
      package = pkgs.nix;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };
  };
}
