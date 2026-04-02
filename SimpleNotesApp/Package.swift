// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SimpleNotesApp",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    targets: [
        .executableTarget(
            name: "SimpleNotesApp",
            path: "."
        )
    ]
)
