// swift-tools-version:5.6
import PackageDescription
let package = Package(
    name: "WebMIDIKeyboard",
    platforms: [.macOS(.v11), .iOS(.v13)],
    products: [
        .executable(name: "WebMIDIKeyboard", targets: ["WebMIDIKeyboard"])
    ],
    dependencies: [
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.0"),
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.15.0"),
    ],
    targets: [
        .executableTarget(
            name: "WebMIDIKeyboard",
            dependencies: [
                .product(name: "TokamakShim", package: "Tokamak"),
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
                .product(name: "JavaScriptEventLoop", package: "JavaScriptKit"),
            ]
        )
    ]
)
