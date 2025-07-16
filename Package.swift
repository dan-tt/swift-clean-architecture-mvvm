// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MySwiftUIApp",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "MySwiftUIApp",
            targets: ["MySwiftUIApp"]),
    ],
    dependencies: [
        // Add your dependencies here
        // Example: .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0")
    ],
    targets: [
        .executableTarget(
            name: "MySwiftUIApp",
            dependencies: [],
            path: "MySwiftUIApp",
            exclude: ["Assets.xcassets", "Preview Content", "Info.plist"]),
        .testTarget(
            name: "MySwiftUIAppTests",
            dependencies: ["MySwiftUIApp"],
            path: "MySwiftUIAppTests"),
    ]
)
