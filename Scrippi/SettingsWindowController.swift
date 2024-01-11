//
//  SettingsWindowController.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 28/12/2023.
//


import Cocoa

class SettingsWindowController: NSWindowController, NSWindowDelegate {
    
    let terminalTypeButton = NSPopUpButton()

    convenience init() {
        self.init(window: NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                                          styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
                                          backing: .buffered,
                                          defer: false))
        window?.center()
        window?.setFrameAutosaveName("Settings Window")
        window?.isReleasedWhenClosed = false
        window?.delegate = self

        // Create a navigation bar
        let navBar = NSView()
        navBar.wantsLayer = true
        navBar.translatesAutoresizingMaskIntoConstraints = false
        window?.contentView?.addSubview(navBar)

        let tabView = NSTabView()
        tabView.translatesAutoresizingMaskIntoConstraints = false
        window?.contentView?.addSubview(tabView)
        
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "terminalType") == nil {
            defaults.set(getDefaultTerminal().Name, forKey: "terminalType")
        }

        let sections = ["General", "Appearance", "Notifications", "Accounts", "Advanced"]
        
        for section in sections {
            let tabViewItem = NSTabViewItem(identifier: nil)
            tabViewItem.label = section

            let tabContent = NSView()
            tabContent.translatesAutoresizingMaskIntoConstraints = false
            tabViewItem.view = tabContent
            tabView.addTabViewItem(tabViewItem)

            if section == "General" {
                let titleLabel = NSTextField(labelWithString: "General")
                titleLabel.font = NSFont.systemFont(ofSize: 24)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                tabContent.addSubview(titleLabel)

                let terminalToggle = NSSegmentedControl(labels: getTerminalLabels(), trackingMode: .selectOne, target: self, action: #selector(terminalToggleChanged))
                terminalToggle.translatesAutoresizingMaskIntoConstraints = false
                tabContent.addSubview(terminalToggle)

                // Retrieve the saved terminal type from UserDefaults
                let selectedTerminal = getUserDefaultTerminal()
                let selectedSegmentIndex = getIndexFromTerminalType(terminalType: selectedTerminal)
                terminalToggle.setSelected(true, forSegment: selectedSegmentIndex)
                
                let saveButton = NSButton(title: "Save", target: self, action: #selector(saveSettings))
                                saveButton.translatesAutoresizingMaskIntoConstraints = false
                                tabContent.addSubview(saveButton)

                NSLayoutConstraint.activate([
                    titleLabel.centerXAnchor.constraint(equalTo: tabContent.centerXAnchor),
                    titleLabel.topAnchor.constraint(equalTo: tabContent.topAnchor, constant: 20),
                    terminalToggle.leadingAnchor.constraint(equalTo: tabContent.leadingAnchor, constant: 20),
                    terminalToggle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                    saveButton.topAnchor.constraint(equalTo: terminalToggle.bottomAnchor, constant: 20),
                    saveButton.leadingAnchor.constraint(equalTo: tabContent.leadingAnchor, constant: 20)
                                   
                ])
            } else {
                let comingSoonLabel = NSTextField(labelWithString: "Coming Soon")
                comingSoonLabel.font = NSFont.systemFont(ofSize: 24)
                comingSoonLabel.translatesAutoresizingMaskIntoConstraints = false
                comingSoonLabel.alignment = .center
                tabContent.addSubview(comingSoonLabel)

                NSLayoutConstraint.activate([
                    comingSoonLabel.centerXAnchor.constraint(equalTo: tabContent.centerXAnchor),
                    comingSoonLabel.centerYAnchor.constraint(equalTo: tabContent.centerYAnchor),
                    comingSoonLabel.leadingAnchor.constraint(equalTo: tabContent.leadingAnchor),
                    comingSoonLabel.trailingAnchor.constraint(equalTo: tabContent.trailingAnchor)
                ])
            }
        }

        // Add constraints for navigation bar and tabView
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: window!.contentView!.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: window!.contentView!.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: window!.contentView!.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 44), // Standard height for a navigation bar
            tabView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tabView.bottomAnchor.constraint(equalTo: window!.contentView!.bottomAnchor),
            tabView.leadingAnchor.constraint(equalTo: window!.contentView!.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: window!.contentView!.trailingAnchor)
        ])
    }

    @objc func terminalToggleChanged(sender: NSSegmentedControl) {
        print("Terminal type changed to")
    }
    
    @objc func saveSettings() {
           // Retrieve the segmented control and save its state
           if let tabView = window?.contentView?.subviews.compactMap({ $0 as? NSTabView }).first,
              let generalTab = tabView.tabViewItems.first(where: { $0.label == "General" }),
              let terminalToggle = generalTab.view?.subviews.compactMap({ $0 as? NSSegmentedControl }).first {
               
               let selectedTerminalType = terminalToggle.selectedSegment == 0 ? "Terminal" : "iTerm2"
               UserDefaults.standard.set(selectedTerminalType, forKey: "terminalType")
               UserDefaults.standard.synchronize() // Save changes immediately
           }
           // Optionally, close the settings window after saving
           window?.close()
       }

   }

