# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "laptop-17";
  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  # Time zone and 
  time.timeZone = "Europe/London";

  # I18N and Keyboard
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  # Printing
  services.printing.enable = true;

  # Sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Touchpad
  services.xserver.libinput.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.hyprland.enable = true;

  # Users
  users.users.mark = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  # Home-Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users.mark = import ./home.nix;
  };
  
  # System Default Packages
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  # Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

