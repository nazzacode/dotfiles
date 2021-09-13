;; $./configuration.nix -*- lexical-binding: t; -*-

# TESTING 1
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # TODO home man
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Create backup configuration.nix in /run/current-system
  system.copySystemConfiguration = true;

  # automatically periodically  run `nixos-rebuild switch --upgrade`
  system.autoUpgrade.enable = true;

  # Netowking (wifi)
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  # services.blueman.enable = true;  # blueman applet

  # Brightness

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Allow unfree Packages
  nixpkgs.config.allowUnfree = true;


  services.xserver.xkbOptions = "caps:swapescape";
console.useXkbConfig = true;  # apply to external consoles such as tty

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # General
    emacs
    firefox
    calibre
    # Command Line Tools
    wget
    gcc  # C++ Compiler
    zsh  #
    neovim
    direnv
    bat
    tmux
    git
    ripgrep
    coreutils
    fd
    # Nix
    nox
    # Kde
    yakuake
  ];

  # Emacs
   services.emacs.package = pkgs.emacsGcc;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  # Enable packages
  programs.zsh.enable = true;

  # Set font scaling
  fonts.fontconfig.dpi=180;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Virtual Box
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "gb";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable Nvidia
  # services.xserver.videoDrivers = [ "nvidia" ];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nathan = {
    description = "Nathan Sharp";
    isNormalUser = true;
    home = "/home/nathan";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "network manager" "network" "video" "vboxusers" "audio" ]; # Enable ‘sudo’ for the user.
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}
