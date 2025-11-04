# Changelog

All notable changes to AnimatedField (Enhanced Fork) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.1] - 2025-11-03

### Fixed
- **Accessibility logic error** - Corrected boolean operator precedence in `updateAccessibility()` method
  - Fixed: `alertLabel.isAccessibilityElement = !alertLabel.text?.isEmpty ?? true`
  - To: `alertLabel.isAccessibilityElement = !(alertLabel.text?.isEmpty ?? true)`
  - Impact: Alert label is now correctly accessible only when it contains text
  - Line: AnimatedField.swift:816

This patch release fixes a compiler error and ensures proper accessibility behavior for alert messages.

## [3.0.0] - 2025-11-03

### 🎉 Major Release - Enhanced Fork

This release represents a significant modernization and enhancement of AnimatedField.
This is an enhanced, actively maintained fork of the original alberdev/AnimatedField project.

### 🛡️ Safety & Stability

#### Fixed
- **Eliminated all force unwraps** - Removed 5 potential crash points
  - TextFieldDelegate: Fixed force unwrap on textField.text (could crash on nil)
  - IconsLibrary: Fixed force unwraps in UIGraphicsGetCurrentContext() (3 instances)
  - IconsLibrary: Fixed force unwraps in UIGraphicsGetImageFromCurrentImageContext() (2 instances)
  - UIView+Nib: Fixed implicitly unwrapped optional parameter
- **XIB loading validation** - Added proper error handling with assertionFailure
- **Thread safety issues** - Removed unsafe static caching in IconsLibrary
- **Array bounds checking** - Added validation for picker delegate array access
- **Counter logic bugs** - Fixed complex counter label calculation that could crash

#### Removed
- **All private API usage** - Removed setValue(_:forKey:"textColor") calls on UIPickerView/UIDatePicker
  - Eliminates App Store rejection risk
  - Better long-term compatibility

### 🚀 Modern Swift

#### Added
- **Swift 6.0 support** with full concurrency
- **@MainActor annotation** on AnimatedField class
- **iOS 16+ minimum deployment target**
- **Swift Package Manager** first-class support
- **Modern concurrency patterns** throughout

#### Changed
- Updated from Swift 5.0 to Swift 6.0
- Updated from iOS 10+ to iOS 16+
- Modernized all APIs to use current best practices

### ♿ Accessibility

#### Added
- **Complete VoiceOver support**
  - Dynamic accessibility labels based on title/placeholder
  - Contextual accessibility hints for user guidance
  - Password visibility toggle announcements
  - Character counter with live updates trait
  - Alert message accessibility with proper traits
- **updateAccessibility()** method for comprehensive a11y management
- Auto-updates accessibility when title, secure state, or visibility changes

### 📦 Features

#### Added
- **Lock image support** - Visual indicator for disabled state
- **Text prefix support** - Add prefixes to field text
- **Improved cursor positioning** - Fixed after formatText() auto-insertion
- **String picker enhancements** - Fixed duplicate string handling
- **Better multiline support** - Improved TextView with scrolling
- **Separate title handling** - Title can now differ from placeholder

#### Changed
- **Lazy NumberFormatter** - Created once and reused for better performance
- **Better error messages** - More descriptive validation errors
- **Improved picker setup** - Better configuration and state management

### 🏗️ Architecture

#### Changed
- **Access levels corrected** - Internal access for extension-accessed properties
- **Property consistency** - keyboardType, returnKeyType, customInputView now update both textField and textView
- **Better encapsulation** - numberOptions and stringOptions now properly scoped

#### Renamed
- **keyboardToolbar → customInputView** - More accurate naming (sets inputView not inputAccessoryView)

### 📚 Documentation

#### Added
- **CLAUDE.md** - Comprehensive codebase architecture documentation
- **TRANSITION_PLAN.md** - Roadmap for future independent package
- **Enhanced README** - Fork notice and improvements section
- **Comprehensive inline documentation** - Especially for complex behaviors
- **Text setter documentation** - Detailed explanation of delegate method invocation

### 🐛 Bug Fixes

#### Fixed
- Cursor position after SwiftMaskTextfield formatting
- Duplicate strings in string picker
- TextView placeholder color and visibility
- Price field validation (uncommented working logic)
- TextField constraints for picker fields
- TextView delegate call improvements

### 🔧 Maintenance

#### Changed
- Updated all package dependencies
- Cleaned up commented code throughout
- Removed magic strings (replaced with named constants)
- Updated copyright notices for dual authorship

### ⚠️ Breaking Changes

#### Changed
- **Minimum iOS version**: iOS 10.0 → iOS 16.0
- **Swift version**: 5.0 → 6.0
- **API rename**: `keyboardToolbar` → `customInputView`
- **Behavior change**: `pickerTextColor` no longer affects pickers (private API removed)

#### Migration Guide

**For iOS version:**
- Update your deployment target to iOS 16.0+

**For API changes:**
```swift
// Before
field.keyboardToolbar = myToolbar

// After
field.customInputView = myToolbar
```

**For picker text color:**
- `format.pickerTextColor` is now ignored
- Pickers will use system default colors
- Use UIAppearance for global picker styling if needed

### 📊 Statistics

- **Files changed**: 27
- **Insertions**: +1,652
- **Deletions**: -766
- **Net improvement**: +886 lines
- **Commits ahead of upstream**: 50+
- **Force unwraps eliminated**: 5
- **Private API calls removed**: 6

### 🙏 Credits

- **Original Author**: Alberto Aznar (@alberdev)
- **Enhanced Fork**: DoubleNode (@DoubleNodeOpen)
- **Contributions**: This release includes 50+ commits of improvements over the original

---

## [2.4.4] - Previous Release

All changes before 3.0.0 are from the original upstream repository.
See https://github.com/alberdev/AnimatedField for historical changelog.

---

## Future Plans

See [TRANSITION_PLAN.md](TRANSITION_PLAN.md) for planned future enhancements including:
- Potential rebranding as independent package (DNSAnimatedField)
- SwiftUI wrapper component
- Additional field types (credit card, phone number with country codes)
- Theme system
- Enhanced testing coverage

---

[3.0.0]: https://github.com/DoubleNodeOpen/AnimatedField/compare/09a1dfc...v3.0.0
[2.4.4]: https://github.com/alberdev/AnimatedField/releases/tag/2.4.4
