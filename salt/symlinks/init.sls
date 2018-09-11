{% set src = salt['environ.get']('SRC') %}
{% set user = salt['environ.get']('USER') %}

{% set file_root = salt['config.get']('file_roots')['base'][0] %}
{% set dotfiles = salt['file.dirname'](file_root) %}
{% set sources_dir = dotfiles ~ '/' ~ 'sources' %}

# Symlinks
{% set links = {
  '~/.agignore': 'agignore',
  '~/.config/alacritty/alacritty.yml': 'alacritty.yml',
  '~/.bash_completion': 'bash_completion',
  '~/.bash_completion.d': 'bash_completion.d',
  '~/.bash_profile': 'bash_profile',
  '~/.bashrc': 'bashrc',
  '~/.bashrc.d': 'bashrc.d',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
  '~/.eslintrc.yml': 'eslintrc.yml',
  '~/.gitconfig': 'gitconfig',
  '~/.gitignore': 'gitignore',
  '~/.ipython/profile_default/ipython_config.py': 'ipython_config.py',
  '~/.isort.cfg': 'isort.cfg',
  '~/.ssh/config': 'sshconfig',
  '~/.tigrc': 'tigrc',
  '~/.tmux.conf': 'tmux.conf',
  '~/.tmux.reset.conf': 'tmux.reset.conf',
  '~/.vimrc': 'vimrc',
  '~/.xvimrc': 'xvimrc',
  '~/.zsh_theme.zsh': 'zsh_theme.zsh',
  '~/.zshrc': 'zshrc',
} %}

# Bash completion.
{% for completion in salt['file.find'](path='sources/bash_completion', name='*.bash') %}
{% set basename = completion.split('/')[-1] %}
{% do links.update({
  salt['environ.get']('BASH_COMPLETION_DIR') ~ '/' ~ basename: 'bash_completion/' ~ basename
}) %}
{% endfor %}

{% for name, source in links.items() %}
Ensure {{ name }} is symlinked to from {{ source }}:
  file.symlink:
    - name: {{ name }}
    - target: {{ sources_dir }}/{{ source }}
    - user: {{ user }}
    - force: True
    - makedirs: True
{% endfor %}

# Files
{% for name, source in {
  '~/.docker/config.json': 'docker_config.json',
  src ~ '/profile/.bash_profile': 'devbox_bash_profile',
}.items() %}
Ensure {{ name }} is managed:
  file.managed:
    - name: {{ name }}
    - source: {{ sources_dir }}/{{ source }}
    - user: {{ user }}
    - force: True
    - makedirs: True
{% endfor %}

Ensure neovim config is linked:
  file.symlink:
    - name: ~/.config/nvim
    - target: /Users/{{ user }}/.vim
    - user: {{ user }}
    - makedirs: True

Ensure neovimrc is linked:
  file.symlink:
    - name: ~/.config/nvim/init.vim
    - target: {{ sources_dir }}/vimrc
    - user: {{ user }}
    - makedirs: True
