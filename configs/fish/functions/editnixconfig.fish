function editnixconfig --wraps='sudo vim /etc/nixos/configuration.nix' --description 'alias editnixconfig=sudo vim /etc/nixos/configuration.nix'
  sudo vim /etc/nixos/configuration.nix $argv
        
end
