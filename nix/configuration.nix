{ config, pkgs, ... }:

{
  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;
  boot.growPartition = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
  };

  virtualisation.virtualbox.guest.enable = true;

  users.users.james = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/james";
    description = "James Hillyerd";
    extraGroups = [ "wheel" "networkmanager" "vboxsf" ];
    shell = pkgs.fish;
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  time.timeZone = "US/Pacific";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    bind
    firefox
    fish
    git
    gcc
    gnumake
    go
    google-chrome
    jq
    ncat
    python3
    tmux
    tree
    universal-ctags
    unzip
    rxvt_unicode-with-plugins
    swaks
    vimHugeX
    wget
    zip
  ];

  fonts.fonts = with pkgs; [
    inconsolata
  ];

  programs.fish.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  powerManagement.enable = false;
}
