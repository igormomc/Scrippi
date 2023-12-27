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
    var popover = NSPopover()
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.title = "Igor's App"
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = YourViewController()
        popover.behavior = .transient
        let mainWindow = NSWindow( /* your window initialization code */ )
            mainWindow.level = NSWindow.Level.statusBar
            mainWindow.hasShadow = true

    }

    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let button = statusItem.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
}
