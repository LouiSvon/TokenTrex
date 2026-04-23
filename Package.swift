// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TokenTrex",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "TokenTrex",
            path: "TokenTrex/Sources",
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-sectcreate",
                              "-Xlinker", "__TEXT",
                              "-Xlinker", "__info_plist",
                              "-Xlinker", "TokenTrex/Info.plist"])
            ]
        ),
    ]
)
