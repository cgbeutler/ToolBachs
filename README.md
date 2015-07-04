Lame Scripts
Scripts to help make life less lame!

br.sh
  Creates a line of === signs accross the screen with a red backround.
  Useful for when you need a visual break on the command line.
  (Better than hitting enter a bunch of times...)

qsync.sh
  Sets up quick sync stuff that uses rsync to keep two directories synced.
  Places a .qsync file in the directory chosen that allows for you
  to ignore certain files and set custom target folders.
  This is designed for people who like to work on their own computer with
  all their setup files. This does not mess with the remote targets, just
  the computer this script is on.
  Example:
  qsync.sh setup
  [edit the .qsync file how you want it]
  qsync.sh pull work-files
  [edit the work files]
  qsync.sh push work-files
