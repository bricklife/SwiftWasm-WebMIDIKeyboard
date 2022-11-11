import TokamakDOM

struct KeyboardView: View {
    
    let onPress: (UInt8, Bool) -> Void
    
    private let whiteKeyNotes: [UInt8] = [60, 62, 64, 65, 67, 69, 71, 72]
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 1) {
                ForEach(whiteKeyNotes, id: \.self) { note in
                    WhiteKeyView()
                        .onPress { press in
                            onPress(note, press)
                        }
                }
            }
            .background(.black)
            .border(.black, width: 1)
            
            BlackKeyView()
                .onPress { press in
                    onPress(61, press)
                }
                .offset(x: -33 * 3)
            
            BlackKeyView()
                .onPress { press in
                    onPress(63, press)
                }
                .offset(x: -33 * 2)
            
            BlackKeyView()
                .onPress { press in
                    onPress(66, press)
                }
                .offset(x: 0)
            
            BlackKeyView()
                .onPress { press in
                    onPress(68, press)
                }
                .offset(x: 33 * 1)
            
            BlackKeyView()
                .onPress { press in
                    onPress(70, press)
                }
                .offset(x: 33 * 2)
        }
    }
}

struct WhiteKeyView: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 32, height: 96)
    }
}

struct BlackKeyView: View {
    var body: some View {
        Rectangle()
            .fill(Color.black)
            .frame(width: 16, height: 64)
    }
}
