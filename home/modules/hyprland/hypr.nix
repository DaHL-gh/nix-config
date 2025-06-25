{ config, pkgs, ... }:
let hyprModuleDir = "${config.home.homeDirectory}/nixos-config/home/modules/hyprland";
in {
	home.packages = with pkgs; [
		kitty
		hyprsome
		playerctl
		wl-clipboard
	];

	home.file = {
		".config/hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${hyprModuleDir}/src/hyprland.conf";
		".config/hypr/monitors.conf".source = config.lib.file.mkOutOfStoreSymlink "${hyprModuleDir}/src/monitors/${config.deviceName}.conf";
	};
}
