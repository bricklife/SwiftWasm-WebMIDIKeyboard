import TokamakDOM
import JavaScriptKit
import JavaScriptEventLoop

class WebMIDI: ObservableObject {
    
    let isSupported = !JSObject.global.navigator.requestMIDIAccess.isUndefined
    
    @Published var outputs: [JSValue] = []
    
    init() {
        JavaScriptEventLoop.installGlobalExecutor()
    }
    
    func requestMIDIAccess() {
        guard isSupported else { return }
        
        Task {
            do {
                let promise = JSObject.global.navigator.requestMIDIAccess()
                guard let midiAccess = try await JSPromise(from: promise)?.value else { return }
                
                outputs.removeAll()
                _ = midiAccess.outputs.forEach(JSClosure { value in
                    let id = value[1]
                    let output = value[0]
                    let name = output.name.string ?? "Unknown"
                    print(id, name)
                    self.outputs.append(output)
                    return .undefined
                })
            } catch {
                print("Error!!!", error)
            }
        }
    }
    
    func sendMIDIMessage(note: UInt8, on: Bool) {
        guard isSupported else { return }
        
        let message: [UInt8] = [on ? 0x90 : 0x80, note, 100]
        for output in outputs {
            _ = output.send(message)
        }
    }
}
