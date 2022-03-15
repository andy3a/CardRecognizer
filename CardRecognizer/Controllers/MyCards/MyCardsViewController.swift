//
//  ViewController.swift
//  CardRecognizer2
//
//  Created by Andrew_Alekseyuk on 10.03.22.
//

import UIKit
import VisionKit
import Vision
import TinyConstraints

class MyCardsViewController: UIViewController {

    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let spinner = UIActivityIndicatorView()
    let documentCameraViewController = VNDocumentCameraViewController()
    var textRecognitionRequest = VNRecognizeTextRequest()
    
    let model = MyCardsViewModel()
    
    var transcript: [String] = []
    
    var cardNumber: String?
    var cardholderName: String?
    var cardType: String?
    
    var image = UIImage()
    var editToogle = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavgationBar()
        setUpTable()
        setUpRecognizer()
        view.addSubview(spinner)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = view.frame
        spinner.frame = view.frame
        spinner.style = .large
        spinner.hidesWhenStopped = true

    }
    
    private func setUpNavgationBar() {
        title = "My cards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Scan", style: .plain, target: self, action: #selector(presentCameraViewController))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMode))
    }
    
    private func setUpTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "CardTableViewCell", bundle: nil), forCellReuseIdentifier: "CardTableViewCell")
    }
    
    func setUpRecognizer() {
        documentCameraViewController.delegate = self
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { (request, error) in
            
            if let results = request.results, !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    DispatchQueue.main.async {
                        self.addRecognizedText(recognizedText: requestResults)
                    }
                }
            }
        })
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true
    }
    
    func saveCardsLocally() {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(model.cardsArray)
        UserDefaults.standard.set(data, forKey: "cardsArray")
    }
    
    @IBAction func presentCameraViewController() {
        let documentCameraViewController = VNDocumentCameraViewController()
        documentCameraViewController.delegate = self
        present(documentCameraViewController, animated: true)
    }
    
    @IBAction func editMode() {
        if editToogle {
            editToogle.toggle()
            navigationItem.leftBarButtonItem?.title = "Edit"
            tableView.setEditing(editToogle, animated: true)
        } else {
            editToogle.toggle()
            navigationItem.leftBarButtonItem?.title = "Done"
            tableView.setEditing(editToogle, animated: true)
        }
    }
}









