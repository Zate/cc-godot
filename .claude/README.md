# Godot Game Development Plugin

This directory contains a Claude Code plugin designed to streamline Godot game development with AI assistance.

## Components

### Commands (`commands/`)

Custom slash commands for common Godot workflows:

- **`/setup`** - Validates and configures the Godot development environment
  - Detects Godot installation
  - Verifies Godot MCP server is built
  - Creates `.mcp.json` configuration
  - Provides guidance for missing dependencies

- **`/init-game`** - Initializes a new game project with interactive planning
  - Launches the game-planner agent
  - Creates project structure based on requirements
  - Sets up scenes and folders
  - Documents the project plan

- **`/run`** - Quickly run the current Godot project
  - Uses MCP tools to launch the game
  - Displays debug output and errors

- **`/stop`** - Stop the running Godot instance

### Agents (`agents/`)

Specialized autonomous agents:

- **`game-planner`** - Interactive game design assistant
  - Asks about game type, genre, mechanics
  - Gathers technical requirements
  - Produces comprehensive game design document
  - Recommends project structure and architecture

### Skills (`skills/`)

Autonomous capabilities that activate based on context:

- **`godot-dev`** - Godot Engine expertise
  - Activates when working with Godot-specific tasks
  - Provides knowledge about nodes, scenes, GDScript
  - Uses MCP tools automatically
  - Recommends best practices

### Hooks (`hooks/`)

Event-driven automation:

- **`SessionStart`** - Validates environment when starting a session
  - Checks if `.mcp.json` exists
  - Verifies MCP server and Godot paths
  - Displays friendly warnings if misconfigured
  - Non-blocking (exit code 0)

### Scripts (`scripts/`)

Helper utilities called by commands and hooks:

- **`validate-env.sh`** - Environment validation (used by SessionStart hook)
- **`setup-mcp.sh`** - MCP server configuration (used by /setup command)
- **`init-project.sh`** - Project structure initialization (used by /init-game)

## Architecture

### Command Flow

```
User types /setup
    ↓
setup.md executes
    ↓
Calls setup-mcp.sh script
    ↓
Script detects Godot & MCP paths
    ↓
Creates .mcp.json from template
    ↓
Reports success/failure
```

### Agent Flow

```
User types /init-game
    ↓
init-game.md executes
    ↓
Launches game-planner agent via Task tool
    ↓
Agent asks user questions
    ↓
Agent produces game design doc
    ↓
Command uses plan to create project structure
```

### Skill Activation

```
User: "How do I add a sprite to my character?"
    ↓
Claude matches against skill descriptions
    ↓
godot-dev skill activates automatically
    ↓
Provides Godot-specific guidance
    ↓
Uses MCP tools to make changes
```

### Hook Execution

```
User starts Claude Code session
    ↓
SessionStart hook triggers
    ↓
validate-env.sh runs
    ↓
Checks .mcp.json and paths
    ↓
Displays warnings if needed (non-blocking)
```

## MCP Server Configuration

The plugin expects the Godot MCP server to be configured in `.mcp.json`:

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

The `/setup` command creates this file automatically by:
1. Reading `.mcp.json.template`
2. Detecting Godot and MCP server paths
3. Replacing placeholders
4. Writing `.mcp.json`

## Customization

### Adding New Commands

1. Create a new `.md` file in `commands/`
2. Add frontmatter with `description` and `allowed-tools`
3. Write the command prompt
4. Restart Claude Code to load the command

Example:
```markdown
---
description: Export the game for a specific platform
allowed-tools:
  - mcp__godot__*
  - Bash(godot:*)
---

Export the Godot project for the specified platform...
```

### Adding New Skills

1. Create a subdirectory in `skills/`
2. Add a `SKILL.md` file with frontmatter
3. Include `name` and `description` fields
4. The skill activates automatically based on description match

### Modifying Hooks

Edit `hooks/hooks.json` to add new hook events. Available events:
- PreToolUse, PostToolUse
- UserPromptSubmit
- SessionStart, SessionEnd
- Stop, SubagentStop
- Notification
- PreCompact

### Adding Scripts

1. Create new `.sh` file in `scripts/`
2. Make it executable: `chmod +x script.sh`
3. Reference it from commands using `!bash .claude/scripts/script.sh`
4. Use `${CLAUDE_PROJECT_DIR}` for project-relative paths

## Environment Variables

Available in commands and scripts:
- `CLAUDE_PROJECT_DIR` - Absolute path to project root
- `CLAUDE_PLUGIN_ROOT` - Path to plugin directory (for plugins only)

## Best Practices

1. **Keep commands focused** - Each command should do one thing well
2. **Use scripts for complex logic** - Bash scripts for multi-step operations
3. **Make hooks non-blocking** - Exit code 0 for validation hooks
4. **Write clear descriptions** - Helps Claude know when to use skills/agents
5. **Restrict allowed-tools** - Only grant necessary permissions
6. **Document everything** - Future you will thank present you

## Troubleshooting

### Commands not appearing
- Restart Claude Code after adding/modifying commands
- Check for syntax errors in frontmatter

### Skills not activating
- Verify `description` field is specific and relevant
- Test by directly asking Claude questions that match the description
- Check for YAML syntax errors

### Hooks not running
- Verify hooks.json syntax is valid
- Check script paths are correct
- Make scripts executable
- Use `${CLAUDE_PROJECT_DIR}` for relative paths
- Restart Claude Code after modifying hooks

### MCP tools not available
- Verify `.mcp.json` exists and paths are correct
- Restart Claude Code after changing `.mcp.json`
- Check MCP server is built: `ls ~/projects/godot-mcp/build/index.js`
- Run `/setup` to reconfigure

## Contributing

When adding features to this plugin:
1. Update this README
2. Test thoroughly in a real project
3. Document expected behavior
4. Add error handling to scripts
5. Keep commands simple and composable

## Version History

- v1.0.0 - Initial plugin with setup, init-game, run/stop commands, game-planner agent, godot-dev skill
