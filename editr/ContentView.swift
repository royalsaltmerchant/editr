//
//  ContentView.swift
//  editr
//
//  Created by Julian ranieri on 6/21/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var lines: [String]

    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack(alignment: .trailing) {
                    ForEach(0..<lines.count, id: \.self) { i in
                        Text("\(i+1)")
                            .font(.system(.body, design: .monospaced))
                            .frame(width: 30, alignment: .trailing) // fixed width
                            .padding(.leading)
                            .foregroundColor(.white)
                    }
                }
                TextView(text: $lines)
            }
        }
        .background(Color.black)
    }
}

struct TextView: NSViewRepresentable {
    @Binding var text: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()
        textView.backgroundColor = NSColor.black
        textView.textColor = NSColor.white
        textView.font = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        let selectedRanges = nsView.selectedRanges
        nsView.string = text.joined(separator: "\n")
        nsView.selectedRanges = selectedRanges
    }
    
    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: TextView

        init(_ parent: TextView) {
            self.parent = parent
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string.components(separatedBy: "\n")
        }
    }
}




