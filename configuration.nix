{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  hardware.graphics.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = [ "iwlwifi" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm.enable = true;
  services.flatpak.enable = true;
  services.pulseaudio.enable = false;
  services.power-profiles-daemon.enable = true;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  users.users.kyle = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.waybar.enable = true;
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git
    gnumake
    unzip
    gcc
    ripgrep
    fd
    eza
    bat
    neovim
    protonplus
    fastfetch
    heroic
    gh
    wl-clipboard
    papirus-icon-theme
    kitty
    nwg-look
    waypaper
    hyprpaper
    xdg-desktop-portal-gtk
    mate.mate-polkit
    pulseaudioFull
    pavucontrol
    hyprshot
    grim
    hyprpicker
    inter-nerdfont
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}