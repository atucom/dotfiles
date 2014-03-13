#!/bin/bash
echo "Ruby - Gem Path"
printf '\t'
ruby -r rubygems -e "puts Gem.path.join(':')"
echo "Gem - Gem Path"
printf '\t'
gem env gempath
echo "Gem - Gem Install Dir"
printf '\t'
gem env gemdir
echo "ENV - GEM_HOME"
printf '\t'
echo $GEM_HOME
echo "ENV - GEM_PATH"
printf '\t'
echo $GEM_PATH
