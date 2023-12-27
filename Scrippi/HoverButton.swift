//
//  HoverButton.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 27/12/2023.
//
import Cocoa

class HoverButton: NSButton {
    private var trackingArea: NSTrackingArea?
    private let hoverEffectView = NSVisualEffectView()

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        self.bezelStyle = .regularSquare
        self.isBordered = false
        //set text color
        self.contentTintColor = NSColor.white
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        self.layer?.cornerRadius = 4
        self.font = NSFont.systemFont(ofSize: 12)
        self.alignment = .left
        self.imagePosition = .noImage
        
  
        hoverEffectView.frame = self.bounds
        hoverEffectView.autoresizingMask = [.width, .height]
        hoverEffectView.blendingMode = .withinWindow
        hoverEffectView.isHidden = true
        self.addSubview(hoverEffectView, positioned: .below, relativeTo: nil)
    }

    override func resetCursorRects() {
        addCursorRect(self.bounds, cursor: .pointingHand)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        hoverEffectView.isHidden = false
        hoverEffectView.material = .selection
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        hoverEffectView.isHidden = true
    }
    override var frame: NSRect {
            didSet {
                updateHoverTrackingArea()
            }
        }

        private func updateHoverTrackingArea() {
            if let trackingArea = trackingArea {
                removeTrackingArea(trackingArea)
            }
            trackingArea = NSTrackingArea(rect: self.bounds, options: [.activeInActiveApp, .mouseEnteredAndExited, .inVisibleRect], owner: self, userInfo: nil)
            addTrackingArea(trackingArea!)
        }

        override func updateTrackingAreas() {
            super.updateTrackingAreas()
            updateHoverTrackingArea()
        }
}
