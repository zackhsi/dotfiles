{% set pwd = salt['environ.get']('DIR') %}
{% set src = salt['environ.get']('SRC') %}
{% set user = salt['environ.get']('USER') %}

{% for name, source in {
  '~/.agignore': 'agignore',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
  '~/.docker/config.json': 'docker_config.json',
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
  src ~ '/profile/.bash_profile': 'bash_profile',
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

{% for bin in [
  'imgcat',
] %}
Ensure {{ bin }} is linked to /usr/local/bin:
  file.symlink:
    - name: /usr/local/bin/{{ bin }}
    - target: {{ pwd }}/bin/{{ bin }}
    - user: {{ user }}
    - group: admin
    - force: True
{% endfor %}
