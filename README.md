<p align="center">
  <img src="ScrippiLogoNoBg.png" width="250">
  <h1 align="center">Scrippi</h1>
  <h3 align="center">Streamlining Your Command Line Workflow</h3>
</p>

---

## Overview
Scrippi is a macOS menu bar app designed to enhance productivity by simplifying the execution of frequently used scripts and commands. Tailored for users who frequently run the same commands in the terminal, Scrippi makes these commands accessible with just a click, saving time and reducing repetitive strain.

## Features
- **Customizable Menu**: Add, remove, or modify menu items to fit your workflow.
- **Quick Script Execution**: Execute predefined scripts or commands from the menu bar without typing them in the terminal.
- **Multi-Script Execution**: Launch multiple scripts with a single menu item, allowing for simultaneous script execution across different terminals.
- **Terminal Preference**: Choose between using the standard macOS Terminal or iTerm for command execution in the settings.
- **JSON Configuration**: Easily configure menu items through a JSON file for rapid updates and customization.
- **Dark Mode Compatibility**: Icons adapt to both light and dark modes of macOS.

## Download and Opening Scrippi on macOS
You can download the latest version of Scrippi directly here: [Download Scrippi](https://github.com/igormomc/Scrippi/releases/download/v1.0.2/Scrippi.zip)

### Gatekeeper Security Warning
When you first download and try to open Scrippi on a macOS system, you may encounter a security warning from Gatekeeper. Gatekeeper is a security feature in macOS designed to protect your computer by only allowing trusted software to run. By default, it allows apps from the Mac App Store and apps from identified developers who have obtained an Apple Developer ID and have their apps notarized.

Since Scrippi is currently signed with a self-signed certificate and not notarized, macOS cannot verify the app and may prevent it from opening normally.

### How to Open Scrippi
To open Scrippi, follow these steps:

1. **Locate Scrippi.app**: Find Scrippi in your Applications folder or wherever you placed it.
2. **Open Anyway**: 
   - Right-click (or Ctrl-click) on Scrippi.app.
   - Select "Open" from the context menu.
   - A dialog will appear warning you about the app being from an unidentified developer. Click "Open" in this dialog to proceed.

By performing these steps, you are telling Gatekeeper that you trust Scrippi and wish to open it. This step needs to be done only once; afterwards, you can open Scrippi as usual.

## Terminal Preference Feature
One of Scrippi's key features is the ability to choose your preferred terminal application for executing scripts. Whether you're comfortable with the standard macOS Terminal or prefer the advanced features of iTerm, Scrippi allows you to select your preferred option in the settings. This flexibility ensures that the app seamlessly integrates into your existing workflow.

### Setting Your Preferred Terminal
In Scrippi's settings, you can select either the default macOS Terminal or iTerm as your preferred terminal application. This choice determines which terminal Scrippi will use to execute your scripts and commands.(Coming more soon)

<p align="center">
  <img src="https://raw.githubusercontent.com/dhanishgajjar/terminal-icons/master/png/sublime.png" alt="Mac Terminal icon" width="128" height="128">
  <img src="https://cl.ly/1Q2M0r2C1h0b/icon_128x128@2x.png" alt="Iterm2 icon" width="128" height="128">
</p>



## Security Warning Message
When using Scrippi to execute scripts, you may encounter the following security warning message:

> Warning
> OK to run "/private/var/folders/z8/ktIn2sws2gx19y2z|9wg76r00000gn/T/run_command.sh"?

This message is a standard security precaution in macOS. If you trust the source of the script, you can suppress this warning by adjusting your system's security preferences or by granting necessary permissions to Scrippi.


## Efficiency in Everyday Tasks
Regular tasks, such as starting Docker containers in a specific work folder, can become tedious. Scrippi streamlines these routines, allowing users to execute commands directly from the menu bar. This feature is particularly beneficial for developers and IT professionals who frequently interact with command-line tools and scripts.

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
        {
            "title": "Multiple Scripts",
            "scripts": [
                "echo 'This is the first script'",
                "echo 'This is the second script'",
                "echo 'This is the Third script'"
            ]
        },
        // Additional commands or separators as needed
    ]
}
```

## Scrippi in Action
Take a look at how Scrippi integrates seamlessly into your macOS menu bar:
<p align="left">
  <img width="358" height="310" alt="Screenshot 2023-12-29 at 01 22 05" src="https://github.com/igormomc/Scrippi/assets/60653284/832d8877-1b7a-4bb0-a0e7-d688ce21c2db">
  <img width="325" height="310" alt="Screenshot 2024-02-06 at 10 21 44" src="https://github.com/igormomc/Scrippi/assets/60653284/58ff6a29-24b0-4ad5-ac72-dd598688443b">
</p>



## Important Notice for Developers Using Xcode
If you find that not all Swift files are loading correctly into Xcode, please follow these steps to ensure they are properly added to your project:
- Right-click on the group or folder within your Xcode project where you want to add the missing files.
- Select "Add Files to [YourProjectName]".
- Navigate to the location of the missing files in the file dialog, select them, and click "Add".
This is a common issue where files located in the project folder are not automatically recognized by Xcode and must be manually added to the project.


