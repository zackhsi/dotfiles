#!/bin/bash
set -e

ITUNES_TRACK=$(osascript << EOF
if appIsRunning("iTunes") then
    tell app "iTunes" to get the name of the current track
end if
on appIsRunning(appName)
    tell app "System Events" to (name of processes) contains appName
end appIsRunning
EOF
)
if test "x$ITUNES_TRACK" != "x"; then
  ITUNES_ARTIST=$(osascript << EOF
  if appIsRunning("iTunes") then
      tell app "iTunes" to get the artist of the current track
  end if
  on appIsRunning(appName)
      tell app "System Events" to (name of processes) contains appName
  end appIsRunning
EOF
)
  echo '#[bold] ♫' "$ITUNES_ARTIST" '#[nobold]-#[bold]' "$ITUNES_TRACK" '#[nobold]'
fi
