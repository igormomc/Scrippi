# Scrippi

## Overview
Scrippi is a versatile macOS menu bar app designed to streamline and simplify the execution of scripts and commands directly from your desktop. With a focus on efficiency and ease of use, Scrippi provides quick access to a range of predefined functionalities, enhancing productivity for both developers and general users.

## Features
- **Customizable Menu**: Users can easily add, remove, or modify menu items to fit their specific needs.
- **Script Execution**: Execute predefined scripts or commands with a single click.
- **JSON Configuration**: All menu items are configured through a simple JSON file, allowing for rapid changes and customization.
- **Dark Mode Compatibility**: Icons adapt seamlessly to both light and dark modes of macOS for an integrated user experience.

## How It Works
Scrippi reads a JSON file that defines the structure and commands of the menu items. Users can modify this file to tailor the app's functionality to their needs.

### Example JSON Structure
```json
{
    "menu": [
        {
            "type": "separator"
        },
        {
            "title": "Command Name",
            "script": "command_to_execute"
        },
        // Add more commands or separators as needed
    ]
}
