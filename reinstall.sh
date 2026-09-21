#!/usr/bin/env bash
brew uninstall jefyokta/hightex/hightex
git add .
git commit -m "dasds4t3q"
git push

brew untap jefyokta/hightex
brew tap jefyokta/hightex
brew install --cask jefyokta/hightex/hightex