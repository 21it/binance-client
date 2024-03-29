#!/bin/sh

export VIM_BACKGROUND="${VIM_BACKGROUND:-light}"
export VIM_COLOR_SCHEME="${VIM_COLOR_SCHEME:-PaperColor}"
echo "starting nixos container"
docker run -it --rm \
  -e NIXPKGS_ALLOW_BROKEN=1 \
  -p 3000:3000 \
  -v "$(pwd):/app" \
  -v "nix:/nix" \
  -v "nix-19.09-root:/root" \
  -w "/app" nixos/nix:2.3 sh -c "
  ./nix/bootstrap.sh &&
  nix-shell ./nix/shell.nix --pure \
   -I ssh-config-file=/tmp/.ssh/config \
   --argstr vimBackground $VIM_BACKGROUND \
   --argstr vimColorScheme $VIM_COLOR_SCHEME \
   --argstr gitAuthorName $GIT_AUTHOR_NAME \
   --argstr gitAuthorEmail $GIT_AUTHOR_EMAIL \
   --option sandbox false \
   -v --show-trace
  "
