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
                } else if let title = item["title"] as? String {
                    let menuItem = NSMenuItem(title: title, action: #selector(menuItemAction(_:)), keyEquivalent: "")
                    menuItem.target = self
                    
                    if let script = item["script"] as? String {
                        menuItem.representedObject = [script] 
                    }
                    else if let scripts = item["scripts"] as? [String] {
                        menuItem.representedObject = scripts
                    }
                    
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
        
        let settingsMenuItem2 = NSMenuItem(title: "Settings", action: #selector(openSettingsWindow2), keyEquivalent: "")
        settingsMenuItem2.target = self
        menu.addItem(settingsMenuItem2)
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }

    func loadMenuItemsFromJson() -> [[String: Any]]? {
        guard let url = editableJsonURL else {
            print("Editable JSON file URL is not set.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let menuItems = jsonObject["menu"] as? [[String: Any]] {
                return menuItems
            } else {
                print("Failed to interpret JSON. Check the 'menu' key and its structure.")
                return nil
            }
        } catch {
            print("Failed to load or parse the JSON file: \(error)")
            return nil
        }
    }

	
    @objc func refreshMenu() {
            constructMenu()
        }
    
    @objc func menuItemAction(_ sender: NSMenuItem) {
        if let script = sender.representedObject as? String {
            scriptExecutor.executeScript(commands: [script])
        } else if let scripts = sender.representedObject as? [String] {
            scriptExecutor.executeScript(commands: scripts)
        }
    }

    
    @objc func editJsonFile() {
        guard let url = editableJsonURL else {
                    print("Editable JSON file URL is not set.")
                    return
        }
        let textEditBundleIdentifier = "com.apple.TextEdit"
        if let textEditURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: textEditBundleIdentifier) {
            let configuration = NSWorkspace.OpenConfiguration()
            
            NSWorkspace.shared.open([url], withApplicationAt: textEditURL, configuration: configuration) { (app, error) in
                if let error = error {
                    print("Failed to open the JSON file with TextEdit: \(error.localizedDescription)")
                }
            }
        } else {
            print("Failed to find TextEdit application URL.")
        }
    }

    var settingsViewController: SettingsViewController?

    @objc func openSettingsWindow2() {
        if settingsViewController == nil {
            settingsViewController = SettingsViewController()
        }
        
        settingsViewController?.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true) 
    }

    
    @objc func openGithubURL() {
            if let url = URL(string: "https://github.com/igormomc/Scrippi") {
                NSWorkspace.shared.open(url)
            }
        }
}
