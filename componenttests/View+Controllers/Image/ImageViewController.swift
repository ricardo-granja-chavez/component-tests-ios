//
//  ImageViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    private var url: URL!
    private var isNavigationBarHidden: Bool = false
    
    convenience init(url: URL) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(oneTapImageAction))
        oneTap.numberOfTapsRequired = 1
        pictureImageView.addGestureRecognizer(oneTap)
        pictureImageView.isUserInteractionEnabled = true
        
        getImage()
    }
    
    @objc private func oneTapImageAction() {
        self.isNavigationBarHidden.toggle()
        self.navigationController?.setNavigationBarHidden(self.isNavigationBarHidden, animated: true)
    }
    
    func getImage() {
        APIManager.shared.requestImage(urlString: self.url.absoluteString) { [weak self] (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pictureImageView.image = image
                }
            case.failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
