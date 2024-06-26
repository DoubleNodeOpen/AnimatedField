//
//  AnimatedField+Delegate.swift
//  FashTime
//
//  Created by Alberto Aznar de los Ríos on 03/04/2019.
//  Copyright © 2019 FashTime Ltd. All rights reserved.
//

import UIKit

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
                    // return false
                }
            }
        }
        
        var newText = textField.text ?? string
        if range.length == string.count {
            newText = string
        } else {
            if let newRange = Range(range, in: textField.text!) {
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
        return false
        // Check limits
//        return textField.text?.count ?? 0 + newInput.count < limit
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
