#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

HOST="${HOST:-127.0.0.1}"
PORT="${PORT:-4700}"
BUNDLE_PATH="${BUNDLE_PATH:-vendor/bundle}"
LIVE_RELOAD="${LIVE_RELOAD:-false}"

if ! command -v bundle >/dev/null 2>&1; then
  echo "Bundler is required. Install Ruby Bundler first: gem install bundler" >&2
  exit 1
fi

bundle config set path "$BUNDLE_PATH" >/dev/null

if ! bundle check >/dev/null 2>&1; then
  echo "Installing Jekyll dependencies into $BUNDLE_PATH ..."
  bundle install
fi

echo "Serving Just the Docs at http://$HOST:$PORT"
bundle exec jekyll clean --config _config.yml
serve_args=(
  --config _config.yml
  --destination public
  --host "$HOST"
  --port "$PORT"
)

if [[ "$LIVE_RELOAD" == "true" ]]; then
  serve_args+=(--livereload)
fi

bundle exec jekyll serve "${serve_args[@]}" "$@"
