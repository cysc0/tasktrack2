export MIX_ENV=prod
export PORT=4794

echo "Stopping old copy of app, if any..."

_build/prod/rel/tasktrack/bin/tasktrack stop || true

echo "Starting app..."

# Foreground for testing and for systemd
_build/prod/rel/tasktrack/bin/tasktrack foreground