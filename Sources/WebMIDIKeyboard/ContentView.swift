import TokamakDOM
import Foundation

struct ContentView: View {
    
    @StateObject var webMIDI = WebMIDI()
    
    var body: some View {
        VStack(spacing: 20) {
            if webMIDI.isSupported {
                HStack {
                    Text("\(webMIDI.outputs.count) MIDI Output(s)")
                    Button("Update") {
                        webMIDI.requestMIDIAccess()
                    }
                }
            } else {
                Text("Web MIDI API is not supported...")
            }
            
            KeyboardView() { note, press in
                print(note, press)
                webMIDI.sendMIDIMessage(note: note, on: press)
            }
            
            Link("> GitHub", destination: URL(string: "https://github.com/bricklife/SwiftWasm-WebMIDIKeyboard")!)
                .font(Font.footnote)
        }
        .padding(40)
        .onAppear {
            webMIDI.requestMIDIAccess()
        }
    }
}
