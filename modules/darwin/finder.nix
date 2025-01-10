{
  config,
  lib,
  ...
}: let
  user = "karolbroda";
  home = "/Users/${user}";
in {
  config = {
    system.defaults.finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NewWindowTarget = "Home";
      FXPreferredViewStyle = "Nlsv";
      ShowHardDrivesOnDesktop = true;
      ShowExternalHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
    };

    system.defaults.NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
    };

    system.activationScripts.sidebarConfig = {
      text = ''
        echo >&2 "configuring Finder sidebar..."

        /usr/bin/defaults write com.apple.sidebarlists favoritesitems -array-add '
          <dict>
            <key>CustomItemProperties</key>
            <dict>
              <key>com.apple.LSSharedFileList.CustomItemSharepointURL</key>
              <string>file://${home}/work</string>
            </dict>
            <key>Name</key>
            <string>Work</string>
          </dict>'
        /usr/bin/defaults write com.apple.sidebarlists favoritesitems -array-add '
          <dict>
            <key>CustomItemProperties</key>
            <dict>
              <key>com.apple.LSSharedFileList.CustomItemSharepointURL</key>
              <string>file://${home}/personal</string>
            </dict>
            <key>Name</key>
            <string>Personal</string>
          </dict>'

        /usr/bin/defaults write com.apple.sidebarlists systemitems -dict-add VolumeShowOnSidebar -bool true
        /usr/bin/defaults write com.apple.sidebarlists systemitems -dict-add HardDrivesShowOnSidebar -bool true
        /usr/bin/defaults write com.apple.sidebarlists systemitems -dict-add ExternalShowOnSidebar -bool true
        /usr/bin/defaults write com.apple.sidebarlists systemitems -dict-add RemovableShowOnSidebar -bool true
        /usr/bin/defaults write com.apple.sidebarlists systemitems -dict-add NetworkShowOnSidebar -bool true

        /usr/bin/defaults write com.apple.sidebarlists favoritesitems -array-remove '
          <dict>
            <key>CustomItemProperties</key>
            <dict>
              <key>com.apple.LSSharedFileList.CustomItemSharepointURL</key>
              <string>file://${home}/Library/Mobile%20Documents</string>
            </dict>
            <key>Name</key>
            <string>iCloud Drive</string>
          </dict>'
      '';
    };
  };
}
