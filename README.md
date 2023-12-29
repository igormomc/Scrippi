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
- **Terminal Preference**: Choose between using the standard macOS Terminal or iTerm for command execution in the settings.
- **JSON Configuration**: Easily configure menu items through a JSON file for rapid updates and customization.
- **Dark Mode Compatibility**: Icons adapt to both light and dark modes of macOS.

## Download
You can download the latest version of Scrippi here: [Download Scrippi](https://github.com/igormomc/Scrippi/releases/download/v1.0.0/Scrippi.zip)


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
        // Additional commands or separators as needed
    ]
}
```

## Scrippi in Action
Take a look at how Scrippi integrates seamlessly into your macOS menu bar:
<p align="left">
  <img width="358" alt="Screenshot 2023-12-29 at 01 22 05" src="https://github.com/igormomc/Scrippi/assets/60653284/832d8877-1b7a-4bb0-a0e7-d688ce21c2db">
</p>


