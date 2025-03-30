function l --wraps='ls -alh' --wraps='eza -AhlT -L=1 -s=extension --group-directories-first --icons --git --git-ignore' --description 'alias l=eza -AhlT -L=1 -s=extension --group-directories-first --icons --git --git-ignore'
  eza -AhlT -L=1 -s=extension --group-directories-first --icons --git --git-ignore $argv
        
end
