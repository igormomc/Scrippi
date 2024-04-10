//
//  SettingsViewController.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 10/04/2024.
//

import Cocoa
import SwiftUI

class SettingsViewController: NSWindowController {
    convenience init() {
        let contentView = SettingView() // Assuming SettingView() is your SwiftUI view
        let hostingController = NSHostingController(rootView: contentView)
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 480, height: 300)) // Customize size as needed
        self.init(window: window)
        window.title = "Settings"
        
        // Set the window level to make it float above most other windows
        window.level = .floating
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        
        // Bringing the window to the front every time it's shown
        NSApp.activate(ignoringOtherApps: true)
        self.window?.makeKeyAndOrderFront(sender)
    }
}
