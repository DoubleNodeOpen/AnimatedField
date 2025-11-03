# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AnimatedField is an iOS/macOS Swift package that provides animated, validated text input fields. It's a customizable UITextField/UITextView component with built-in validation using regular expressions, text formatting, and animated placeholder behavior.

**Key Features:**
- Animated title/placeholder transitions
- Built-in validation for common field types (email, username, password, URL, price)
- Custom regex validation support
- Date and number pickers
- Multiline text support with dynamic resizing
- Character limits and formatting
- Alert messages for validation errors

## Build & Development Commands

### Swift Package Manager (Primary)

```bash
# Build the package
swift build

# Run tests (if available)
swift test

# Clean build artifacts
swift package clean

# Update dependencies
swift package update

# Resolve dependencies
swift package resolve

# Generate Xcode project (for development)
swift package generate-xcodeproj
```

### CocoaPods (Legacy Support)

The project also supports CocoaPods distribution via `AnimatedField.podspec`:

```bash
# Validate podspec
pod lib lint AnimatedField.podspec

# Install example project dependencies
cd Example && pod install
```

## Architecture

### Core Components

#### 1. **AnimatedField (Main Class)**
- Location: `Sources/AnimatedField/AnimatedField.swift`
- Main UI component that combines UITextField/UITextView with animated labels
- Uses SwiftMaskTextfield for masked input support
- Handles validation, formatting, and user interactions

#### 2. **AnimatedFieldType (Enum)**
- Location: `Sources/AnimatedField/AnimatedFieldType.swift`
- Defines field types with built-in validation patterns:
  - `.none` - No validation
  - `.email` - Email validation
  - `.text(fieldName, min, max)` - Generic text with length limits
  - `.username(min, max)` - Username validation
  - `.password(min, max)` - Password validation
  - `.price(maxPrice, maxDecimals)` - Price formatting and validation
  - `.url(fieldName, minLength)` - URL validation
  - `.datepicker(...)` - Date selection with picker
  - `.numberpicker(...)` - Number selection with picker
  - `.stringpicker(...)` - String selection with picker
  - `.multiline` - Multiline text view

Each type provides:
- `typingExpression` - Regex for filtering characters during input
- `validationExpression` - Regex for final validation
- `validationError` - Default error message

#### 3. **AnimatedFieldFormat (Struct)**
- Location: `Sources/AnimatedField/AnimatedFieldFormat.swift`
- Configuration object for visual customization:
  - Fonts (title, text, counter, alert)
  - Colors (line, title, text, counter, alert, highlight, placeholder)
  - Alert behavior (enabled, position, colored elements)
  - Counter behavior (enabled, countdown, animation)
  - Invalid characters filtering
  - TextField height

#### 4. **Protocol Architecture**
- Location: `Sources/AnimatedField/AnimatedField+Protocols.swift`

**AnimatedFieldDataSource:**
- Provides validation and filtering logic
- Methods: character change validation, return handling, character limits, typing/validation regex, error messages

**AnimatedFieldDelegate:**
- Handles field events and state changes
- Methods: begin/end editing, resizing, secure text toggle, picker value changes, alert display, text changes

**AnimatedFieldInterface:**
- Public interface for field manipulation
- Methods: restart(), showAlert(), hideAlert(), secureField()

#### 5. **Delegate Extensions**
- `AnimatedField+TextFieldDelegate.swift` - UITextFieldDelegate implementation
- `AnimatedField+TextViewDelegate.swift` - UITextViewDelegate implementation
- `AnimatedField+UIPickerViewDelegate.swift` - UIPickerViewDelegate implementation

### Extension Utilities

Located in `Sources/AnimatedField/Extensions/`:
- `Date+Format.swift` - Date formatting helpers
- `String+RegEx.swift` - Regex matching for validation
- `UIView+Nib.swift` - XIB loading utilities
- `UIView+Shake.swift` - Shake animation for validation errors

### Visual Components

- `IconsLibrary.swift` - Custom eye icons for secure field visibility toggle
- `AnimatedFieldAlertPosition.swift` - Alert positioning enum (top/bottom)
- `Resources/AnimatedField.xib` - Interface Builder layout

## Dependencies

Managed via Swift Package Manager in `Package.swift`:

1. **SwiftMaskTextfield** (1.1.3+)
   - From: https://github.com/DoubleNodeOpen/swift-mask-textfield.git
   - Provides masked text input functionality

2. **DNSCore** (1.12.0+)
   - From: https://github.com/DoubleNode/DNSCore.git
   - Core utilities framework

## Platform Support

Defined in `Package.swift`:
- iOS 16.0+
- tvOS 16.0+
- macCatalyst 16.0+
- macOS 13.0+
- watchOS 9.0+

Swift language mode: Swift 5

## Usage Pattern

Fields follow this typical implementation pattern:

1. Create AnimatedField instance (usually via Interface Builder)
2. Configure format with AnimatedFieldFormat
3. Set field type using AnimatedFieldType enum
4. Implement AnimatedFieldDataSource for custom validation (optional)
5. Implement AnimatedFieldDelegate for event handling (optional)
6. Access validation state via `isValid` property

## Validation Flow

1. **During typing**: `typingExpression` filters allowed characters
2. **On character change**: DataSource `shouldChangeCharactersIn` consulted
3. **On end editing**: `validationExpression` validates complete input
4. **On validation failure**: Shows alert with error message from DataSource or default

## Important Implementation Notes

- The main view is loaded from XIB (`AnimatedField.xib`)
- SwiftMaskTextfield is used internally for the text field component
- Multiline fields dynamically resize and notify delegates of height changes
- Price fields respect locale-specific decimal separators
- Secure fields can toggle visibility with eye button
- Character counter supports both count-up and count-down modes
- Alert position can be configured (top/bottom of field)

## Recent Changes

Based on recent commits:
- Fixed cursor positioning after formatText() auto-insertion
- Explicitly triggering SwiftMaskTextfield formatting
- Updated package dependencies
- Migration to modern Swift Package Manager structure
