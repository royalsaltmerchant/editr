//
//  ContentView.swift
//  editr
//
//  Created by Julian ranieri on 6/21/23.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @Binding var text: String

    var body: some View {
        ScrollView([.vertical, .horizontal], showsIndicators: true) {
            HStack(spacing: 0) {
                lineNumberView()
                TextView(text: $text)
            }
            .background(Color(hue: 0.6, saturation: 0.5, brightness: 0.12))
            .frame(minWidth: NSScreen.main?.visibleFrame.width, minHeight: NSScreen.main?.visibleFrame.height)
        }
        
    }
    
    struct TextView: NSViewRepresentable {
        @Binding var text: String
        
        func makeCoordinator() -> Coordinator {
            Coordinator(text: $text)
        }
        
        func makeNSView(context: Context) -> NSTextView {
            let textView = NSTextView()
            textView.isEditable = true
            textView.isSelectable = true
            textView.backgroundColor = NSColor(hue: 0.6, saturation: 0.5, brightness: 0.12, alpha: 1.0)
            textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
            textView.string = text
            textView.textColor = NSColor(hue: 0, saturation: 0, brightness: 0.7, alpha: 1.0) // Set the text color
            textView.insertionPointColor = NSColor(hue: 0, saturation: 0, brightness: 0.7, alpha: 1.0) // Set the caret color
            
            // Enable horizontal text overflow
            let textContainer = textView.textContainer
            textContainer?.widthTracksTextView = false
            textContainer?.containerSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
            
            
            textView.delegate = context.coordinator
            return textView
        }
        
        func updateNSView(_ nsView: NSTextView, context: Context) {
            if nsView.string != text {
                nsView.string = text
            }
        }
        
        class Coordinator: NSObject, NSTextViewDelegate {
            @Binding var text: String
            
            init(text: Binding<String>) {
                _text = text
            }
            
            func textDidChange(_ notification: Notification) {
                if let textView = notification.object as? NSTextView {
                    text = textView.string
                }
            }
        }
    }


    private func lineNumberView() -> some View {
        VStack(spacing: 0) {

            Text("1")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .frame(width: 50, alignment: .trailing)
                .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.4))
            ForEach(Array(text.enumerated()), id: \.offset) { index, character in
                if character.isNewline {
                    let lineNumber = lineOrder(for: index)
                    let lineNumberText = Text(verbatim: "\(lineNumber)")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(width: 50, alignment: .trailing)
                        .foregroundColor(Color(hue: 0, saturation: 0, brightness: 0.4))
                    lineNumberText.fixedSize() // Ensure the text does not expand to fit content
                }
            }

            Spacer(minLength: 0)
        }
        .frame(alignment: .trailing)
        .background(Color(hue: 0.6, saturation: 0.5, brightness: 0.1))
    }

    private func lineOrder(for index: Int) -> Int {
        let lineBreakCount = text.prefix(index + 1).filter({ $0.isNewline }).count
        return lineBreakCount + 1
    }
}
