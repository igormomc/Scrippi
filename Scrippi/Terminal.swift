//
//  TerminalEnum.swift
//  Scrippi
//
//  Created by Jonas Silva on 11/01/2024.
//

import Foundation

struct TerminalType {
  let Name: String
  let BundleIdentifier: String
}

let SupportedTerminals = [
  TerminalType(Name: "Terminal", BundleIdentifier: "com.apple.Terminal"),
  TerminalType(Name: "iTerm", BundleIdentifier: "com.googlecode.iterm2"),
]

func getUserDefaultTerminal() -> TerminalType {
    let defaults = UserDefaults.standard
    print("Saved terminalType: \(defaults.string(forKey: "terminalType") ?? "None")")
    let selectedTerminalType = defaults.string(forKey: "terminalType") ?? TerminalChoice.terminal.rawValue

    if let terminal = SupportedTerminals.first(where: { $0.Name == selectedTerminalType }) {
        return terminal
    } else {
        return getDefaultTerminal()
    }
}


func getIndexFromTerminalType(terminalType: TerminalType) -> Int {
  for (index, terminal) in SupportedTerminals.enumerated() {
    if terminal.Name == terminalType.Name {
      return index
    }
  }
  return 0
}

func getTerminalLabels() -> [String] {
  var labels: [String] = []
  for terminal in SupportedTerminals {
    labels.append(terminal.Name)
  }
  return labels
}

func getDefaultTerminal() -> TerminalType {
  return SupportedTerminals[0]
}
