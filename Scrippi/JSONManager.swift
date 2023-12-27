//
//  JSONManager.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//

import Foundation

class JSONManager {
    func loadJson() -> [[String: Any]]? {
        guard let url = Bundle.main.url(forResource: "MenuItems", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data, options: []),
              let dictionary = json as? [String: Any],
              let menuItems = dictionary["menu"] as? [[String: Any]] else {
            return nil
        }
        return menuItems
    }
}
