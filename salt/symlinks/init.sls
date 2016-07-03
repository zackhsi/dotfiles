{% set pwd = salt['environ.get']('DIR') %}
{% set src = salt['environ.get']('SRC') %}
{% set user = salt['environ.get']('USER') %}

# Symlinks
{% for name, source in {
  '~/.agignore': 'agignore',
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
  '~/.zsh_theme.zsh': 'zsh_theme.zsh',
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

# Files
{% for name, source in {
  '~/.docker/config.json': 'docker_config.json',
  src ~ '/profile/.bash_profile': 'bash_profile',
}.iteritems() %}
Ensure {{ name }} is managed:
  file.managed:
    - name: {{ name }}
    - source: {{ pwd }}/sources/{{ source }}
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
