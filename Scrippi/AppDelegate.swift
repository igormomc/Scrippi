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
    var menuManager: MenuManager!
    var appFileManager: AppFileManager!
    var settingsWindowController: SettingsWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDirectoryURL = appSupportURL.appendingPathComponent("YourAppName")
        editableJsonURL = appDirectoryURL.appendingPathComponent("MenuItems.json")
       

        self.menuManager = MenuManager(statusItem: statusItem, scriptExecutor: scriptExecutor, editableJsonURL: editableJsonURL)
        self.appFileManager = AppFileManager(editableJsonURL: editableJsonURL)

        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("AppLogo"))
            button.image?.isTemplate = true
            button.action = #selector(showMenu(_:))
            button.target = self
        }
        appFileManager.prepareEditableJsonFile()
        menuManager.constructMenu()
    }

    @objc func showMenu(_ sender: Any?) {
        menuManager.constructMenu()
        statusItem.button?.performClick(nil)
    }

    @objc func quitApp() {
        NSApp.terminate(self)
    }
    
    @objc func showSettings() {
           settingsWindowController = SettingsWindowController()
           settingsWindowController?.showWindow(nil)
       }
}
