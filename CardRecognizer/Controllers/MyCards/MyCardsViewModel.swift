//
//  MyCardsViewModel.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import Foundation

class MyCardsViewModel {
    var cardsArray: [RecodnizedImage] = []
    
    var cardNumber: String?
    var cardholderName: String?
    var cardType: String?
    
    init() {
        cardsArray = getSavedData()
    }
    
    func getSavedData() -> [RecodnizedImage] {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "cardsArray") else {return []}
        guard let cardsArray = try? decoder.decode([RecodnizedImage].self, from: data) else {return []}
        return cardsArray
    }
}
