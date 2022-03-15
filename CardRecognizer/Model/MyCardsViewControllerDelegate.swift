//
//  MyCardsViewControllerDelegate.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import Foundation

protocol MyCardsViewControllerDelegate: AnyObject {
    func updateArray(index: Int, card: RecodnizedImage)
    func showBanner(copiedText: String?, text: String) 
}
