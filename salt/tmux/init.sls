Ensure tmux plugin manager is cloned:
  git.latest:
    - name: https://github.com/tmux-plugins/tpm
    - target: /Users/{{ salt['environ.get']('USER') }}/.tmux/plugins/tpm
