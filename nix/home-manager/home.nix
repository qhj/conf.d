{ config, pkgs, outputs, user, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;


  imports = [
    outputs.homeManagerModules.nix-config
  ];

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting

	# pnpm
        set -gx PNPM_HOME "/home/${user}/.local/share/pnpm"
        set -gx PATH "$PNPM_HOME" $PATH
        # pnpm end
      '';
      shellAliases = {
        l = "ls -alh";
        c = "bat -pp";
	cc = "bat --paging=never";
      };
    };
    bash = {
      enable = true;
      initExtra = ''
        if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          exec fish
        fi
      '';
    };
    git = {
      enable = true;
      extraConfig = {
        credential.helper = "store";
      };
    };
  };

  home.packages = with pkgs; [
    neofetch
    neovim
    htop
    bat
    ripgrep
    fd
    tree
  ];
}

