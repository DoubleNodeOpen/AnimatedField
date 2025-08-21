import Foundation

extension Foundation.Bundle {
    static let module: Bundle = {
        let mainPath = Bundle.main.bundleURL.appendingPathComponent("AnimatedField_AnimatedField.bundle").path
        let buildPath = "/Users/Shared/Development/Open Source/AnimatedField/.build/arm64-apple-macosx/debug/AnimatedField_AnimatedField.bundle"

        let preferredBundle = Bundle(path: mainPath)

        guard let bundle = preferredBundle ?? Bundle(path: buildPath) else {
            // Users can write a function called fatalError themselves, we should be resilient against that.
            Swift.fatalError("could not load resource bundle: from \(mainPath) or \(buildPath)")
        }

        return bundle
    }()
}