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
         .target(
             name: "AnimatedField",
             dependencies: [],
             resources: [
                 .copy("Classes/AnimatedField.xib")
             ]
         )
     ]
)
