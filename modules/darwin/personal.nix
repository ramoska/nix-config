{ ... }:

{
  homebrew = {
    taps = [
      {
        name = "nikitabobko/tap";
        trusted = true;
      }
    ];
    casks = [
      {
        name = "protonvpn";
        greedy = true;
      }
      {
        name = "aerospace";
        greedy = true;
      }
    ];
  };
}
