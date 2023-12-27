//
//  YourViewController.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 26/12/2023.
//
import Cocoa

class YourViewController: NSViewController {
    let buttonManager = ButtonManager()
    var eventMonitor: Any?

    override func loadView() {
        self.view = NSView()
        setupUIElements()
    }
    private func setupUIElements() {
            let uiElements = buttonManager.createUIElementsFromJson()
            layoutUIElements(uiElements: uiElements)
        }
    
    
    private func closeMenu() {
        self.view.window?.close() // Or any other action to hide/close the menu        
    }
    
    private func setupEventMonitoring() {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown], handler: { [weak self] event in
            self?.closeMenu()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEventMonitoring()
    }

    
    private func layoutUIElements(uiElements: [NSView]) {
        var currentYPosition: CGFloat = 10  // Starting Y position with padding

        for element in uiElements.reversed() {
            if let button = element as? HoverButton {
                button.frame = NSMakeRect(10, currentYPosition, 180, 30)
                styleButton(button)
                currentYPosition += 35  // Increment Y position for next element
                view.addSubview(button)
            } else if element is NSBox {  // Separator
                element.frame = NSMakeRect(10, currentYPosition, 180, 1)
                currentYPosition += 6  // Increment Y position for next element
                view.addSubview(element)
            }
        }

        let totalHeight = currentYPosition + 10  // Total height with bottom padding
        self.view.frame = NSMakeRect(0, 0, 200, totalHeight)
    }

    
    private func styleButton(_ button: HoverButton) {
            // Apply styling consistent with the 'Open JSON' button
            button.bezelStyle = .regularSquare
            button.isBordered = false
            button.contentTintColor = NSColor.white
            button.wantsLayer = true
            button.layer?.backgroundColor = NSColor.clear.cgColor
            button.layer?.cornerRadius = 4
            button.font = NSFont.systemFont(ofSize: 12)
            button.alignment = .center
            button.imagePosition = .noImage
        }

    
    @objc func openJsonFile() {
           guard let url = Bundle.main.url(forResource: "MenuItems", withExtension: "json") else {
               print("Failed to find the MenuItems.json file.")
               return
           }
           NSWorkspace.shared.open(url)
       }
    
    deinit {
            if let eventMonitor = eventMonitor {
                NSEvent.removeMonitor(eventMonitor)
            }
        }
}
