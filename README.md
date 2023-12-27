<p align="center">
  <img src="ScrippiLogoNoBg.png" width="250">
  <h1 align="center">Scrippi</h1>
  <h3 align="center">Streamlining Your Command Line Workflow</h3>
</p>

---
## Overview
Scrippi is a macOS menu bar app designed to enhance productivity by simplifying the execution of frequently used scripts and commands. It's especially useful for users who find themselves repeatedly running the same commands in the terminal, such as navigating to a work directory and executing `docker compose up`. Scrippi aims to save time and reduce repetitive strain by making these commands accessible with just a click.

## Features
- **Customizable Menu**: Add, remove, or modify menu items to suit your workflow.
- **Quick Script Execution**: Run predefined scripts or commands from the menu bar, eliminating the need to repeatedly type them in the terminal.
- **JSON Configuration**: Easily configure menu items through a JSON file for quick updates and customizations.
- **Dark Mode Compatibility**: Icons adapt to both light and dark modes of macOS.

## Efficiency in Everyday Tasks
Regular tasks, such as starting Docker containers in a specific work folder, can be tedious and repetitive. Scrippi streamlines these routines by allowing users to execute such commands directly from the menu bar. This efficiency is particularly beneficial for developers and IT professionals who regularly work with command-line tools and scripts.

### Example JSON Structure
```json
{
    "menu": [
        {
            "type": "separator"
        },
        {
            "title": "Start Docker",
            "script": "cd path/to/workfolder && docker compose up"
        },
        // Additional commands or separators as needed
    ]
}
