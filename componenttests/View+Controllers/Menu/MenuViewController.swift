//
//  MenuViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 23/04/22.
//

import UIKit

enum MenuType: Int, CaseIterable {
    case multimediaGallery
}

class MenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
    }

}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { MenuType.allCases.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = MenuType(rawValue: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch type {
        case .multimediaGallery:
            content.image = UIImage(systemName: "books.vertical")
            content.text = "Multimedia Gallery"
        }

        cell.contentConfiguration = content

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let type = MenuType(rawValue: indexPath.row) else { return }
        
        switch type {
        case .multimediaGallery:
            let vc = GalleryViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
