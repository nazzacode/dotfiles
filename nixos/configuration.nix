{ config, pkgs, callPackage, ... }: {
  # ...

  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  boot.loader.systemd-boot.enable = true;  # Use the systemd-boot EFI boot loader

  boot.loader.efi.canTouchEfiVariables = true;  # no idea

  # boot.loader.efi.efiSysMountPoint = "/boot/EFI";

  # TODO remove grub
  # TODO getwindows 10 back!!

  # Enable Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  # NOTE: `modesetting` alows NixOS to find the primary display

  hardware.nvidia = {
    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
    modesetting.enable = false;
  };
  # Link for fixing dual monitors: ↓
  # https://discourse.nixos.org/t/need-some-help-getting-nvidia-working-properly/8281/7

  services.xserver.libinput.enable = true; # Enable touchpad

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
  # ++ run: > pulseaudio -k     # TODO automate!
  hardware.pulseaudio.configFile = pkgs.runCommand "default.pa" {} ''
    sed 's/module-udev-detect$/module-udev-detect tsched=0/' \
      ${pkgs.pulseaudio}/etc/pulse/default.pa > $out
  '';

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

environment.systemPackages =
  let
    python = pkgs.python39.withPackages(ps: with ps; [
      jupyter_core
      # jupyter_console
      # jupyter_client
      # jupyter
      # jupyterlab
      # pip
      # nix-kernel
    ]);

    # # FIXME not working :(
    # jupyter = import (builtins.fetchGit {
    #   url = https://github.com/tweag/jupyterWith;
    #   rev = "";
    # }) {};

    # iPython = jupyter.kernels.iPythonWith {
    #   name = "data-python-env";
    #   packages = p: with p; [ numpy ];
    # };

    # iHaskell = jupyter.kernels.iHaskellWith {
    #   name = "data-haskell-env";
    #   packages = p: with p; [ hvega formatting ];
    # };

    # jupyterEnvironment = jupyter.jupyterlabWith {
    #   kernels = [ iPython iHaskell ];
    # };

  in
    with pkgs; [
      # GUI
      firefox vivaldi google-chrome      # browsers
      calibre                            # book ting
      zotero                             # reference management!
      okular                             # pdf viewer
      spotify                            # moosic # TODO replace!
      vscode                             # guilty pleasure
      teams                              # microsoft junk
      thunderbird-91                     # email ting
      etcher                             # flashing ISO's
      # TODO Cloud/File Storage: nextcloud-client OR syncthing?
      # Shell
      zsh                                # shell
      # Lang
      nodejs                             # javascript
      nodePackages.typescript            # typescript
      nodePackages.typescript-language-server
      python
      python39Packages.pip               # impure af
      python39Packages.ipython           # impure af
      python39Packages.virtualenv
      ihaskell
      # jupyterEnvironment                 # jupyter <3
      ghc
      ghcid
      # TUI
      neovim                             # editor flamewars babay
      taskell                            # vim kanban <3
      tmux                               # terminal multiplexer
      pass                               # password manager
      # CLI (used)
      cachix
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
      pandoc                             # converting between document filetypes
      networkmanager-l2tp                # Edinburgh university VPN
      pdftk                              # working with PDFs
      # CLI (background)
      texlive.combined.scheme-full       # tex (including pdflatex)
      gnupg                              # encrypt and sign data and communication
      wget                               # fetch web protocols (e.g HTTP)
      gcc                                # C++ Compiler
      mu                                 # email: malidir utilites
      isync                              # mailbox sync
      gdb                                # gnu c++ debugger
      # networkmanager_strongswan          # Edinburgh Uni vpn
      # libreswan
      # strongswan
      # strongswanNM
      # strongswanTNC
      # Emacs deps
      aspell ispell aspellDicts.en       # multilingual dictionary

      # Not rice
      neofetch
      htop
      # Rice
      cmatrix                            # green pill pls
      # Nix
      nox                                # better package search
      # TODO nix fmt
      nixfmt
      nixops
      # Kde
      yakuake                            # REPLACE dropdown terminal

      # Grpahics (Nvidia)
      linuxPackages.nvidia_x11           # allows nvidia-smi
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

  # Strongswan (move to networking)
  networking.networkmanager.enableStrongSwan = true;
  # service.xl2tpd.enable = true;
  # service.strongswan.enable = true;

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
      ls   = "exa -lF --icons --group-directories-first"; # new defualt
      lsd  = "ls -d */";             # directories only
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
          # { name = "plugins/command-not-found"; tags = [from:oh-my-zsh]; }
          { name = "plugins/fd";                tags = [from:oh-my-zsh]; }
          { name = "plugins/fzf";               tags = [from:oh-my-zsh]; }
          { name = "plugins/git";               tags = [from:oh-my-zsh]; }
          { name = "plugins/ripgrep";           tags = [from:oh-my-zsh]; }
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


    programs.autorandr = {
      enable = true;
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
