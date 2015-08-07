#!/usr/bin/env python

import os
import os.path

def getSubDirs(loc):
    return [os.path.join(loc,o) for o in os.listdir(loc) if os.path.isdir(os.path.join(loc,o))]

repos = []
for subPath in getSubDirs('./'):
    subHead ,subDir = os.path.split(subPath)

    if subDir == '.git':
        repos = ['.'] + repos
    else:
        for subSubPath in getSubDirs(subDir):
            subSubHead ,subSubDir = os.path.split(subSubPath)
            
            if (subSubDir == '.git'):
                repos += [subDir]

print( '\033[1mGit repos:\033[0m' )

for repo in repos:
    print( repo )
