{% for name, source in {
  '~/.gitconfig': 'gitconfig',
  '~/.gitignore': 'gitignore',
}.iteritems() %}
Ensure {{ name }} is managed from {{ source }}:
  file.managed:
    - name: {{ name }}
    - source: salt://{{ source }}
    - makedirs: True
    - template: jinja
{% endfor %}

{% for name, source in {
  '~/.agignore': 'agignore',
  '~/.config/flake8': 'flake8',
  '~/.ctags': 'ctags',
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
    - target: {{ salt['environ.get']('SOURCES') }}/{{ source }}
    - user: {{ salt['environ.get']('ME') }}
    - backupname: {{ name }}.bak
    - makedirs: True
{% endfor %}
