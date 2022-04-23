//
//  GalleryCollectionView.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    var collection: GalleryListViewModel!
    var onPress: (GalleryViewModel) -> Void = { (_) in }
    
    private var numbercCollage: Int = 5
}

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = UIScreen.main.bounds.size.width / CGFloat(self.numbercCollage)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 0 }
}

extension GalleryCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.collection.itemForIndex(indexPath.row)
        self.onPress(item)
    }
}

extension GalleryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collection != nil ? self.collection.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        let data = self.collection.itemForIndex(indexPath.row)
        cell.configure(data: data)
        return cell
    }
}
