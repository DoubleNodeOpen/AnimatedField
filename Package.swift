// swift-tools-version:5.6
//
//  Package.swift
//

import PackageDescription

let package = Package(
    name: "AnimatedField",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AnimatedField",
            type: .static,
            targets: ["AnimatedField"]),
    ],
    dependencies: [],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AnimatedField",
            dependencies: [],
            path: "AnimatedField",
            resources: [
                .copy("AnimatedField.xib")
            ]
        ),
    ]
)
