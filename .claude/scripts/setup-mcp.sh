#!/bin/bash

# Godot MCP Server Setup Script
# Detects Godot and MCP server, creates .mcp.json configuration

set -e  # Exit on error

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
MCP_TEMPLATE="$PROJECT_DIR/.mcp.json.template"
MCP_CONFIG="$PROJECT_DIR/.mcp.json"

echo "🎮 Godot Development Environment Setup"
echo "======================================"
echo ""

# Check if .mcp.json already exists
if [ -f "$MCP_CONFIG" ]; then
    echo "⚠️  .mcp.json already exists."
    read -p "Do you want to overwrite it? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
fi

# Check if template exists
if [ ! -f "$MCP_TEMPLATE" ]; then
    echo "❌ Error: .mcp.json.template not found"
    echo "Expected at: $MCP_TEMPLATE"
    exit 1
fi

# Detect Godot installation
echo "🔍 Detecting Godot installation..."
GODOT_PATH=""

# Try common locations
if [ -f "/Applications/Godot.app/Contents/MacOS/Godot" ]; then
    GODOT_PATH="/Applications/Godot.app/Contents/MacOS/Godot"
    echo "   Found Godot (macOS): $GODOT_PATH"
elif command -v godot &> /dev/null; then
    GODOT_PATH=$(which godot)
    echo "   Found Godot in PATH: $GODOT_PATH"
elif [ -n "$GODOT_PATH" ]; then
    echo "   Using GODOT_PATH environment variable: $GODOT_PATH"
else
    echo "   ⚠️  Could not auto-detect Godot"
    read -p "   Enter Godot path (or press Enter to skip): " GODOT_PATH
fi

if [ -z "$GODOT_PATH" ]; then
    echo "❌ Godot path required. Please install Godot and run setup again."
    exit 1
fi

# Verify Godot exists
if [ ! -f "$GODOT_PATH" ] && [ ! -x "$GODOT_PATH" ]; then
    echo "❌ Godot not found at: $GODOT_PATH"
    exit 1
fi

echo "✓ Godot found"
echo ""

# Check Godot MCP server
echo "🔍 Checking Godot MCP server..."
MCP_SERVER_PATH="$HOME/projects/godot-mcp/build/index.js"

if [ ! -f "$MCP_SERVER_PATH" ]; then
    echo "   ⚠️  MCP server not found at: $MCP_SERVER_PATH"
    echo ""
    echo "   The Godot MCP server needs to be installed and built."
    echo "   Expected location: ~/projects/godot-mcp"
    echo ""
    echo "   To install:"
    echo "   1. Clone the repository:"
    echo "      git clone <godot-mcp-repo-url> ~/projects/godot-mcp"
    echo "   2. Build the server:"
    echo "      cd ~/projects/godot-mcp"
    echo "      npm install"
    echo "      npm run build"
    echo ""
    exit 1
fi

echo "✓ MCP server found"
echo ""

# Create .mcp.json from template
echo "📝 Creating .mcp.json configuration..."

# Read template and replace placeholders
sed "s|GODOT_MCP_PATH_PLACEHOLDER|$MCP_SERVER_PATH|g; s|GODOT_PATH_PLACEHOLDER|$GODOT_PATH|g" "$MCP_TEMPLATE" > "$MCP_CONFIG"

echo "✓ Configuration created"
echo ""

# Verify the configuration
echo "📋 Configuration:"
echo "   Godot: $GODOT_PATH"
echo "   MCP Server: $MCP_SERVER_PATH"
echo ""

echo "✅ Setup complete!"
echo ""
echo "⚠️  IMPORTANT: Restart Claude Code for MCP server changes to take effect"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code"
echo "  2. Run /init-game to start planning your game"
echo "  3. Use /run to test your game"
echo ""

exit 0
