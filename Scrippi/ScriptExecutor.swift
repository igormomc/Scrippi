//
//  ScriptExecutor.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Cocoa

class ScriptExecutor {
    func executeScript(command: String) {
        let scriptContent = "#!/bin/zsh\n\(command)\nexec $SHELL -l"
        let tempDirectory = NSTemporaryDirectory()
        let scriptPath = "\(tempDirectory)/run_command.sh"
        
        do {
            try scriptContent.write(toFile: scriptPath, atomically: true, encoding: .utf8)
            let fileURL = URL(fileURLWithPath: scriptPath)
            try FileManager.default.setAttributes([.posixPermissions: 0o755], ofItemAtPath: scriptPath)
            
            // Retrieve the saved terminal type from UserDefaults
            let defaults = UserDefaults.standard
            let selectedTerminalType = defaults.string(forKey: "terminalType") ?? "Terminal"
            
            // Determine the bundle identifier of the terminal application
            let terminalBundleIdentifier: String
            switch selectedTerminalType {
            case "Terminal":
                terminalBundleIdentifier = "com.apple.Terminal"
            case "iTerm2":
                terminalBundleIdentifier = "com.googlecode.iterm2"
            default:
                print("Unknown terminal type: \(selectedTerminalType)")
                return
            }
            
            if let terminalURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: terminalBundleIdentifier) {
                let configuration = NSWorkspace.OpenConfiguration()
                NSWorkspace.shared.open([fileURL], withApplicationAt: terminalURL, configuration: configuration, completionHandler: nil)
            }
        } catch {
            print("Error executing script: \(error)")
        }
    }
}
