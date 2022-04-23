//
//  GalleryCell.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import UIKit
import AVFoundation

enum GalleryType {
    case image
    case video
}

class GalleryCell: UICollectionViewCell {
    
    static let identifier = "GalleryCell"
    
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(data: GalleryViewModel) {
        switch data.type {
        case .image:
            APIManager.shared.requestImage(urlString: data.url) { [weak self] (result) in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.pictureImageView.image = image
                    }
                case.failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        case .video:
            guard let url = URL(string: data.url) else { return }
            let asset: AVAsset = AVAsset(url: url)
            let generator = AVAssetImageGenerator(asset: asset)
            
            self.isUserInteractionEnabled = false
            durationLabel.isHidden = true
            DispatchQueue.global().async {
                let durationTime = Int(ceil(CMTimeGetSeconds(asset.duration)))
                let minutes = durationTime / 60
                let seconds = durationTime % 60
                let videoDuration = "\(minutes):\(seconds)"
                guard let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 1, preferredTimescale: 60), actualTime: nil) else { return }
                
                DispatchQueue.main.async {
                    self.durationLabel.isHidden = false
                    self.isUserInteractionEnabled = true
                    self.durationLabel.text = videoDuration
                    self.pictureImageView.image = UIImage(cgImage: cgImage)
                }
            }
        }
    }
}
