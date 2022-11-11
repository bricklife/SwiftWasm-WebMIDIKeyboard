import TokamakDOM

// The original code:  https://github.com/fwcd/swift-music-web-playground/blob/main/Sources/MusicWebPlayground/View/Pressable.swift

/// A wrapper around another view that handles mouse press and drag events.
struct Pressable<Content>: View where Content: View {
    @ViewBuilder let content: () -> Content
    var onPressChanged: (Bool) -> Void = { _ in }

    var body: some View {
        DynamicHTML(
            "div",
            listeners: [
                "mousedown": { event in
                    onPressChanged(true)
                },
                "mouseup": { event in
                    onPressChanged(false)
                },
//                "mousemove": { event in
//                    if event.buttons == 1 {
//                        // Left mouse button dragged within this element
//                        onPressChanged(true)
//                    }
//                },
                "mouseenter": { event in
                    if event.buttons == 1 {
                        // Left mouse button dragged into this element
                        onPressChanged(true)
                    }
                },
                "mouseout": { event in
                    if event.buttons == 1 {
                        // Left mouse button dragged out of this element
                        onPressChanged(false)
                    }
                },
            ]
        ) {
            content()
        }
    }
}

extension View {
    func onPress(onPressChanged: @escaping (Bool) -> Void) -> Pressable<Self> {
        Pressable(content: { self }, onPressChanged: onPressChanged)
    }
}
