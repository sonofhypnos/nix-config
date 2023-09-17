# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # "${
    #   fetchTarball
    #   "https://github.com/NixOS/nixos-hardware/archive/936e4649098d6a5e0762058cb7687be1b2d90550.tar.gz"
    # }/raspberry-pi/4"
    # <home-manager/nixos>
    ./vim.nix
  ];
  #test eve

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;
  networking.interfaces.eth0.ipv6.addresses = [{
    address = "fe00:aa:bb:cc::2";
    prefixLength = 64;
  }];

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];

  programs.neovim = {
    enable = true; # this overwrites vim with neovim
    viAlias = true;
    #     plugins = [
    #     {
    #       plugin = nvim-colorizer-lua;
    #       config = packadd! nvim-colorizer.lua
    #       lua require 'colorizer'.setup();
    #       #there is something about erros when using default packages: https://nixos.wiki/wiki/Neovim
    #     }
    #   ];

  };

  # Configure network proxy if necessary
  #networking.proxy.default = "http://user:password@proxy:port/";
  #networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tassilo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCSadWNNn6VXcoYng7QrNbr6JNcgMUlrvb9INu0a1Ox6pQro2YLJvU5CGMEi9P5KKQrFSvPDlkwd/uUMmOr7jbZfE5iWWYHxqjDo+FI6+a2vpymWdotGBFdPcGzet2X9HW1hbeOHySTIwStfSRO/Fx43uy5Hxq1Fd/Up2kslQyUxxSVd7GFrfe0bJkv1tozoR/UixrBMin2OfI9T0nvG+HuZ51PF5ukrkogEaXFwtoS1jYrY2gk1GLRYEP5WiL7s9k7nJJ3DyHejCRk4XJP/szCRxa7zRSed5ussYfRZXr1KLiauvkfvBvB14ACuLVSKz8dyo/6C6zLLJxrvpDSgjgrz3kyJlqWTPsR3fBoVemqLta5vPLKCv53LTopa9p0ySvKPo3i3pQS5jHwtD9OOiuSyYzZOoxVG9motWjsXlB6P927XCoDfb+0kke0kYWsdlUaO2G+fDcQpEjH1borz74LP/YIDE/nh7jEMR2VwgYhAsyILfGsxpqt6OyUDwoxkgs= tassilo@tassilo-ThinkPad-E15-Gen-2"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLSQ/5TgxGqerDlA+CCHY/NrLkonlVSgI9cbkgrsHsAQAe8kS7tvBZpTFhZyYYQz0O3x70IF1NYD0ZJ/DjOyPzQZXr3efA0EYwisRF83A7AAhhBUs2jxcbHeTwgEYg9cboCPw97dJPfAhAjC+8SE6DMUJT2Fvyxb9fyKUxhzd6CI0KKm3MlO4qwOXyA/RM/4xtnIgO+lYvZ7OZmluSQi9DU2UyCvHads/YlPGbnKmw888Sc7QhqE3eq42lSU7995aZDF0kH4qcoXmV8ugRJ+5OKRRgFkcky8j6r/LkYaK4HHe4Qa3CSBJjQHOmd7Vfu51LJfedfTWJaOfuvEgYV69c2xc0Iwbi2VDNfGSS/9LWxh+H2GbMllIp+lKlZtASQfvgMPSfLgRa+cbhcwwwcV58Qrk3QdED6ESQL7kZmuIyVWSAzBbHsb12O6SgGIQiLsGiqcUWKRwudH4iw1jWWtvb0WJxeUbqKglPjMMCYRg57ym+LhMmNiF5ydjLrJHyogM= tassilo@t-dell"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQSROiZcNSIT0jynq6EXEa6ne9ApY0OUfh96qLBDL4pUsFW3KhHouiC9weQp31QXxckTC7rdvSNe6YkchrpT0KHi/tkTmgAoYX9pQv0guYUymOinj95Q+PJYMviotRzVlpB01GcZ/XlTaUZZV0HgUlto8TiMX2ILAbxvHzo1a0GNUw4xBBEZvOg2xSL26rcogqKibMv9jothkEVLRHydrNWzGZtXopOk1eGXh6qOl8bVB38XuZK3AHyqJtfUZb5Zj8nkKPrHn9spVpyt8J4xb43tTHKvtwWGWTTZixZBBUgugHAhgQIAaP/3T0Dw2gndPsyhmqZeO0Iy6Lv9r1fsUxzgh2PPjjmP/AZtphU9lCGx7Gy6+FahsYlXPPGEZRljn64jN9v4u15xTx6cmn0LuxvTrntM6p+ruIPzWVrNK/4XQwFjlbDO1UD/ToePoUaKtNR5AngeeTp/9/wObmfwolJQgx4miq/Jvsdx0+FlIX8hzAU4hjDMFNd1UonI/9f3M= root@tassilo-ThinkPad-E15-Gen-2"
    ];
    shell = pkgs.zsh;
  };

  # home-manager = {
  #   useGlobalPkgs = true;
  #   useUserPackages = true;
  #   users.tassilo = { imports = [ ./home.nix ]; };
  # };
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCQSROiZcNSIT0jynq6EXEa6ne9ApY0OUfh96qLBDL4pUsFW3KhHouiC9weQp31QXxckTC7rdvSNe6YkchrpT0KHi/tkTmgAoYX9pQv0guYUymOinj95Q+PJYMviotRzVlpB01GcZ/XlTaUZZV0HgUlto8TiMX2ILAbxvHzo1a0GNUw4xBBEZvOg2xSL26rcogqKibMv9jothkEVLRHydrNWzGZtXopOk1eGXh6qOl8bVB38XuZK3AHyqJtfUZb5Zj8nkKPrHn9spVpyt8J4xb43tTHKvtwWGWTTZixZBBUgugHAhgQIAaP/3T0Dw2gndPsyhmqZeO0Iy6Lv9r1fsUxzgh2PPjjmP/AZtphU9lCGx7Gy6+FahsYlXPPGEZRljn64jN9v4u15xTx6cmn0LuxvTrntM6p+ruIPzWVrNK/4XQwFjlbDO1UD/ToePoUaKtNR5AngeeTp/9/wObmfwolJQgx4miq/Jvsdx0+FlIX8hzAU4hjDMFNd1UonI/9f3M= root@tassilo-ThinkPad-E15-Gen-2"
    ];

  };
  # users.users.tassilo.shell = pkgs.zsh;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    ripgrep
    neovim
    #ripgrep-all
    zsh
    oh-my-zsh
    fzf
    #progress
    #wallabag
    parted
    borgbackup
    #syncthing
    nettools
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.passwordAuthentication = true;
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

#  services = {
#    syncthing = {
#      enable = true;
#      user = "tassilo";
#      openDefaultPorts = true;
#      dataDir =
#        "/home/tassilo/Documents"; # Default folder for new synced folders
#      configDir =
#        "/home/tassilo/.config/syncthing"; # Folder for Syncthing's settings and keys
#      devices = {
#        "pixel" = {
#          id =
#            "YHGCWFP-U2QWKAT-FFQEWBU-WUW2G72-5Q2IZEM-WBLOOD2-3GFRN3D-3JTDIQA";
#        };
#
#        "e15" = {
#          id =
#            "P4T4IFQ-DVMDK4E-FV6JU7T-GZPWHBS-AO5MOE3-ISDJVLX-SSAOINE-S335WQW";
#        };
#      };
#      folders = {
#        "Documents" = {
#          path = "home/tassilo/Documents";
#          devices = [ "pixel" "e15" ];
#        };
#      };
#    };
#  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}
