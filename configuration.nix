 { config, pkgs, ... }:
  
 {
  imports =
    [
      ./hardware-configuration.nix
    ];	      

  boot.loader.systemd-boot.enable = true; # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Define hostname
  networking.hostName = "hyrax";  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;

  # Login shit
  environment.loginShellInit = ''
   if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
     exec sway
    fi
  '';

  # Set time zone
  time.timeZone = "Europe/London";

  # tailscale
  services.tailscale.enable = true;

  networking.useDHCP = false; # The global useDHCP flag is deprecated
  networking.interfaces.wlp1s0.useDHCP = true;
  
  # Storage optimisation
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
 
  # For quassel core 
  services.quassel.enable = true; 
  services.quassel.interfaces = [ "0.0.0.0" ];
  networking.firewall.allowedTCPPorts = [ 4242 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_GB.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "uk";
   };

  # Enable the X11 windowing system.
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment and xmonad.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.windowManager.xmonad.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.dom = {
    isNormalUser = true;
    home = "/home/dom/";
    extraGroups = [ "wheel" "audio" "video" "sound" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    nixpkgs.config.allowUnfree = true; # allow unfree shit 
    environment.systemPackages = with pkgs; [
     vim emacs vscode
     wget
     home-manager
     htop btop
     protonvpn-gui
     devilutionx
     lm_sensors # hardware reading (temp etc)
     google-chrome chromium firefox tor-browser-bundle-bin
     spotify
     git
     fish
     quasselClient
     whatsapp-for-linux
     ghc ghcid cabal-install stack hlint
   ];

  nix = {
   package = pkgs.nixFlakes;
   extraOptions = ''      experimental-features = nix-command flakes
    '';
   };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
    
  services.openssh.enable = true; # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "22.05"; # Nixos version 
}
