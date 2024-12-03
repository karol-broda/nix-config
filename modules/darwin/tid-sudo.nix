{ config, pkgs, lib, ... }:

{
  config = {
    system.activationScripts.ensurePamSudoLocal = {
      text = ''
        if [ ! -f /etc/pam.d/sudo_local ]; then
          echo "creating /etc/pam.d/sudo_local..."
          echo 'auth       sufficient     pam_tid.so' | sudo tee /etc/pam.d/sudo_local
        else
          echo "/etc/pam.d/sudo_local already exists. skipping"
        fi
      '';
    };
  };
}
