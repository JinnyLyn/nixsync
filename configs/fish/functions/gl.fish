function gl --wraps='git pull --rebase --autostash' --description 'alias gl=git pull --rebase --autostash'
  git pull --rebase --autostash $argv
        
end
