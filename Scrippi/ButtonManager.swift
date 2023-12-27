//
//  ButtonManager.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//
import Cocoa

class ButtonManager {
    var scriptExecutor = ScriptExecutor()
    var buttonScriptMap = [HoverButton: String]()

    func createUIElementsFromJson() -> [NSView] {
        var uiElements = [NSView]()

        // Create 'Open JSON' button
        let openJsonButton = HoverButton(frame: .zero)
        openJsonButton.title = "Open JSON"
        openJsonButton.target = self
        openJsonButton.action = #selector(openJsonFile)
        uiElements.append(openJsonButton)

        // Load other buttons and separators from JSON
        guard let menuItems = JSONManager().loadJson() else { return uiElements }
        
        for item in menuItems {
            if let type = item["type"] as? String, type == "separator" {
                let separator = NSBox(frame: NSRect(x: 0, y: 0, width: 180, height: 1))
                separator.boxType = .separator
                uiElements.append(separator)
            } else if let title = item["title"] as? String, let script = item["script"] as? String {
                let button = HoverButton(frame: .zero)
                button.title = title
                button.target = self
                button.action = #selector(buttonAction(_:))
                uiElements.append(button)
                buttonScriptMap[button] = script
            }
        }
        return uiElements
    }
    @objc func openJsonFile() {
            guard let url = Bundle.main.url(forResource: "MenuItems", withExtension: "json") else {
                print("Failed to find the MenuItems.json file.")
                return
            }
            NSWorkspace.shared.open(url)
        }

    @objc func buttonAction(_ sender: HoverButton) {
        if let script = buttonScriptMap[sender] {
            scriptExecutor.executeScript(command: script)
        }
    }
}
