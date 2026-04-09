//
//  AnimatedField+Delegate.swift
//  FashTime
//
//  Created by Alberto Aznar de los Ríos on 03/04/2019.
//  Copyright © 2019 FashTime Ltd. All rights reserved.
//

import UIKit
import SwiftMaskTextfield

extension AnimatedField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Priorize datasource returns
        if let shouldChange = dataSource?.animatedField(self, shouldChangeCharactersIn: range, replacementString: string) {
            return shouldChange
        }
        
        var string = string
        // Apply uppercased & lowercased if available
        if uppercased { string = string.uppercased() }
        if lowercased { string = string.lowercased() }
        
        // Copy new character
        var newInput = string

        let invalidCharacters = format.invalidCharacters.map { String($0) }
        for invalidCharacter in invalidCharacters {
            // Replace special characters in newInput
            newInput = newInput.replacingOccurrences(of: invalidCharacter, with: "")

            // Replace special characters in textField
            textField.text = textField.text?.replacingOccurrences(of: invalidCharacter, with: "")
            // Trigger formatting after text change
            if let maskTextField = textField as? SwiftMaskTextfield {
                maskTextField.formatText()
            }
        }

        // Limits & Regular expressions
        let limit = dataSource?.animatedFieldLimit(self) ?? Int.max
        let typingExpression = "\(type.typingExpression)+"
        let regex = dataSource?.animatedFieldTypingMatches(self) ?? typingExpression
        
        // Check regular expression
        if !newInput.isValidWithRegEx(regex) && newInput != "" { return false }
        
        // Change textfield in manual mode in case of changing newInput. Check limits also
        if newInput != string {
            textField.text = textField.text?.count ?? 0 + newInput.count <= limit ? "\(textField.text ?? "")\(newInput)" : textField.text
            // Trigger formatting after text change
            if let maskTextField = textField as? SwiftMaskTextfield {
                maskTextField.formatText()
            }
            return false
        }
        
        // Check price (if case)
        if newInput != "", case let AnimatedFieldType.price(maxPrice, maxDecimals) = type {
            
            let newText = "\(textField.text ?? "")\(newInput)"
        
            if let price = formatter.number(from: newText) {
                let components = newText.components(separatedBy: Locale.current.decimalSeparator ?? ".")
                if components.count > 1 {
                    if components[1].count > maxDecimals {
                        return false
                    }
                }
                if price.doubleValue > maxPrice {
                    return false
                }
            }
        }
        
        var newText = textField.text ?? string
        if range.length == string.count {
            newText = string
        } else {
            if let text = textField.text, let newRange = Range(range, in: text) {
                newText.replaceSubrange(newRange, with: string)
            } else {
                newText = string
            }
        }
        if newText.isEmpty {
            if !isPlaceholderVisible {
                animateOut()
            }
        } else {
            if isPlaceholderVisible {
                animateIn()
            }
        }
        textField.text = newText

        // Explicitly trigger SwiftMaskTextfield formatting after manual text change
        if let maskTextField = textField as? SwiftMaskTextfield {
            maskTextField.formatText()
        }

        // Calculate cursor position AFTER formatting to account for auto-inserted characters
        var offset: Int
        if string.count == 0 {
            // Deletion: cursor stays at deletion point
            offset = range.location
        } else {
            let formatPattern = textField.formatPattern
            if !formatPattern.isEmpty {
                // Map cursor from formatted-text coordinates to raw-content coordinates,
                // advance by typed characters, then map back to formatted coordinates.
                // Pattern placeholders (#, @, a, A, *) are content slots; everything else
                // is a literal separator inserted by formatText().
                let placeholders: Set<Character> = ["#", "@", "a", "A", "*"]

                // Displayed text = prefix + formatted. range.location is in displayed
                // coordinates, but the pattern only covers the formatted portion.
                let prefixLen = textField.prefix.count
                let patternLocation = max(range.location - prefixLen, 0)

                // Step 1: count content characters before patternLocation in the pattern
                var rawLocation = 0
                for pos in 0..<min(patternLocation, formatPattern.count) {
                    let idx = formatPattern.index(formatPattern.startIndex, offsetBy: pos)
                    if placeholders.contains(formatPattern[idx]) {
                        rawLocation += 1
                    }
                }
                let rawCursor = rawLocation + string.count

                // Step 2: walk the pattern to find the formatted position of rawCursor
                var contentCount = 0
                var patternOffset = formatPattern.count
                for pos in 0..<formatPattern.count {
                    if contentCount >= rawCursor {
                        patternOffset = pos
                        break
                    }
                    let idx = formatPattern.index(formatPattern.startIndex, offsetBy: pos)
                    if placeholders.contains(formatPattern[idx]) {
                        contentCount += 1
                    }
                }
                // Add prefix back to get displayed-text offset
                offset = patternOffset + prefixLen
            } else {
                // No format pattern: simple cursor positioning
                offset = range.location + string.count
            }
            // Clamp to actual text length
            offset = min(offset, textField.text?.count ?? offset)
        }
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: offset) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        return false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return dataSource?.animatedFieldShouldReturn(self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if !format.titleAlwaysVisible && textField.text?.count == 0 {
            animateIn()
        }
        hideAlert()
        highlightField(true)
        delegate?.animatedFieldDidBeginEditing(self)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if !format.titleAlwaysVisible && textField.text?.count == 0 {
            animateOut()
        }
        highlightField(false)
        delegate?.animatedFieldDidEndEditing(self)
        
        if let error = validateText(textField.text) {
            showAlert(error)
            delegate?.animatedField(self, didShowAlertMessage: error)
        }
    }
}
