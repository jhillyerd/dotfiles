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

  nix.useSandbox = false;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = let
    x-www-browser =
      pkgs.writeShellScriptBin "x-www-browser" ''
        exec ${pkgs.google-chrome}/bin/google-chrome-stable "$@"
      '';
    in with pkgs; [
      bind
      docker
      file
      firefox
      git
      gitAndTools.gitflow
      gcc
      gnumake
      google-chrome
      jq
      lsof
      ncat
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
      x-www-browser
      zip
  ];

  fonts.fonts = with pkgs; [
    font-droid
    inconsolata
  ];

  programs.fish.enable = true;

  services.xserver = {
    enable = true;
    dpi = 108;
    windowManager.i3.enable = true;
  };

  virtualisation.docker.enable = true;
}
