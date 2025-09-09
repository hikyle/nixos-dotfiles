{ config, pkgs, ... }:
let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
	configs = {
		hypr = "hypr";
		nvim = "nvim";
		kitty = "kitty";
		fuzzel = "fuzzel";
		waybar = "waybar";
		wlogout = "wlogout";
	};
in 
{
	home.username = "kyle";
	home.homeDirectory = "/home/kyle";
	home.stateVersion = "25.05";
	home.packages = with pkgs; [
		neovim
		kitty
		wl-clipboard
		papirus-icon-theme
		nwg-look
		waypaper
		hyprpaper
		xdg-desktop-portal-gtk
		mate.mate-polkit
		pavucontrol
		hyprshot
		grim
		hyprpicker
		protonplus
		heroic
		bibata-cursors
		discord
		fuzzel
		tokyonight-gtk-theme
	];

	programs.bash = {
		initExtra = ''
			export PS1='\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]'
		'';
	};

	xdg.configFile = builtins.mapAttrs
		(name: subpath: {
			source = create_symlink "${dotfiles}/${subpath}";
			recursive = true;
		})
		configs;
}
