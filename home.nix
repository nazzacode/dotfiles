{ config, pkgs, ... }: {

# TODO alpha sort packages

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nathan";
  home.homeDirectory = "/home/nathan";

  nixpkgs.config.allowUnfree = true;


  home.packages = with pkgs; [
    # ---------- GUI ----------
    #emacs
    vivaldi google-chrome              # browsers
    calibre                            # book ting
    zotero                             # reference management!
    okular                             # pdf viewer
    spotify                            # moosic # TODO replace!
    vscode                             # guilty pleasure
    teams                              # microsoft junk
    thunderbird                        # email ting
    etcher                             # flashing ISO's
    # ---------- TUI ----------
    neovim                             # editor flamewars babay
    taskell                            # vim kanban <3
    tmux                               # terminal multiplexer
    pass                               # password manager
    # ---------- CLI ----------
    cachix
    direnv                             # virtual envs
    # coreutils pciutils                 # selection of fine wines
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
    # networkmanager-l2tp                # Edinburgh university VPN
    pdftk                              # working with PDFs
    # ----- CLI BACKGROUND ----
    texlive.combined.scheme-full       # tex (including pdflatex)
    gnupg                              # encrypt and sign data and communication
    wget                               # fetch web protocols (e.g HTTP)
    gcc                                # C++ Compiler
    mu                                 # email: malidir utilites
    isync                              # mailbox sync
    gdb                                # gnu c++ debugger
    aspell ispell aspellDicts.en       # multilingual dictionary (emacs)
    # -------- Not Rice -------
    neofetch                           # system information
    # htop 
    # ---------- RICE ---------
    cmatrix                            # green pill pls
    # ---------- NIX ----------
    nixfmt                             # nix code formatter
    # nixops                           # FIXME causing errors
    # ---------- EMACS ---------
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
