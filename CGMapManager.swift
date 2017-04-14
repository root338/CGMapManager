//
//  CGMapManager.swift
//  TestCG_CGKit
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 8.0, *)
class CGMapManager: NSObject {

    static let shareManager = CGMapManager.init()
    
    private let _mapView     = MKMapView.init()
    
    private let _locationManager    = CGLocationManager.init(configuration: CGLocationConfiguration.init())
    
    var mapView : MKMapView {
        return _mapView
    }
    
    func getMapView(frame: CGRect) -> MKMapView {
        
        if mapView.frame.equalTo(frame) == false {
            mapView.frame   = frame
        }
        return self.mapView
    }
    
    func openUserLocation() -> Void {
        _locationManager.currentLocation()
//        if _mapView.isUserLocationVisible {
//            
//        }
//        
//        _mapView.showsUserLocation  = true
    }
}
