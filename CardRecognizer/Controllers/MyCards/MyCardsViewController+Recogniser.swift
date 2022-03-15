//
//  MyCardsViewController+Recogniser.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 15.03.22.
//

import UIKit
import VisionKit
import Vision

extension MyCardsViewController: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        controller.dismiss(animated: true) {
            self.spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                for pageNumber in 0 ..< scan.pageCount {
                    let image = scan.imageOfPage(at: pageNumber)
                    //self.saveImage(image: image)
                    self.processImage(image: image)
                }
            }
        }
    }
    
    func processImage(image: UIImage) {
        self.image = image
        guard let cgImage = image.cgImage else {
            print("Failed to get cgimage from input image")
            return
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    
    func addRecognizedText(recognizedText: [VNRecognizedTextObservation]) {
        
        let maximumCandidates = 1
        for observation in recognizedText {
            guard let candidate = observation.topCandidates(maximumCandidates).first else { continue }
            transcript.append(candidate.string)
        }
        
        //Get card number
        for (index, element) in transcript.enumerated() {
            let regexPattern = "(\\b\\d{4}\\s\\d{4}\\s\\d{4}\\s\\d{4}\\b)"
            let range = NSRange(location: 0, length: element.count)
            let regexMatcher = try? NSRegularExpression(pattern: regexPattern)
            if regexMatcher?.firstMatch(in: element, options: [], range: range) != nil { // 3
                self.cardNumber = element
                transcript.remove(at: index)
            }
        }
        
        //Get cardholderName
        for (index, element) in transcript.enumerated() {
            let regexPattern = "^((?!/).)[A-Z]+ [A-Z]+"
            let range = NSRange(location: 0, length: element.count)
            let regexMatcher = try? NSRegularExpression(pattern: regexPattern)
            if regexMatcher?.firstMatch(in: element, options: [], range: range) != nil { // 3
                self.cardholderName = element
            }
        }
        //get card type
        for type in CardType.allCards {
            let numberOnly = cardNumber?.replacingOccurrences(of: " ", with: "")
            let range = NSRange(location: 0, length: numberOnly!.count)
            let regexMatcher = try? NSRegularExpression(pattern: type.regex)
            if regexMatcher?.firstMatch(in: numberOnly!, options: [], range: range) != nil { // 3
                self.cardType = type.rawValue
            }
        }
        
        guard let cardNumber = cardNumber else {return}
        guard let cardholderName = cardholderName else {return}
        guard let cardType = cardType else {return}
        let newRecodnizedImage = RecodnizedImage(cardNumber: cardNumber, cardholder: cardholderName, cardType: cardType)
        UIImage().saveImage(image: image, uuid: newRecodnizedImage.uuid.uuidString)
        model.cardsArray.append(newRecodnizedImage)
        
        self.tableView.beginUpdates()
        var ip = IndexPath(row: model.cardsArray.count - 1, section: 0)
        self.tableView.insertRows(at: [ip], with: UITableView.RowAnimation.fade)
        self.tableView.endUpdates()
        self.spinner.stopAnimating()
        self.saveCardsLocally()
        transcript = []
    }
}
