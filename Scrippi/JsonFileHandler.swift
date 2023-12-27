//
//  JsonFileHandler.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Cocoa

class JsonFileHandler {
    var editableJsonURL: URL?

    init() {
        prepareEditableJsonFile()
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

    @objc func editJsonFile() {
        if let url = editableJsonURL {
            NSWorkspace.shared.open(url)
        } else {
            print("Editable JSON file URL is not set.")
        }
    }
}
