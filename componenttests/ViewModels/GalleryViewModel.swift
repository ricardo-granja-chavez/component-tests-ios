//
//  GalleryViewModel.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import Foundation

struct GalleryViewModel {
    let url: String
    let type: GalleryType
}

struct GalleryListViewModel {
    private var items: [GalleryViewModel] = []
    
    var count: Int { self.items.count }
    
    init(items: [GalleryViewModel]) {
        self.items = items
    }
    
    func itemForIndex(_ index: Int) -> GalleryViewModel { self.items[index] }
}
