# nix-config

this is my nix configuration repository for macos. it includes both system and user-level configurations using nix-darwin and home-manager. nixos support might be added in the future.

---

## prerequisites

1. **install the nix package manager**  
   download and install nix using the instructions from the official site:  
   [install nix on macos](https://nixos.org/download/#nix-install-macos).  
   starting from a clean macos installation is recommended.

2. **enable experimental features**  
   add the following to `~/.config/nix/nix.conf` to enable flakes and nix-command:
   ```config
   experimental-features = nix-command flakes
   ```
3. **install homebrew on macos**  
   use this command to install homebrew on your system:
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

4. **clone the repository**  
   ```sh
   git clone <repo-url> ~/nix-config
   ```

---

## usage

### applying the configuration

1. navigate to the repository:
   ```sh
   cd ~/nix-config
   ```
2. get your hostname:
   ```sh
   scutil --get LocalHostName
   ```

3. update the hostname in `./flake.nix`

2. update the flake and apply the configuration:
   ```sh
   nix flake update
   nix run github:LnL7/nix-darwin -- switch --flake ~/nix-config
   ```

---

## managing packages

### adding packages

#### system-level packages

1. edit `modules/nixpkgs/system-apps.nix` and add the desired package to `environment.systemPackages`:
   ```nix
   environment.systemPackages = with pkgs; [
     tmux
     zsh
     new-package
   ];
   ```

2. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

#### user-level packages

1. edit `modules/nixpkgs/user-apps.nix` and add the desired package to `environment.systemPackages`:
   ```nix
   environment.systemPackages = with pkgs; [
     spotify
     vscode
     another-new-package
   ];
   ```

2. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

#### homebrew casks

1. edit `modules/homebrew/casks.nix` and add the desired cask to `homebrew.casks`:
   ```nix
   homebrew.casks = [
     "firefox"
     "vlc"
     "new-cask"
   ];
   ```

2. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

### removing packages

follow the same steps as adding packages, but remove the package from the relevant list.  
then apply the configuration as usual.

---

## managing modules

### adding a module

1. create a new module file, e.g., `modules/nixpkgs/new-module.nix`:
   ```nix
   { pkgs, config, ... }:

   {
     environment.systemPackages = with pkgs; [
       new-package
     ];
   }
   ```

2. import the module in `darwin-configuration.nix` or `home.nix`:
   ```nix
   imports = [
     ./modules/nixpkgs/new-module.nix
   ];
   ```

3. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

### removing a module

1. remove the module import from `darwin-configuration.nix` or `home.nix`.
2. delete the module file (optional).
3. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

---

## managing the dock

### customizing dock entries

1. edit `local.dock.entries` in `modules/darwin/dock.nix` to add or remove apps:
   ```nix
   local.dock.entries = [
     { path = "/Applications/NewApp.app"; section = "apps"; }
   ];
   ```

2. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

### changing dock position and size

1. modify `local.dock.position` or `local.dock.size` in `modules/darwin/dock.nix`:
   ```nix
   local.dock.position = "bottom";
   local.dock.size = 50.0;
   ```

2. apply the configuration:
   ```sh
   nix flake update
   darwin-rebuild switch --flake .#myMac
   ```

---

## troubleshooting

### flake-related issues

ensure `experimental-features` in `~/.config/nix/nix.conf` includes:
```config
experimental-features = nix-command flakes
```

### dock not updating

try manually restarting the Dock:
```sh
killall Dock
```

### package not found

verify the package exists in the nixpkgs repository or check your `nixpkgs` input in `flake.nix`.

### configuration not applying

ensure you are running the correct commands:
```sh
nix flake update
nix run github:LnL7/nix-darwin -- switch --flake ~/nix-config
```

---

## notes

- **modularity**: this configuration is divided into modules to improve maintainability.
- **future plans**: add nixos support and further enhance customization options.
