{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;
  users.users.ramoska = {
    isNormalUser = true;
    description = "ramoska";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
}
