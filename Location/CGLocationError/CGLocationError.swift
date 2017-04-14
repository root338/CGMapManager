//
//  CGLocationError.swift
//  CGTestMapManager
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 -. All rights reserved.
//

import UIKit
import CoreLocation

public enum CGLocationAuthorizationStatus : Int {
    
    case notDetermined
    
    case restricted
    
    case denied
    
    @available(iOS 8.0, *)
    case authorizedAlways
    
    @available(iOS 8.0, *)
    case authorizedWhenInUse
    
//    case authorized
    
    init(authorizationStatus : CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            self = .notDetermined
        case .restricted:
            self = .restricted
        case .denied:
            self = .denied
        case .authorizedAlways:
            self = .authorizedAlways
        case .authorizedWhenInUse:
            self = .authorizedWhenInUse
        }
    }
}

struct CGLocationError {
    
    let disableLocationService : Bool

    let authorizationStatus : CGLocationAuthorizationStatus
    
    let errorDescription : String?
    
    init() {
        self.init(disableLocationService: false, authorizationStatus: .notDetermined)
    }
    
    init(authorizationStatus: CLAuthorizationStatus) {
        self.init(disableLocationService: true, authorizationStatus: authorizationStatus)
    }
    
    init(disableLocationService: Bool, authorizationStatus: CLAuthorizationStatus) {
        
        self.init(disableLocationService: disableLocationService, authorizationStatus: authorizationStatus, errorDescription: nil)
    }
    
    init(disableLocationService: Bool, authorizationStatus: CLAuthorizationStatus, errorDescription: String?) {
        
        self.disableLocationService = disableLocationService
        self.authorizationStatus    = CGLocationAuthorizationStatus.init(authorizationStatus: authorizationStatus)
        self.errorDescription       = errorDescription
    }
}
