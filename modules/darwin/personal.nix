{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qmk
    qmk_hid
  ];
  homebrew = {
    casks = [
      {
        name = "protonvpn";
        greedy = true;
      }
    ];
  };
}
