// swift-tools-version:6.0
//
//  Package.swift
//

import PackageDescription

let package = Package(
    name: "AnimatedField",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .tvOS(.v16),
        .macCatalyst(.v16),
        .macOS(.v13),
        .watchOS(.v9),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AnimatedField",
            type: .static,
            targets: ["AnimatedField"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DoubleNodeOpen/swift-mask-textfield.git", from: "1.1.3"),
        .package(url: "https://github.com/DoubleNode/DNSCore.git", from: "1.12.0"),
//        .package(path: "../../DNSFramework/DNSCore"),
    ],
    targets: [
         .target(
             name: "AnimatedField",
             dependencies: [
                "DNSCore",
                .product(name: "SwiftMaskTextfield", package: "swift-mask-textfield")
             ],
             resources: [.process("Resources/AnimatedField.xib")],
         )
     ],
    swiftLanguageModes: [.v5]
)
