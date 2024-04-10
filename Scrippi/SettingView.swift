//
//  SettingView.swift
//  Scrippi
//
//  Created by Igor Momcilovic on 10/04/2024.
//
import SwiftUI
import ServiceManagement

enum TerminalChoice: String, CaseIterable, Identifiable {
    case terminal = "Terminal"
    case iTerm = "iTerm"
    //case warp = "Warp" //add poss for this later
    
    var id: String { self.rawValue }
}

enum SettingSection: String, CaseIterable, Identifiable {
    case general = "General"
    case comingSoon = "comingSoon"
    
    var id: Self { self }
    
    var symbolName: String {
        switch self {
            case .general: return "gear"
            case .comingSoon: return "person.crop.circle"
        }
    }
}

import SwiftUI

struct SettingView: View {
    @State private var selectedSection: SettingSection? = .general
    
    var body: some View {
        NavigationView {
            List(selection: $selectedSection) {
                NavigationLink(destination: DetailView(section: .general), tag: SettingSection.general, selection: $selectedSection) {
                    Label("General", systemImage: "gear")
                }
                
                NavigationLink(destination: DetailView(section: .comingSoon), tag: SettingSection.comingSoon, selection: $selectedSection) {
                    Label("Coming Soon", systemImage: "person.crop.circle")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Settings")
            
            DetailView(section: .general)
        }
    }
}

struct DetailView: View {
    let section: SettingSection
    @State private var isToggleOn: Bool = false
    
    // Automatically save and retrieve the user's terminal preference
    @AppStorage("terminalType") private var selectedTerminal: TerminalChoice = .terminal
    
    var body: some View {
        switch section {
        case .general:
            VStack(alignment: .leading, spacing: 20) {
                    Picker("Preferred Terminal:", selection: $selectedTerminal) {
                        ForEach(TerminalChoice.allCases) { choice in
                            Text(choice.rawValue).tag(choice)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing, .bottom])
                Divider()
                Toggle("Launch at startup (BETA)", isOn: $isToggleOn)
                    .padding([.top, .horizontal])
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .onChange(of: isToggleOn) { newValue in
                        setLaunchAtStartup(enabled: newValue)
                    }
                                
            }
            .padding()
            .navigationTitle("General Settings")
        
        case .comingSoon:
            Text("Coming soon...")
                .padding()
                .navigationTitle("Coming Soon")
        }
    }
}



func setLaunchAtStartup(enabled: Bool) {
    let helperBundleID = "com.example.ScrippiHelper" as CFString
    SMLoginItemSetEnabled(helperBundleID, enabled)
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
