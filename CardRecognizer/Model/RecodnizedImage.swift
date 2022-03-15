//
//  RecodnizedImage.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import Foundation

struct RecodnizedImage: Codable {
     init(uuid: UUID = UUID(), cardNumber: String, cardholder: String, cardType: String, isVerified: Bool = false) {
        self.uuid = uuid
        self.cardNumber = cardNumber
        self.cardholder = cardholder
        self.cardType = cardType
        self.isVerified = isVerified
    }

    var uuid = UUID()
    var cardNumber: String
    var cardholder: String
    var cardType: String
    var isVerified: Bool = false
    
   
}
