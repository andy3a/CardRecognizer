//
//  CardTableViewCell.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 10.03.22.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardholder: UILabel!
    @IBOutlet weak var cardType: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    
    weak var delegate: MyCardsViewControllerDelegate?
    
    
    func configure(object: RecodnizedImage) {
        cardImageView.image = UIImage().loadImage(fileName: object.uuid.uuidString)
        cardNumber.text = object.cardNumber
        cardholder.text = object.cardholder
        cardType.text = object.cardType
        checkMark.isHidden = !object.isVerified
        
        
    }
    @IBAction func copyToClipboard(_ sender: UIButton) {
        delegate?.showBanner(copiedText: cardNumber.text!, text: "Copied to clipboard")
    }
    @IBAction func saveImage(_ sender: UIButton) {
        delegate?.showBanner(copiedText: nil, text: "Saved to Gallery")
        if let image = cardImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            delegate?.showBanner(copiedText: nil, text: "Saved to Gallery")
        } else {
            delegate?.showBanner(copiedText: nil, text: "Cannot save to Gallery")
        }
       
    }
    
}
