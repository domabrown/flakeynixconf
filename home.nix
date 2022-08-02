{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dom";
  home.homeDirectory = "/home/dom/";

  # Sway config start
  home.packages = with pkgs; [
    swaylock
    swayidle
    j4-dmenu-desktop
    foot
    waybar
    font-awesome
    wl-clipboard
    mako # notification daemon
    wofi
  ];
   fonts.fontconfig.enable = true;
  # Use sway desktop environment with Wayland display server
  wayland.windowManager.sway = {
   enable = true;
   wrapperFeatures.gtk = true;
   # Sway-specific Configuration
   config = {
     modifier = "Mod4";
     terminal = "foot";
     menu = "j4-dmenu-desktop --no-generic --dmenu='wofi --fork --show drun --allow-images --no-actions' --term=foot";
     # Status bar(s)
     bars = [{
	fonts.size = 15.0;
	command = "waybar";
	position = "top";
      }];
      input = {
        "type:keyboard" = {
	  xkb_layout = "gb";
	};
      };
     # Brightness keys
      # Display device configuration
      output = {
	eDP-1 = {
	  # Set HIDP scale (pixel integer scaling)
	  scale = "1";
	    };
	  };
      };
      # End of Sway-specific Configuration
    };

    programs.waybar = {
      enable = true;
    };
      
    # Rust-based terminal emulator
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "alacritty";
        window = {
          decorations = "full";
          title = "Alacritty";
          dynamic_title = true;
          class = {
            instance = "Alacritty";
            general = "Alacritty";
          };
        };
        font = {
          normal = {
            family = "monospace";
            style = "regular";
          };
          bold = {
            family = "monospace";
            style = "regular";
          };
          italic = {
            family = "monospace";
            style = "regular";
          };
          bold_italic = {
            family = "monospace";
            style = "regular";
          };
          size = 14.00;
        };
        colors = {
          primary = {
            background = "#1d1f21";
            foreground = "#c5c8c6";
          };
        };
      };
    };

  # Git
   programs.git = {
    enable = true;

    delta.enable = true;

    userEmail = "dom-doi@live.co.uk";
    userName = "domabrown";
    };

  # Fish
  programs.fish = {
    enable = true;
    };

  programs.bat.enable = true;

  programs.dircolors = {
    enable = true;
    enableFishIntegration = true;
    };

  

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