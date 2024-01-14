//
//  FileManager.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Cocoa

class AppFileManager {
    var editableJsonURL: URL?
    
    init(editableJsonURL: URL?) {
        self.editableJsonURL = editableJsonURL
    }
    func prepareEditableJsonFile() {
        let appDirectoryURL = getAppDirectoryURL()
        editableJsonURL = appDirectoryURL.appendingPathComponent("MenuItems.json")
        
        if !FileManager.default.fileExists(atPath: editableJsonURL!.path) {
            if let bundleJsonURL = Bundle.main.url(forResource: "MenuItems", withExtension: "json") {
                do {
                    try FileManager.default.createDirectory(at: appDirectoryURL, withIntermediateDirectories: true, attributes: nil)
                    try FileManager.default.copyItem(at: bundleJsonURL, to: editableJsonURL!)
                } catch {
                    print("Error copying JSON file: \(error)")
                }
            }
        }
    }
    
    @objc func editJsonFile() {
        if let url = editableJsonURL {
            NSWorkspace.shared.open(url)
        } else {
            print("Editable JSON file URL is not set.")
        }
    }
}
