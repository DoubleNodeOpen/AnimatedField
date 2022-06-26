//
//  AnimatedField+UIPickerViewDelegate.swift
//  AnimatedField
//
//  Created by Alberto Aznar de los Ríos on 12/04/2019.
//

import UIKit

extension AnimatedField: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if case AnimatedFieldType.numberpicker = type {
            return numberOptions.count
        }
        if case AnimatedFieldType.stringpicker = type {
            return stringOptions.count
        }
        return 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if case AnimatedFieldType.numberpicker = type {
            return "\(numberOptions[row])"
        }
        if case AnimatedFieldType.stringpicker = type {
            return "\(stringOptions[row])"
        }
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if case AnimatedFieldType.numberpicker = type {
            delegate?.animatedField(self, didChangePickerValue: "\(numberOptions[row])")
        }
        if case AnimatedFieldType.stringpicker = type {
            delegate?.animatedField(self, didChangePickerValue: "\(stringOptions[row])")
        }
    }
}
