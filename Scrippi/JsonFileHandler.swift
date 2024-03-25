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
}
