---
description: Run the Godot game project
allowed-tools:
  - mcp__godot__run_project
  - mcp__godot__get_debug_output
---

Run the current Godot project using the MCP server.

1. Use mcp__godot__run_project with projectPath set to the current working directory
2. Wait a moment, then use mcp__godot__get_debug_output to display any output or errors
3. Inform the user that the game is running and they can use `/stop` to stop it
4. If there are errors, display them clearly and offer to help debug
