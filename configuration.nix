# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/disk/by-uuid/355cdea5-5f6a-45da-beb6-791fa54387e1";
      preLVM = true;
    }
  ];

  networking.hostName = "nixosthinkpad";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ag
    aspell
    aspellDicts.en
    chromium
    docker
    emacs
    ghc
    git
    global
    kubernetes
    lastpass-cli
    lshw
    minikube
    mkpasswd
    networkmanager_openvpn
    par
    pstree
    slack
    stack
    tmux
    tree
    universal-ctags
    virtualbox
    vimHugeX
    vlc
    xcape
    xclip
  ];

  nixpkgs.config.allowUnfree = true;

  fonts.fonts = [
    pkgs.source-code-pro
    pkgs.emacs-all-the-icons-fonts
  ];

  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.emacs.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.extraHosts = "192.168.99.100 eureka";
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:ctrl_modifier,shift:both_capslock";
    autoRepeatDelay = 200;
    autoRepeatInterval = 30;

    # Enable touchpad support.
    libinput.enable = true;

    desktopManager = {
      gnome3.enable = true;
      default = "gnome3";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.ivan = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/ivan";
    extraGroups = [
      "docker"
      "networkmanager"
      "vboxusers"
      "wheel"
      ];
    hashedPassword = "$6$qWuhkYKaol$kZGBevpOUgsyXID3hZshrrXmUxBXzNX5clP6vUfKP/ze0hd34aWfpl7gJs/20dDhgRQyq1n2wdmOcUkDGye3u0";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

  system.autoUpgrade.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.headless = true;

}
