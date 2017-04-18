{% set pwd = salt['environ.get']('DIR') %}
{% set src = salt['environ.get']('SRC') %}
{% set user = salt['environ.get']('USER') %}

# Symlinks
{% set links = {
  '~/.agignore': 'agignore',
  '~/.bash_profile': 'bash_profile',
  '~/.bashrc': 'bashrc',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
  '~/.gitconfig': 'gitconfig',
  '~/.gitignore': 'gitignore',
  '~/.isort.cfg': 'isort.cfg',
  '~/.pylintrc': 'pylintrc',
  '~/.ssh/config': 'sshconfig',
  '~/.tigrc': 'tigrc',
  '~/.tmux.conf': 'tmux.conf',
  '~/.tmux.reset.conf': 'tmux.reset.conf',
  '~/.vimrc': 'vimrc',
  '~/.xvimrc': 'xvimrc',
  '~/.zsh_theme.zsh': 'zsh_theme.zsh',
  '~/.zshrc': 'zshrc',
} %}
{% set bashrc = {
  '~/.bashrc.d/common.bash': 'bashrc.d/common.bash',
  '~/.bashrc.d/functions.bash': 'bashrc.d/functions.bash',
  '~/.bashrc.d/prompt.bash': 'bashrc.d/prompt.bash',
} %}
{% do links.update(bashrc) %}

# Bash completion.
{% for completion in salt['file.find'](path='sources/bash_completion', name='*.bash') %}
{% set basename = completion.split('/')[-1] %}
{% do links.update({
  salt['environ.get']('BASH_COMPLETION_DIR') ~ '/' ~ basename: 'bash_completion/' ~ basename
}) %}
{% endfor %}

{% for name, source in links.iteritems() %}
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
  src ~ '/profile/.bash_profile': 'devbox_bash_profile',
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
