//
//  MapViewController.swift
//  componenttests
//
//  Created by Ricardo Granja Chávez on 13/04/22.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var address: AddressViewModel!
    
    convenience init(address: AddressViewModel) {
        self.init()
        self.address = address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupMap()
    }
    
    private func setupMap() {
        guard let lat = Double(self.address.geo.lat), let lng = Double(self.address.geo.lng) else { return }
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        let site = MKPointAnnotation()
        site.title = self.address.city
        site.coordinate = locationCoordinate
        mapView.addAnnotation(site)
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)
        let coordinateRegion = MKCoordinateRegion(center: locationCoordinate, span: coordinateSpan)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
