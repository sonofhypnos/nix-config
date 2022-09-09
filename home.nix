{ config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tassilo";
  home.homeDirectory = "/home/tassilo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Tassilo Neubauer";
      userEmail = "46806445+sonofhypnos@users.noreply.github.com";
    };
    vim = {
      enable = true;
      # defaultEditor = true;
    };
    zsh = {
      enable=true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

  };

}
