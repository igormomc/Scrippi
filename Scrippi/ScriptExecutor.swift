//
//  ScriptExecutor.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Cocoa

class ScriptExecutor {
    
    func executeScript(commands: [String]) {
        for command in commands {
            let scriptContent = "#!/bin/zsh\n\(command)\nexec $SHELL -l"
            
            let tempDirectory = NSTemporaryDirectory()
            let uniqueID = UUID().uuidString
            let scriptPath = "\(tempDirectory)/run_command_\(uniqueID).sh"
            
            do {
                try scriptContent.write(toFile: scriptPath, atomically: true, encoding: .utf8)
                let fileURL = URL(fileURLWithPath: scriptPath)
                try FileManager.default.setAttributes([.posixPermissions: 0o755], ofItemAtPath: scriptPath)
                
                // Get terminal selected by the user
                let terminal = getUserDefaultTerminal()
                
                if let terminalURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: terminal.BundleIdentifier) {
                    let configuration = NSWorkspace.OpenConfiguration()
                    NSWorkspace.shared.open([fileURL], withApplicationAt: terminalURL, configuration: configuration, completionHandler: nil)
                }
            } catch {
                print("Error executing script: \(error)")
            }
        }
    }

}
