# System Setup

This repository acts as a flake source (library) for configuring Darwin and NixOS systems. Each system should have its own local `flake.nix` that consumes this repository.

## Prerequisites

1. **Install Nix** (Multi-user installation recommended).
   * **macOS**:
     ```bash
     sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
     ```

   * **NixOS**: Pre-installed.

1. **Install Homebrew** (macOS only).
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

## 1. Setup Local System Flake

### For macOS (Darwin)

Create `~/.nix-darwin/flake.nix`:

```nix
{
  description = "Local Darwin System Flake";

  inputs = {
    nix-config = {
      url = "github:ramoska/nix-config";
    };
  };

  outputs = inputs@{ self, nix-config, ... }:
  {
    darwinConfigurations = {
      "hostnameOfSystem" = nix-config.nix-darwin.lib.darwinSystem {
        specialArgs = { inherit (nix-config) inputs; };
        system = "aarch64-darwin"; # Adjust if using Intel (x86_64-darwin)
        modules = [
          nix-config.darwin # or other module depending on machine
          {
            users.users."username".home = "/Users/username";
            system.primaryUser = "username";
          }
        ];
      };
    };
  };
}
```

**Apply Configuration:**

```bash
cd ~/.nix-darwin
nix --extra-experimental-features "nix-command flakes" flake update
sudo nix --extra-experimental-features "nix-command flakes" run nix-darwin -- switch --flake .
```

*Subsequent updates:*
```bash
nix flake update
sudo darwin-rebuild switch --flake .
```

### For NixOS

Create `/etc/nixos/flake.nix`:

```nix
{
  description = "Local NixOS System Flake";

  inputs = {
    nix-config.url = "github:ramoska/nix-config";
  };

  outputs = { self, nix-config }: {
    nixosConfigurations."hostname" = nix-config.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit (nix-config) inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix  # has hostname and other trivial things defined and imports hardware-configuration.nix
        nix-config.mbp  # or nix-config.desktop
      ];
    };
  };
}
```

**Apply Configuration:**

```bash
cd /etc/nixos
sudo nixos-rebuild switch --flake .
```

#### For NixOS on MacBook

Install firmware for wireless and bluetooth

```bash
mkdir -p /lib/firmware/brcm
nix-shell -p dmg2img python315 curl
curl -fsSL https://raw.githubusercontent.com/t2linux/wiki/refs/heads/master/docs/tools/firmware.sh | bash
```

## 2. Dotfiles (Chezmoi)

After setting up the system, use `chezmoi` to manage dotfiles (start new terminal to have)

1. **Clone repository**.
   ```bash
   cd ~
   jj git clone --no-colocate https://github.com/ramoska/nix-config.git
   ```

1. **Apply configuration**
   Assuming that repository is checked out as is in home dir
   ```fish
   chezmoi init --apply --source ~/nix-config/dotfiles
   ```
