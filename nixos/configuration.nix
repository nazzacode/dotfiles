{ config, pkgs, callPackage, ... }: {
  # ...

  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  boot.loader.systemd-boot.enable = true;  # Use the systemd-boot EFI boot loader
  boot.loader.efi.canTouchEfiVariables = true;  # no idea
  # TODO remove grub
  # TODO getwindows 10 back!!

  # Enable Nvidia
  # services.xserver.videoDrivers = [ "nvidia" ];

# # from: https://github.com/NixOS/nixos-hardware/issues/105
#   services.xserver = {
#     videoDrivers = [ "intel" ];
#     deviceSection = ''BusID "PCI:0:2:0"'';
#   };

#   hardware.bumblebee = {
#     enable = true;
#     connectDisplay = true;
#   };

#   nixpkgs.config.packageOverrides = pkgs: rec {
#     bumblebee = pkgs.bumblebee.override {
#     extraNvidiaDeviceOptions = ''
#       Option "ProbeAllGpus" "false"
#       Option "AllowEmptyInitialConfiguration"
#     EndSection

#     Section "Screen"
#       Identifier "Default Screen"
#       Device "DiscreteNvidia"
#     '';
#     };
#   };

# # From: https://github.com/rycee/nixos-hardware/blob/thinkpad-x1-extreme-gen2/lenovo/thinkpad/x1-extreme/gen2/default.nix
# # NOTE: if doesnt work go to original file as there are some additoinal header arguments
# # Since the HDMI port is connected to the NVIDIA card.
#   hardware.bumblebee.connectDisplay = true;

#   nixpkgs.overlays = [
#     (self: super: {
#       bumblebee = super.bumblebee.override {
#         extraNvidiaDeviceOptions = ''
#           Option "AllowEmptyInitialConfiguration"
#         '';
#       };
#     })
#   ];

#   services.xserver = mkMerge [
#       {
#         # Set the right DPI. xdpyinfo says the screen is 508×285 mm but
#         # it actually is 344×193 mm.
#         monitorSection = ''
#           DisplaySize 344 193
#         '';
#       }

#       # To support intel-virtual-output when using Bumblebee.
#       (mkIf config.hardware.bumblebee.enable {
#         deviceSection = ''Option "VirtualHeads" "1"'';
#         videoDrivers = [ "intel" ];
#       })
#   ];

  services.xserver.libinput.enable = true; # Enable touchpad


  # hardware.enableAllFirmware = true; # EXPERIMENTAL (fixing sound)

  system.copySystemConfiguration = true;  # backup in /run/current-system

  i18n.defaultLocale = "en_GB.UTF-8";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  time.timeZone = "Europe/London";  # Set your time zone.

  system.autoUpgrade.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # hardware.pulseaudio.support32Bit = true;    ## If compatibility with 32-bit applications is desired.
  hardware.pulseaudio.package = pkgs.pulseaudioFull;

  # IMPORTANT Fixed Broken Audio!
  hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" {} ''
    sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
      ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
  '';

  # # TRY fixing sound
  # let
  #   unstable = import <nixos-unstable> {};
  # in {
  #   hardware.pulseaudio.package = unstable.pulseaudioFull;
  # }

  networking.hostName = "nixos";  # Define hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  fonts.fontconfig.dpi=180;  # font scaling

  services.xserver.xkbOptions = "caps:swapescape";
  console.useXkbConfig = true;  # apply to external consoles (e.g tty)

  nixpkgs.config.allowUnfree = true;  # Allow unfree Packages

  environment.systemPackages = with pkgs; [
    # General
    neovim                       # flamewars babay
    firefox vivaldi google-chrome      # browsers (all shite)
    calibre                            # book ting
    okular                             # pdf viewer
    spotify                            # moosic REPLACE
    # TODO nextcloud-client OR syncthing?
    # Shell
    zsh                                # shell
    # TUI
    taskell                            # vim kanban <3
    tmux                               # terminal multiplexer
    pass                               # password manager
    # CLI
    direnv                             # virtual envs
    coreutils pciutils                 # selection of fine wines
    lsof                               # files opened by other procedures
    unzip                              # why u no default?
    bat                                # better cat
    ripgrep                            # rg: better grep
    exa                                # better ls
    fd                                 # better, faster find
    git gh                             # version control
    fzf                                # fuzzy finder
    xclip                              # copy pasta to cmd line
    # Background
    wget                               # fetch web protocols (e.g HTTP)
    gcc                                # C++ Compiler
    # Not rice
    neofetch htop
    # Rice
    cmatrix                            # above your paygrade mate
    # Nix
    nox                                # better package search
    # Kde
    yakuake                            # REPLACE dropdown terminal
    # TODO Cloud/File Storage
  ];

  # Emacs
  services.emacs.package = pkgs.emacsGcc;

  # TODO Update Periodically
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url =
       https://github.com/nix-community/emacs-overlay/archive/bd9091685e329ddeff1084604e7b2ba6a3b300c2.tar.gz;
      sha256 = "1vasm5f4gzlwjgjw9ggrbmkajxkfnqc2hxl0hdkfcq0857id8mhd";
    }))
  ];

  services.emacs.enable = true;  # daemon/server mode

  # TODO trezord (crypto wallet)
  # services.trezord.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;

    shellAliases = {
      snrs = "sudo nixos-rebuild switch";
      vim  = "nvim";
      yeet = "rm -rf";
      cl   = "clear";
      # ls (exa)
      l    = "exa";                 # original (grid)
      ls   = "exa -lF --icons";     # new defualt
      lT   = "exa -lFT";            # recursive tree
      ldot = "exa -lFd .* --icons"; # dotfiles
    };

    shellInit = ''
      path+=("$HOME/.emacs.d/bin")   # doom to PATH

      export KEYTIMEOUT=1            # faster vi-mode switching

      mkcd () { mkdir -p $1; cd $1 } # make and move into directory

      # ? zsh-system-clipboard permission
      source "$HOME/.zplug/repos/kutsan/zsh-system-clipboard/zsh-system-clipboard.zsh"

      export PATH
    '';
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nathan = {
    description = "Nathan Sharp";
    isNormalUser = true;
    home = "/home/nathan";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "network manager" "network"
                                  "video" "vboxusers" "audio" ];
  };

  home-manager.users.nathan = { pkgs, ... }: {

    # TODO home.packages = [ pkgs.atool pkgs.httpie ];

    programs.zsh = {
      enable = true;
      autocd = true;

      zplug = {
        enable = true;

        plugins = [
          { name = "plugins/colored-man-pages"; tags = [from:oh-my-zsh]; }
          { name = "plugins/colorize";          tags = [from:oh-my-zsh]; }
          { name = "plugins/command-not-found"; tags = [from:oh-my-zsh]; }
          { name = "plugins/fd";                tags = [from:oh-my-zsh]; }
          { name = "plugins/fzf";               tags = [from:oh-my-zsh]; }
          { name = "plugins/git";               tags = [from:oh-my-zsh]; }
          { name = "plugins/ripgrep";           tags = [from:oh-my-zsh]; }
          { name = "plugins/tmux";              tags = [from:oh-my-zsh]; }
          { name = "plugins/tmux";              tags = [from:oh-my-zsh]; }
          { name = "plugins/vi-mode";           tags = [from:oh-my-zsh]; }
          # { name = "plugins/cargo";             tags = [from:oh-my-zsh]; }
          # { name = "plugins/direnv";            tags = [from:oh-my-zsh]; }
          # { name = "plugins/pass";              tags = [from:oh-my-zsh]; }
          # { name = "plugins/rsync";             tags = [from:oh-my-zsh]; }
          # { name = "plugins/"; tags = [from:oh-my-zsh]; }
          { name = "kutsan/zsh-system-clipboard"; }  # IMPORTANT
          # DECAP { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.git = {
      enable = true;
      userName  = "nazzacode";
      userEmail = "nasharp@outlook.com";
    };

  };

  # TODO
  # ".tmux.conf" = {
  #  text = ''
  #  set-option -g default-shell /run/current-system/sw/bin/fish
  #  set-window-option -g mode-keys vi
  #  set -g default-terminal "screen-256color"
  #  set -ga terminal-overrides ',screen-256color:Tc'
  #  '';
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}

  # Enable Xmonad Tiling Window Manager
  #services.xserver = {
  #  windowManager.xmonad = {
  #    enable = true;
  #    enableContribAndExtras = true;
  #   extraPackages = haskellPackages: [
  #      haskellPackages.xmonad-contrib
  #      haskellPackages.xmonad-extras
  #      haskellPackages.xmonad
  #    ];
  #  };
    # commented for kde run
    # displayManager.defaultSession = "none+xmonad";
    # desktopManager.xterm.enable = false;

    # displayManager.sessionCommands = with pkgs; lib.mkAfter
    #   ''
    #   xmodmap /path/to/.Xmodmap
    #   '';
  # };
