//
//  ContentView.swift
//  editr
//
//  Created by Julian ranieri on 6/21/23.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @Binding var lines: [String]

    var body: some View {
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
                .background(Color.black)
        }
        .background(Color.black)
    }
}

struct TextView: NSViewRepresentable {
    @Binding var text: [String]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        let textView = NSTextView()
        
        textView.backgroundColor = NSColor.black
        textView.textColor = NSColor.white
        textView.font = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        textView.delegate = context.coordinator
        textView.isHorizontallyResizable = true
        textView.isVerticallyResizable = true
        textView.autoresizingMask = [.width, .height]
        textView.textContainer?.containerSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = false
        
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = true
        scrollView.autohidesScrollers = false
        scrollView.documentView = textView

        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        let selectedRanges = textView.selectedRanges
        textView.string = text.joined(separator: "\n")
        textView.selectedRanges = selectedRanges
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





