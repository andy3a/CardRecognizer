//
//  DetailsViewController+UITextFieldDelegate.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import UIKit

extension DetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        title = "Card Details"
        navigationItem.hidesBackButton = false
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.center.y = (view.frame.size.height - keyboardHeight) / 2
        title = ""
        navigationItem.hidesBackButton = true
    }
}
