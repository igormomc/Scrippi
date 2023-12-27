//
//  AppDelegate.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 26/12/2023.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var scriptExecutor = ScriptExecutor()
    var editableJsonURL: URL?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("Logo"))
            button.image?.isTemplate = true // Makes it compatible with dark mode
            button.action = #selector(showMenu(_:))
            button.target = self
        }
        prepareEditableJsonFile()
        constructMenu()
    }
    @objc func showMenu(_ sender: Any?) {
            constructMenu()
            statusItem.button?.performClick(nil) 
        }

    private func prepareEditableJsonFile() {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDirectoryURL = appSupportURL.appendingPathComponent("YourAppName")
        editableJsonURL = appDirectoryURL.appendingPathComponent("MenuItems.json")

        if !fileManager.fileExists(atPath: editableJsonURL!.path) {
            if let bundleJsonURL = Bundle.main.url(forResource: "MenuItems", withExtension: "json") {
                do {
                    try fileManager.createDirectory(at: appDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                    try fileManager.copyItem(at: bundleJsonURL, to: editableJsonURL!)
                } catch {
                    print("Error copying JSON file: \(error)")
                }
            }
        }
    }

    private func constructMenu() {
        let menu = NSMenu()

        // Load and add menu items from JSON
        if let menuItems = loadMenuItemsFromJson() {
            for item in menuItems {
                if let type = item["type"] as? String, type == "separator" {
                    menu.addItem(NSMenuItem.separator())
                } else if let title = item["title"] as? String, let script = item["script"] as? String {
                    let menuItem = NSMenuItem(title: title, action: #selector(menuItemAction(_:)), keyEquivalent: "")
                    menuItem.representedObject = script
                    menu.addItem(menuItem)
                }
            }
        }

        // Add 'Refresh Menu' menu item
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Refresh Menu", action: #selector(refreshMenu), keyEquivalent: "")

        // Add 'Edit JSON' menu item
        menu.addItem(withTitle: "Edit JSON", action: #selector(editJsonFile), keyEquivalent: "")

        statusItem.menu = menu
    }

    @objc func refreshMenu() {
        constructMenu()
    }

    @objc private func editJsonFile() {
        if let url = editableJsonURL {
            NSWorkspace.shared.open(url)
        } else {
            print("Editable JSON file URL is not set.")
        }
    }

    @objc func menuItemAction(_ sender: NSMenuItem) {
        if let script = sender.representedObject as? String {
            scriptExecutor.executeScript(command: script)
        }
    }

    private func loadMenuItemsFromJson() -> [[String: Any]]? {
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

    @objc func quitApp() {
        NSApp.terminate(self)
    }
}
