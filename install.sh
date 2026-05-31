#!/usr/bin/env bash
# install.sh — One-time Antigravity ADLC setup
#
# Writes ~/.gemini/GEMINI.md with the correct absolute path to this toolkit.
# After this runs, you can use /init in any new project without any further
# global configuration. Once /init has run in a project, that project carries
# its own .gemini/GEMINI.md and no longer depends on this global file.
#
# Usage:
#   chmod +x install.sh && ./install.sh

set -e

TOOLKIT_PATH="$(cd "$(dirname "$0")" && pwd)"
GEMINI_DIR="$HOME/.gemini"
GEMINI_FILE="$GEMINI_DIR/GEMINI.md"
TEMPLATE="$TOOLKIT_PATH/templates/gemini-rules-template.md"

echo "Antigravity ADLC — Global Setup"
echo "Toolkit path: $TOOLKIT_PATH"
echo ""

# Validate template exists
if [ ! -f "$TEMPLATE" ]; then
  echo "ERROR: Template not found at $TEMPLATE"
  echo "Make sure you are running this script from the adlc-toolkit root."
  exit 1
fi

# Create ~/.gemini/ if it doesn't exist
mkdir -p "$GEMINI_DIR"

# Warn if file already exists
if [ -f "$GEMINI_FILE" ]; then
  echo "WARNING: $GEMINI_FILE already exists."
  read -r -p "Overwrite? (y/N) " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted — existing file preserved."
    exit 0
  fi
fi

# Write rules with actual toolkit path substituted
sed "s|ADLC_TOOLKIT_PATH|$TOOLKIT_PATH|g" "$TEMPLATE" > "$GEMINI_FILE"

echo ""
echo "Done! Created: $GEMINI_FILE"
echo ""
echo "Next steps:"
echo "  1. Open any project in Antigravity and type /init to bootstrap ADLC"
echo "  2. After /init, the project carries its own .gemini/GEMINI.md"
echo "     — no global setup needed for that project going forward"
