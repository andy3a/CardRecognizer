//
//  MyCardsViewController+Delegate.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import UIKit

extension MyCardsViewController: MyCardsViewControllerDelegate {
    
    func showBanner(copiedText: String? = nil, text: String)  {
        let banner = UILabel(frame: CGRect(x: 50, y: view.frame.height, width: view.frame.width - 100, height: 40))
        banner.text = text
        banner.textColor = .white
        banner.backgroundColor = .gray
        banner.textAlignment = .center
        banner.layer.masksToBounds = true
        banner.layer.cornerRadius = 20
        view.addSubview(banner)
        UIPasteboard.general.string = copiedText
        UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseOut, animations: {
            banner.frame.origin.y -= 100
            
        })
        DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
            UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseInOut, animations: {
                banner.frame.origin.y += 100
   
            }) { _ in
                banner.removeFromSuperview()
            }
        }
    }
    
    func updateArray(index: Int, card: RecodnizedImage) {
        model.cardsArray.remove(at: index)
        model.cardsArray.insert(card, at: index)
        tableView.reloadData()
        self.saveCardsLocally()
    }
}
