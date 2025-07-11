// swift-tools-version:5.7
//
//  Package.swift
//

import PackageDescription

let package = Package(
    name: "AnimatedField",
    platforms: [
        .iOS(.v16),
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
        .package(url: "https://github.com/DoubleNodeOpen/swift-mask-textfield.git", from: "1.1.2"),
        .package(url: "https://github.com/DoubleNode/DNSCore.git", from: "1.11.10"),
    ],
    targets: [
         .target(
             name: "AnimatedField",
             dependencies: [
                "DNSCore",
                .product(name: "SwiftMaskTextfield", package: "swift-mask-textfield")
             ],
             resources: [.process("Resources/AnimatedField.xib")]
         )
     ]
)
