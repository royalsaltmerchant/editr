//
//  editrApp.swift
//  editr
//
//  Created by Julian ranieri on 6/21/23.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct editrapp: App {
    @State private var lines: [String] = Array(repeating: "", count: 1)

    var body: some Scene {
        WindowGroup {
            ContentView(lines: $lines)
                .onAppear {
//                    openFileFromCommandLine()
                }
        }
        .commands {
            CommandGroup(after: .newItem) {
//                Button("Open...", action: openFile)
            }
        }
    }
    
//    private func openFileFromCommandLine() {
//        let arguments = CommandLine.arguments
//
//        if arguments.count > 1 {
//            let filePath = arguments[1]
//            do {
//                let fileContents = try String(contentsOfFile: filePath)
//                text = fileContents
//            } catch {
//                print("Error opening file: \(error)")
//            }
//        }
//    }

//    private func openFile() {
//        let openPanel = NSOpenPanel()
//        openPanel.allowedContentTypes = [UTType.text]
//        openPanel.allowsMultipleSelection = false
//        openPanel.canChooseDirectories = false
//
//        openPanel.begin { response in
//            if response == .OK, let fileURL = openPanel.urls.first {
//                do {
//                    let text = try String(contentsOf: fileURL, encoding: .utf8)
//                    self.text = text
//                } catch {
//                    print("Error opening file: \(error)")
//                }
//            }
//        }
//    }
}
