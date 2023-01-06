//
//  ViewController.swift
//  houmuch
//
//  Created by uniess on 2023/01/06.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }
}

