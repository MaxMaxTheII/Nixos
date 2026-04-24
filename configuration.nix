# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
    unstableTarball =
        fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in 
{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
            ./stylix.nix
        ];
    nixpkgs.config = {
        packageOverrides = pkgs: with pkgs; {
            unstable = import unstableTarball {
                config = config.nixpkgs.config;
            };
        };
    };
  # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;

    boot.initrd.luks.devices."luks-fe1352d0-c036-4037-91e5-e6c5d42b4845".device = "/dev/disk/by-uuid/fe1352d0-c036-4037-91e5-e6c5d42b4845";
    networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

  # Enable networking
    networking.networkmanager = {
        enable = true;
        plugins = with pkgs; [
            networkmanager-openconnect    
        ];
    };

    hardware.bluetooth.enable = true; 
    hardware.bluetooth.powerOnBoot = true; 
    services.blueman.enable = true;

    time.timeZone = "Europe/Vienna";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "de_AT.UTF-8";
        LC_IDENTIFICATION = "de_AT.UTF-8";
        LC_MEASUREMENT = "de_AT.UTF-8";
        LC_MONETARY = "de_AT.UTF-8";
        LC_NAME = "de_AT.UTF-8";
        LC_NUMERIC = "de_AT.UTF-8";
        LC_PAPER = "de_AT.UTF-8";
        LC_TELEPHONE = "de_AT.UTF-8";
        LC_TIME = "de_AT.UTF-8";
    };

  # Enable the X11 windowing system.
    services.xserver.enable = true;


    programs.hyprland.enable = true;

    services.udisks2.enable = true;
    services.gvfs.enable = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true; # Ensures SDDM starts a Wayland session
    };
    services.displayManager.autoLogin = {
        enable = true;
        user = "max";
    };# login and instantly lock the screen to have the same loginscreen everytime

  # Configure keymap in X11
    services.xserver.xkb = {
        layout = "at";
        variant = "nodeadkeys";
    };

  # Enable CUPS to print documents.
    services.printing.enable = true;

    security.pam.services.hyprlock = {};

  # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.max = {
        isNormalUser = true;
        description = "max";
        extraGroups = [ "networkmanager" "wheel" "video"];
        packages = with pkgs; [
        #  thunderbird
        ];
    };
    users.users.max.shell = pkgs.bashInteractive;


# Install firefox.
    programs.firefox.enable = true;

  # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [   "nix-command" "flakes"  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
    #A
    #B
        brightnessctl
    #C 
    #D  
        docker_29
    #E
    #F 
        unstable.fastfetch
    #G 
        git
    #H   
    #I  
    #J
    #K 
    #L   
        libgcc
    #M
    #N  
        networkmanagerapplet
        nh
        nix-output-monitor
        nvd
    #O
        openconnect
    #P   
        polkit_gnome
    #Q
    #R
    #S  
        swaybg
    #T 
    #U
    #V  
    #W 
        wget
    #X
    #Y  
    #Z
    ];

    system.stateVersion = "25.11"; # Did you read the comment?

}
