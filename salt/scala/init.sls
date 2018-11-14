Ensure coursier is available at /usr/local/bin/coursier:
  cmd.run:
    - name: curl -L -o /usr/local/bin/coursier https://git.io/coursier
    - unless: test -f /usr/local/bin/coursier

Ensure coursier is executable:
  cmd.run:
    - name: chmod +x /usr/local/bin/coursier
    - unless: test -x /usr/local/bin/coursier

# Requires `coursier` to be installed already via homebrew.
Ensure scalafmt_ng is available at /usr/local/bin/scalafmt_ng:
  cmd.run:
    - name: coursier bootstrap --standalone com.geirsson:scalafmt-cli_2.12:1.5.1 -r bintray:scalameta/maven -o /usr/local/bin/scalafmt_ng -f --main com.martiansoftware.nailgun.NGServer
    - unless: test -x /usr/local/bin/scalafmt_ng
