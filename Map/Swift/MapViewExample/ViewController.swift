//
//  ViewController.swift
//  MapViewExample
//
//  Created by Adam Fish on 10/28/15.
//  Copyright © 2015 Adam Fish. All rights reserved.
//

import UIKit
import RealmSwift
import RealmSwiftSFRestaurantData
import RealmMapView

class ViewController: UIViewController {

    @IBOutlet var mapView: RealmMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var config = Realm.Configuration.defaultConfiguration
        config.path = ABFRestaurantScoresPath()
        self.mapView.realmConfiguration = config
        
        self.mapView.fetchedResultsController.clusterTitleFormatString = "$OBJECTSCOUNT restaurants in this area"
        
        self.mapView.delegate = self
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if let safeObjects = ABFClusterAnnotationView.safeObjectsForClusterAnnotationView(view) {
            
            if let firstObjectName = safeObjects.first?.toObject(ABFRestaurantObject).name {
                print("First Object: \(firstObjectName)")
            }
        }
    }
}
