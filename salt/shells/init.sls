Ensure /usr/local/bin/bash is an allowed shell:
  cmd.run:
    - name: echo /usr/local/bin/bash | sudo tee -a /etc/shells
    - unless: grep /usr/local/bin/bash /etc/shells

Ensure /usr/local/bin/bash is the default shell:
  cmd.run:
    - name: chsh -s /usr/local/bin/bash
    - unless: '[ "$SHELL" == "/usr/local/bin/bash" ]'
