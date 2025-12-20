{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.zen-browser.packages."${pkgs.system}".default.override {
      policies = {
        DisableTelemetry = true;
      };
    }
  ];
}
