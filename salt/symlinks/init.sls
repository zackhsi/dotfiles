{% set user = salt['environ.get']('USER') %}

{% set file_root = salt['config.get']('file_roots')['base'][0] %}
{% set dotfiles = salt['file.dirname'](file_root) %}
{% set sources_dir = dotfiles ~ '/' ~ 'sources' %}

# Symlinks
{% set links = {
  '~/.agignore': 'agignore',
  '~/.bash_completion': 'bash_completion',
  '~/.bash_completion.d': 'bash_completion.d',
  '~/.bash_profile': 'bash_profile',
  '~/.bashrc': 'bashrc',
  '~/.bashrc.d': 'bashrc.d',
  '~/.config/alacritty/alacritty.yml': 'alacritty.yml',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
  '~/.eslintrc.yml': 'eslintrc.yml',
  '~/.gitconfig': 'gitconfig',
  '~/.gitignore': 'gitignore',
  '~/.ipython/profile_default/ipython_config.py': 'ipython_config.py',
  '~/.isort.cfg': 'isort.cfg',
  '~/.rubocop.yml': 'rubocop.yml',
  '~/.tigrc': 'tigrc',
  '~/.tmux.conf': 'tmux.conf',
  '~/.tmux.reset.conf': 'tmux.reset.conf',
  '~/.config/nvim/init.vim': 'init.vim',
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
