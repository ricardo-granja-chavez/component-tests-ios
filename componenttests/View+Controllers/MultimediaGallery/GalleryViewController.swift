//
//  MultimediaGalleryViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import UIKit
import AVKit
import AVFoundation

class GalleryViewController: UIViewController {

    @IBOutlet weak var galleryCollectionView: GalleryCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Multimedia Gallery"
        
        galleryCollectionView.register(UINib(nibName: GalleryCell.identifier, bundle: nil), forCellWithReuseIdentifier: GalleryCell.identifier)
        galleryCollectionView.delegate = galleryCollectionView
        galleryCollectionView.dataSource = galleryCollectionView
        galleryCollectionView.onPress = { (gallery) in
            guard let url = URL(string: gallery.url) else { return }
            
            switch gallery.type {
            case .image:
                let vc = ImageViewController(url: url)
                self.navigationController?.pushViewController(vc, animated: true)
            case .video:
                let player = AVPlayer(url: url)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                
                self.present(playerViewController, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        playerViewController.player?.play()
                    }
                }
            }
        }
        
        let videoUrlString = "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v"
        let imageUrlString = "http://i.imgur.com/w5rkSIj.jpg"
        galleryCollectionView.collection = GalleryListViewModel(items: [
            GalleryViewModel(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", type: .video),
            GalleryViewModel(url: videoUrlString, type: .video),
            GalleryViewModel(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", type: .video),
            GalleryViewModel(url: videoUrlString, type: .video),
            
            GalleryViewModel(url: imageUrlString, type: .image),
            GalleryViewModel(url: imageUrlString, type: .image),
            GalleryViewModel(url: imageUrlString, type: .image),
            GalleryViewModel(url: imageUrlString, type: .image),
            
            GalleryViewModel(url: videoUrlString, type: .video),
            GalleryViewModel(url: imageUrlString, type: .image),
            GalleryViewModel(url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4", type: .video),
            GalleryViewModel(url: imageUrlString, type: .image),
        ])
    }

}
