{ config, pkgs, lib, ... }:

with lib;
let
  inherit (pkgs) stdenv dockutil;
in
{
  options = {
    local.dock.enable = mkOption {
      description = "enable dock config";
      default = stdenv.isDarwin;
    };

    local.dock.entries = mkOption {
      description = "apps added to dock";
      type = with types; listOf (submodule {
        options = {
          path = mkOption { type = str; };
          section = mkOption {
            type = str;
            default = "apps";
          };
          options = mkOption {
            type = str;
            default = "";
          };
        };
      });
      default = [
        { path = "/System/Applications/Launchpad.app"; section = "apps"; }
        { path = "/Applications/Nix Apps/Kitty.app"; section = "apps"; }
        { path = "/Applications/Firefox.app"; section = "apps"; }
        { path = "/Applications/Nix Apps/Visual Studio Code.app"; section = "apps"; }

        { path = "/Applications/Microsoft Outlook.app"; section = "apps"; }
        { path = "/Applications/WhatsApp.app"; section = "apps"; }
        { path = "/Applications/Microsoft Teams.app"; section = "apps"; }

        { path = "/Applications/1Password.app"; section = "apps"; }
	
	{ path = "/System/Applications/Calendar.app/"; section = "apps"; }
	{ path = "/Applications/Whisky.app"; section = "apps"; }
        { path = "/Applications/Nix Apps/Spotify.app"; section = "apps"; }
        { path = "/Applications/Nix Apps/Discord.app"; section = "apps"; }
      ];
    };

    local.dock.position = mkOption {
      description = "dock position";
      type = types.str;
      default = "left";
      example = "bottom";
    };

    local.dock.size = mkOption {
      description = "dock size";
      type = types.float;
      default = 40.0;
      example = 62.5;
    };
  };

  config = mkIf config.local.dock.enable (
    let
      normalize = path: if hasSuffix ".app" path then path + "/" else path;
      entryURI = path: "file://" + (builtins.replaceStrings
        [" "   "!"   "\""  "#"   "$"   "%"   "&"   "'"   "("   ")"]
        ["%20" "%21" "%22" "%23" "%24" "%25" "%26" "%27" "%28" "%29"]
        (normalize path)
      );
      wantURIs = concatMapStrings
        (entry: "${entryURI entry.path}\n")
        config.local.dock.entries;
      createEntries = concatMapStrings
        (entry: "${dockutil}/bin/dockutil --no-restart --add '${entry.path}' --section ${entry.section} ${entry.options}\n")
        config.local.dock.entries;
    in
    {
      system.activationScripts.postUserActivation.text = ''
        echo >&2 "setting up dock"
        haveURIs="$(${dockutil}/bin/dockutil --list | ${pkgs.coreutils}/bin/cut -f2)"
        if ! diff -wu <(echo -n "$haveURIs") <(echo -n '${wantURIs}') >&2 ; then
          echo >&2 "resetting dock"
          ${dockutil}/bin/dockutil --no-restart --remove all
          ${createEntries}
        else
          echo >&2 "dock setup complete"
        fi

        echo >&2 "setting dock position to ${config.local.dock.position}..."
        defaults write com.apple.dock orientation -string "${config.local.dock.position}"

        echo >&2 "setting dock size to ${toString config.local.dock.size}..."
        defaults write com.apple.dock tilesize -float "${toString config.local.dock.size}"

        echo >&2 "restarting dock"
        pkill Dock || killall Dock || echo "unable to restart dock, check manually"
      '';
    }
  );
}

