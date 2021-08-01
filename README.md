# binance-client

Binance API client library for Haskell.

## Development

Setup environment:

```shell
vi ~/.profile

# git user info
export GIT_AUTHOR_NAME="tkachuk-labs"
export GIT_AUTHOR_EMAIL="tkachuk.labs@gmail.com"
# optional appearance parameters
export VIM_BACKGROUND="light" # or "dark"
export VIM_COLOR_SCHEME="PaperColor" # or "jellybeans"
```

And then:

```shell
# start nix-shell
./nix/shell.sh

# run tests in nix-shell
stack test --fast

# develop in nix-shell
vi .
```
