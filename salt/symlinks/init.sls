{% set pwd = salt['environ.get']('DIR') %}
{% set src = salt['environ.get']('SRC') %}
{% set user = salt['environ.get']('ME') %}

{% for name, source in {
  '~/.agignore': 'agignore',
  src ~ '/profile/.bash_profile': 'bash_profile',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
  '~/.gitconfig': 'gitconfig',
  '~/.gitignore': 'gitignore',
  '~/.isort.cfg': 'isort.cfg',
  '~/.ssh/config': 'sshconfig',
  '~/.tigrc': 'tigrc',
  '~/.tmux.conf': 'tmux.conf',
  '~/.tmux.reset.conf': 'tmux.reset.conf',
  '~/.vimrc': 'vimrc',
  '~/.xvimrc': 'xvimrc',
  '~/.zsh_aliases': 'zsh_aliases',
  '~/.zshrc': 'zshrc',
}.iteritems() %}
Ensure {{ name }} is symlinked to from {{ source }}:
  file.symlink:
    - name: {{ name }}
    - target: {{ pwd }}/sources/{{ source }}
    - user: {{ user }}
    - force: True
    - makedirs: True
{% endfor %}

Ensure neovim config is linked:
  file.symlink:
    - name: ~/.config/nvim
    - target: /Users/{{ user }}/.vim
    - user: {{ user }}

Ensure neovimrc is linked:
  file.symlink:
    - name: ~/.config/nvim/init.vim
    - target: {{ pwd }}/sources/vimrc
    - user: {{ user }}
