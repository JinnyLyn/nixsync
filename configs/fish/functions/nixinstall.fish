function nixinstall --wraps='nix-env -iA nixos.' --description 'alias nixinstall=nix-env -iA nixos.'
  nix-env -iA nixos. $argv
        
end
