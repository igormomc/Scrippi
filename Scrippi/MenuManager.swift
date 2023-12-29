//
//  MenuManager.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Cocoa

class MenuManager {
    var editableJsonURL: URL?
    var statusItem: NSStatusItem
    var scriptExecutor: ScriptExecutor

    init(statusItem: NSStatusItem, scriptExecutor: ScriptExecutor, editableJsonURL: URL?) {
        self.statusItem = statusItem
        self.scriptExecutor = scriptExecutor
        self.editableJsonURL = editableJsonURL
    }

    func constructMenu() {
        let menu = NSMenu()

        // Load and add menu items from JSON
        if let menuItems = loadMenuItemsFromJson() {
            for item in menuItems {
                if let type = item["type"] as? String, type == "separator" {
                    menu.addItem(NSMenuItem.separator())
                } else if let title = item["title"] as? String, let script = item["script"] as? String {
                    let menuItem = NSMenuItem(title: title, action: #selector(menuItemAction(_:)), keyEquivalent: "")
                    menuItem.representedObject = script
                    menuItem.target = self
                    menu.addItem(menuItem)
                }
            }
        }
        
        
        menu.addItem(NSMenuItem.separator())

        // 'Edit JSON' menu item
        if let jsonImage = NSImage(named: NSImage.Name("JsonLogo")) {
            jsonImage.isTemplate = true
            let jsonMenuItem = NSMenuItem(title: "Edit JSON", action: #selector(editJsonFile), keyEquivalent: "")
            jsonMenuItem.image = jsonImage
            jsonMenuItem.target = self
            menu.addItem(jsonMenuItem)
        }

        // 'Refresh Menu' menu item
        if let refreshImage = NSImage(named: NSImage.Name("RefreshLogo")) {
            refreshImage.isTemplate = true
            let refreshMenuItem = NSMenuItem(title: "Refresh Menu", action: #selector(refreshMenu), keyEquivalent: "")
            refreshMenuItem.image = refreshImage
            refreshMenuItem.target = self
            menu.addItem(refreshMenuItem)
        }

        // 'Github' menu item with image
        if let githubImage = NSImage(named: NSImage.Name("GithubLogo")) {
            githubImage.isTemplate = true
            let githubMenuItem = NSMenuItem(title: "Contribute", action: #selector(openGithubURL), keyEquivalent: "")
            githubMenuItem.image = githubImage
            githubMenuItem.target = self
            menu.addItem(githubMenuItem)
        }
        
        let settingsMenuItem = NSMenuItem(title: "Settings", action: #selector(openSettingsWindow), keyEquivalent: "")
        settingsMenuItem.target = self
        menu.addItem(settingsMenuItem)

        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }

    func loadMenuItemsFromJson() -> [[String: Any]]? {
        guard let url = editableJsonURL,
              let data = try? Data(contentsOf: url),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let jsonDict = jsonObject as? [String: Any],
              let menuItems = jsonDict["menu"] as? [[String: Any]] else {
            print("Failed to load or parse the editable MenuItems.json")
            return nil
        }
        return menuItems
    }

    @objc func refreshMenu() {
            constructMenu()
        }
    
    @objc func menuItemAction(_ sender: NSMenuItem) {
           if let script = sender.representedObject as? String {
               scriptExecutor.executeScript(command: script)
           }
       }
    
    @objc func editJsonFile() {
        if let url = editableJsonURL {
            NSWorkspace.shared.open(url)
        } else {
            print("Editable JSON file URL is not set.")
        }
    }
    
    @objc func openSettingsWindow() {
        let appDelegate = NSApplication.shared.delegate as? AppDelegate
        appDelegate?.settingsWindowController = SettingsWindowController()
        appDelegate?.settingsWindowController?.showWindow(nil)
    }

    
    @objc func openGithubURL() {
            if let url = URL(string: "https://github.com/igormomc/Scrippi") {
                NSWorkspace.shared.open(url)
            }
        }
}
