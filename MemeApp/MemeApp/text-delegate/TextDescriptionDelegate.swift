//
//  TextDescriptionDelegate.swift
//  MemeApp
//
//  Created by juan ocampo on 4/12/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import Foundation
import UIKit

class TextDescriptionDelegate: NSObject, UITextFieldDelegate {
    var defaultText: String
    
    init(defaultText: String) {
        self.defaultText = defaultText
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text {
            if (text == defaultText) {
                textField.text = ""
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
}
