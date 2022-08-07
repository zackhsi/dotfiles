Ensure /opt/homebrew/bin/bash is an allowed shell:
  cmd.run:
    - name: echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
    - unless: grep /opt/homebrew/bin/bash /etc/shells

Ensure /opt/homebrew/bin/bash is the default shell:
  cmd.run:
    - name: chsh -s /opt/homebrew/bin/bash
    - unless: '[ "$SHELL" == "/opt/homebrew/bin/bash" ]'
