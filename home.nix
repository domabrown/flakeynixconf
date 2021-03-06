{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dom";
  home.homeDirectory = "/home/dom/";

  # Git
   programs.git = {
    enable = true;

    delta.enable = true;

    userEmail = "dom-doi@live.co.uk";
    userName = "Dom Brown";
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
  home.stateVersion = "21.05";
}