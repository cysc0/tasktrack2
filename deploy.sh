export MIX_ENV=prod
export PORT=4795
export NODEBIN='pwd'/assets/node_modules/.bin

echo "Building..."

mkdir -p ~/.config
mkdir -p priv/static

mix deps.get
mix compile
(cd assets && npm install)
(cd assets && webpack --mode production)
mix phx.digest

echo "Generating release..."
mix release

echo "Starting app..."

_build/prod/rel/tasktrack2/bin/tasktrack2 foreground
