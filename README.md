# Godot Game Development Template

A comprehensive template repository for creating Godot games with Claude Code and the Godot MCP server. This template includes a full Claude Code plugin with commands, agents, skills, and hooks to streamline your game development workflow.

## Features

- **Interactive Project Setup** - Automated environment validation and MCP configuration
- **Game Planning Agent** - AI-assisted game design and architecture planning
- **Quick Commands** - Slash commands for common tasks (run, stop, init)
- **Smart Assistance** - Godot expertise automatically available when needed
- **Environment Validation** - Automatic checks on session start
- **Best Practices** - Pre-configured folder structure and conventions

## Quick Start

### Prerequisites

1. **Godot Engine** (4.5.1+)
   - Download from [godotengine.org](https://godotengine.org)
   - macOS: Install to `/Applications/Godot.app`
   - Linux/Windows: Install to standard location or add to PATH

2. **Node.js** (18+)
   - Required to run the Godot MCP server

3. **Godot MCP Server**
   - Clone and build at `~/projects/godot-mcp`
   ```bash
   git clone <godot-mcp-repo-url> ~/projects/godot-mcp
   cd ~/projects/godot-mcp
   npm install
   npm run build
   ```

4. **Claude Code**
   - Install from [claude.com/code](https://claude.com/code)

### Using This Template

1. **Clone the template repository**
   ```bash
   git clone <this-repo-url> my-awesome-game
   cd my-awesome-game
   ```

2. **Open in Claude Code**
   ```bash
   claude .
   ```

3. **Run the setup command**
   ```
   /setup
   ```
   This will:
   - Detect your Godot installation
   - Verify the MCP server is built
   - Create `.mcp.json` configuration
   - Guide you through any missing steps

4. **Restart Claude Code**
   - Required for MCP server changes to take effect

5. **Initialize your game project**
   ```
   /init-game
   ```
   This will:
   - Ask you questions about your game
   - Create a comprehensive game plan
   - Set up project structure
   - Create initial scenes

6. **Start developing!**
   ```
   /run    # Test your game
   /stop   # Stop running game
   ```

## Available Commands

- **`/setup`** - Configure Godot development environment
- **`/init-game`** - Start a new game with interactive planning
- **`/run`** - Launch the game for testing
- **`/stop`** - Stop the running game

## Plugin Components

### Commands
Slash commands for quick workflows (setup, init-game, run, stop)

### Agents
- **game-planner** - Interactive game design assistant

### Skills
- **godot-dev** - Godot Engine expertise (activates automatically)

### Hooks
- **SessionStart** - Validates environment on startup

See [.claude/README.md](.claude/README.md) for detailed plugin documentation.

## Project Structure

After running `/init-game`, your project will have:

```
my-game/
├── .claude/              # Claude Code plugin
├── project.godot         # Godot project file
├── icon.svg             # Project icon
├── .mcp.json            # MCP server configuration (gitignored)
├── scenes/              # Game scenes
│   ├── main/
│   ├── ui/
│   ├── characters/
│   └── levels/
├── scripts/             # GDScript files
│   ├── autoload/
│   ├── characters/
│   └── systems/
├── assets/              # Art, audio, etc.
│   ├── sprites/
│   ├── audio/
│   └── fonts/
└── resources/           # Godot resources
    ├── materials/
    └── animations/
```

## Working with Godot & Claude Code

### Creating Scenes
Ask Claude to create scenes and it will use the Godot MCP tools:
```
Create a player character scene with a sprite and collision shape
```

### Adding Features
Claude understands Godot concepts and can help implement features:
```
Add a jump mechanic to my player character
Create a health system with UI display
Implement enemy AI with pathfinding
```

### Getting Help
The godot-dev skill automatically activates for Godot questions:
```
How do I make my camera follow the player smoothly?
What's the best way to organize my game scenes?
How do I handle input in Godot?
```

### Running Your Game
Use `/run` to quickly test changes, `/stop` to close the game window.

## Customization

### Modify Commands
Edit files in `.claude/commands/` to customize workflows.

### Add New Skills
Create new skills in `.claude/skills/` for specialized knowledge.

### Configure Hooks
Modify `.claude/hooks/hooks.json` to add automation.

See the [plugin documentation](.claude/README.md) for details.

## Troubleshooting

### "MCP server not configured"
Run `/setup` to configure the environment. Make sure the Godot MCP server is built at `~/projects/godot-mcp`.

### MCP tools not available after setup
Restart Claude Code for MCP server changes to take effect.

### Commands not appearing
Restart Claude Code after modifying command files.

### Godot not detected
Make sure Godot is installed at a standard location or set the `GODOT_PATH` environment variable.

## Learn More

- [Godot Documentation](https://docs.godotengine.org)
- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Plugin Documentation](.claude/README.md)

## License

MIT License - Feel free to use this template for any project!

## Contributing

Improvements to this template are welcome! Please submit issues or pull requests.

---

**Happy Game Development! 🎮**
