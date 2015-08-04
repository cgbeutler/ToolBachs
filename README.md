#Lame Scripts
Scripts to help make life less lame!

###br.sh
Useful for when you need a visual break on the command line.
(Better than hitting enter a bunch of times...)

Usage:

    br [-f fg_color] [-b bg_color] [a label for the bar]

With no args, it creates a line of `=` signs accross the screen with a red backround.

added two options and the ability to add a label.

-f [color] sets the foreground color for the break

-b [color] sets the background color for the break

any non-arg things will be turned into a label for the break. This makes it easy to search back through the command terminal for stuff.

###qsync.sh
Sets up quick sync stuff that uses `rsync` to keep two directories synced.

This is designed for people who like to work on their own computer with all their setup files. This does not mess with the target folders, just the one this script run from.

`qsync.sh setup` places a `.qsync` file in the current directory. Ignored files and targets are loaded from this file.

`qsync.sh pull [target]` can be used in directories with a `.qsync` file to sync the directory with the targets changes.

`qsync.sh push [target]` can be used in directories with a `.qsync` file to sync the directory's changes with the target.

######Example of use:
    qsync.sh setup
    [edit the .qsync file how you want it]
    qsync.sh pull work-files
    [edit the work files]
    qsync.sh push work-files

#####Issues to be aware of
Keep in mind that qsync just uses rsync. This means that moving and deleting files will not be applied. This also means that you cannot make changes in both the target and host without one of them being wiped out! I would recommend using rsync for a while first so you get the idea of how it works. If you need more power, use git or something. This is not meant to be a full on rpm. This is just a quick and dirty wrapper for rsync.
