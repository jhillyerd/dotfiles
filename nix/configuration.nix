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

  hardware.pulseaudio.enable = true;
  powerManagement.enable = false;
  sound.enable = true;
  virtualisation.virtualbox.guest.enable = true;

  users.users.james = {
    uid = 1001;
    isNormalUser = true;
    home = "/home/james";
    description = "James Hillyerd";
    extraGroups = [ "audio" "docker" "networkmanager" "vboxsf" "wheel" ];
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
    docker
    file
    firefox
    fish
    git
    gitAndTools.gitflow
    gcc
    gnumake
    go
    google-chrome
    jq
    lsof
    ncat
    nodejs
    patchelf
    python3
    tmux
    tree
    universal-ctags
    unzip
    rxvt_unicode-with-plugins
    swaks
    vimHugeX
    weechat
    wget
    zip

    (writeShellScriptBin "x-www-browser" ''
      exec ${google-chrome}/bin/google-chrome-stable "$@"
    '')
  ];

  fonts.fonts = with pkgs; [
    font-droid
    inconsolata
  ];

  programs.fish.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  virtualisation.docker.enable = true;
}
