//
//  Common.swift
//  Scrippi
//
//  Created by Jonas Silva on 12/01/2024.
//

import Foundation

func getAppDirectoryURL() -> URL {
    let fileManager = FileManager.default
    let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    let appDirectoryURL = appSupportURL.appendingPathComponent("Scrippi")
    return appDirectoryURL
}
