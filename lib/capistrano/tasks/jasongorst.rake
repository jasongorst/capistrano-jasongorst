namespace :jasongorst do
  desc "Check if ssh-agent forwarding is working"
  task :ensure_ssh_forwarding do
    on roles(:all) do |h|
      if test(:git, "ls-remote", "--exit-code", fetch(:repo_url))
        info "ssh-agent forwarding is up to #{h}"
      else
        warn "ssh-agent forwarding is NOT up to #{h}"
        invoke :add_ssh_keys
      end
    end
  end

  desc "Add private keys to ssh-agent"
  task :add_ssh_keys do
    run_locally do
      execute :'ssh-add'
    end
  end

  desc "Ensure local repository is pushed to remote"
  task :ensure_pushed do
    invoke :set_remote_from_config unless fetch(:remote)

    run_locally do
      if test "[ $(git log #{fetch(:remote)}/#{fetch(:branch)}..#{fetch(:branch)} | wc -l) -ne 0 ]"
        warn "Your branch #{fetch(:branch)} needs to be pushed to #{fetch(:remote)}"
        invoke :git_push
      else
        info "Your branch #{fetch(:branch)} is up to date on remote #{fetch(:remote)}"
      end
    end
  end

  desc "Push local changes to remote"
  task :git_push do
    invoke :set_remote unless fetch(:remote)

    run_locally do
      execute :git, "push #{fetch(:remote)} #{fetch(:branch)}"
    end
  end

  desc "Set git remote from git config"
  task :set_remote_from_config do
    set :remote do
      run_locally do
        capture :git, "config --get branch.main.remote"
      end
    end
  end
end
