//
//  DetailsViewController.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 10.03.22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var cardholderTextField: UITextField!
    @IBOutlet weak var cardTypeTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    var recodnizedImage: RecodnizedImage?
    var cardIndex: Int?
    var keyboardHeight: CGFloat =  336
    
    weak var delegate: MyCardsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTextFields()
        registerForKeyboardNotifications()
    }
    
    private func setUpNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = "Card Details"
    }
    
    private func setUpTextFields() {
        numberTextField.layer.cornerRadius = numberTextField.frame.height / 2
        cardholderTextField.layer.cornerRadius = cardholderTextField.frame.height / 2
        cardTypeTextField.layer.cornerRadius = cardTypeTextField.frame.height / 2
        confirmButton.layer.cornerRadius = confirmButton.frame.height / 2
        
        imageView.image = UIImage().loadImage(fileName: recodnizedImage?.uuid.uuidString ?? "")
        numberTextField.text = recodnizedImage?.cardNumber
        cardholderTextField.text = recodnizedImage?.cardholder
        cardTypeTextField.text = recodnizedImage?.cardType
        confirmButton.backgroundColor = recodnizedImage!.isVerified ? .yellow : .systemPink
        confirmButton.setTitle(recodnizedImage!.isVerified ? "Update!" : "Please verify!", for: .normal)
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    @IBAction func keyboardWillShow(notification: NSNotification?) {
        if let keyboardSize = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
        }
    }
    
    
    @IBAction func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        confirmButton.backgroundColor = UIColor.green
        confirmButton.layer.opacity = 0.5
        confirmButton.isEnabled = false
        confirmButton.setTitle("Verifiled!", for: .normal)
        delegate?.updateArray(index: cardIndex!, card: RecodnizedImage(uuid: recodnizedImage!.uuid, cardNumber: numberTextField.text!, cardholder: cardholderTextField.text!, cardType: cardTypeTextField.text!, isVerified: true))
    }
}

