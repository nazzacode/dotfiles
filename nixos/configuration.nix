{ config, pkgs, ... }: {
  # ...

  imports =
    [
      ./hardware-configuration.nix
      # TODO home manager
    ];

  boot.loader.systemd-boot.enable = true;  # Use the systemd-boot EFI boot loader
  boot.loader.efi.canTouchEfiVariables = true;  # no idea

  # Enable Nvidia
  # services.xserver.videoDrivers = [ "nvidia" ];

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Create backup configuration.nix in /run/current-system
  system.copySystemConfiguration = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "Europe/London";

  system.autoUpgrade.enable = true;

  networking.hostName = "nixos";  # Define hostname.
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  fonts.fontconfig.dpi=180;  # font scaling

  nixpkgs.config.allowUnfree = true;  # Allow unfree Packages

  services.xserver.xkbOptions = "caps:swapescape";
  console.useXkbConfig = true;  # apply to external consoles (e.g tty)

  environment.systemPackages = with pkgs; [
    # General
    emacs neovim                       # flamewars babay
    firefox vivaldi google-chrome      # browsers (all shite)
    calibre                            # book ting
    # Command Line
    wget                               # fetch web protocols (e.g HTTP)
    gcc                                # C++ Compiler
    zsh                                # shell
    direnv                             # virtual envs
    coreutils bat ripgrep fd           # cli utils
    git                                # version control
   # Nix
    nox                                # better package search
    # Kde
    yakuake                            # REPLACE dropdown terminal
    # TODO Cloud/File Storage
  ];

  # Emacs
   services.emacs.package = pkgs.emacsGcc;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
  services.emacs.enable = true;  # daemon/server mode

  programs.zsh.enable = true;

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}



  # Enable Xmonad Tiling Window Manager
  #services.xserver = {
  #  windowManager.xmonad = {
  #    enable = true;
  #    enableContribAndExtras = true;
  #    extraPackages = haskellPackages: [
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
