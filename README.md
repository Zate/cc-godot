# Godot Development Plugin for Claude Code

A comprehensive Claude Code plugin for Godot game development with namespaced commands, intelligent agents, and automated environment setup.

## Features

- **🎮 Namespaced Commands** - `/gd:setup`, `/gd:init-game`, `/gd:run`, `/gd:stop`
- **🤖 Game Planning Agent** - Interactive AI-assisted game design
- **🧠 Godot Expertise Skill** - Automatic activation for Godot-specific questions
- **🔧 Environment Validation** - Automatic checks on session start
- **📦 MCP Integration** - Seamless integration with Godot MCP server

## Installation

### Prerequisites

1. **Godot Engine** (4.5.1+) - [Download](https://godotengine.org)
2. **Node.js** (18+) - Required for Godot MCP server
3. **Godot MCP Server** - Clone and build:
   ```bash
   git clone <godot-mcp-repo-url> ~/projects/godot-mcp
   cd ~/projects/godot-mcp
   npm install
   npm run build
   ```

### Install the Plugin

1. **Add the Godot Game Development marketplace**

   From Claude Code in any directory:
   ```
   /plugin marketplace add https://github.com/your-username/godot-claude-plugin
   ```

   Or for local development:
   ```
   /plugin marketplace add /absolute/path/to/godot-claude-plugin
   ```

2. **Install the plugin**
   ```
   /plugin install gd@godot-gamedev
   ```

   The plugin will be available with the namespace `/gd:*`

## Quick Start

1. **Open your Godot project in Claude Code**
   ```bash
   cd my-godot-game
   claude .
   ```

2. **Run setup to configure the environment**
   ```
   /gd:setup
   ```
   This will:
   - Auto-detect Godot installation
   - Verify Godot MCP server is built
   - Create `.mcp.json` configuration in your project
   - Validate everything is working

3. **Restart Claude Code** (required for MCP changes to take effect)

4. **Initialize a new game (optional)**
   ```
   /gd:init-game
   ```
   Launches an interactive planning agent that will:
   - Ask about your game (2D/3D, genre, mechanics, etc.)
   - Generate a comprehensive game design document
   - Create project folder structure
   - Set up initial scenes

5. **Start developing!**
   ```
   /gd:run    # Test your game
   /gd:stop   # Stop the game
   ```

## Available Commands

| Command | Description |
|---------|-------------|
| `/gd:setup` | Configure Godot development environment and MCP server |
| `/gd:init-game` | Interactive game planning and project initialization |
| `/gd:run` | Launch the game for testing |
| `/gd:stop` | Stop the running game instance |

## Plugin Components

### Commands (`commands/`)
Slash commands for common Godot workflows with the `/gd:` namespace.

### Agents (`agents/`)
- **game-planner** - Interactive game design assistant that asks questions and creates comprehensive game plans

### Skills (`skills/`)
- **godot-dev** - Godot Engine expertise that automatically activates when you ask Godot-related questions

### Hooks (`hooks/`)
- **SessionStart** - Validates your environment configuration when you start a Claude Code session

### Scripts (`scripts/`)
- Helper bash scripts for environment validation and setup
- Referenced by commands via `${CLAUDE_PLUGIN_ROOT}`

## How It Works

### Environment Setup
The `/gd:setup` command:
1. Checks for Godot installation at common locations (macOS, Linux, Windows)
2. Verifies the Godot MCP server is built at `~/projects/godot-mcp`
3. Creates `.mcp.json` in your project with correct paths
4. If `.mcp.json` exists, validates the paths instead of recreating

### Game Planning
The `/gd:init-game` command launches the game-planner agent which:
1. Asks about game type (2D/3D), genre, art style
2. Gathers core mechanics and technical requirements
3. Generates a detailed game design document
4. Creates project structure (scenes/, scripts/, assets/, resources/)
5. Sets up initial scenes based on your game type

### Automatic Assistance
The godot-dev skill automatically activates when you:
- Ask about Godot features ("How do I add a sprite?")
- Need help with GDScript ("How do I implement player movement?")
- Want project organization advice ("What's the best folder structure?")

## Working with the Plugin

### Creating Scenes
Just ask Claude and it will use the Godot MCP tools:
```
Create a player character scene with Sprite2D and CollisionShape2D
```

### Adding Features
```
Add a jump mechanic to my player character
Implement a health system with UI
Create an enemy AI that follows the player
```

### Getting Help
```
How do I make my camera follow the player smoothly?
What node types should I use for a 2D platformer?
How do I handle collision detection in Godot?
```

## Configuration

### MCP Server
The plugin expects the Godot MCP server at:
```
~/projects/godot-mcp/build/index.js
```

The `/gd:setup` command will create `.mcp.json` in your project:
```json
{
  "mcpServers": {
    "godot": {
      "command": "node",
      "args": ["/path/to/godot-mcp/build/index.js"],
      "env": {
        "GODOT_PATH": "/path/to/Godot"
      }
    }
  }
}
```

### Customization
You can modify the plugin by editing files in the plugin directory and restarting Claude Code.

## Troubleshooting

### "MCP server not configured"
Run `/gd:setup` to configure the environment. Make sure:
- Godot is installed
- MCP server is built at `~/projects/godot-mcp`

### MCP tools not available
Restart Claude Code after running `/gd:setup`

### Commands not appearing
Make sure the plugin is installed:
```
/plugin list
```

### Godot not detected
Install Godot at a standard location or set `GODOT_PATH` environment variable.

## Development

### Plugin Structure
```
godot-claude-plugin/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── commands/                 # Slash commands
│   ├── setup.md
│   ├── init-game.md
│   ├── run.md
│   └── stop.md
├── agents/                   # Custom agents
│   └── game-planner.md
├── skills/                   # Agent skills
│   └── godot-dev/
│       └── SKILL.md
├── hooks/                    # Event hooks
│   └── hooks.json
├── scripts/                  # Helper scripts
│   ├── validate-env.sh
│   ├── setup-mcp.sh
│   └── init-project.sh
└── .mcp.json.template       # MCP configuration template
```

### Contributing
Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test thoroughly in a real Godot project
4. Submit a pull request

## License

MIT License - See LICENSE file for details

## Links

- [Godot Engine](https://godotengine.org)
- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Godot MCP Server](https://github.com/your-username/godot-mcp)

---

**Happy Game Development! 🎮**
