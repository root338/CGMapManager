//
//  CGLocationManager.swift
//  TestCG_CGKit
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import CoreLocation

typealias CGAvailableLocationCompletion = (_ isUserLocationVisible : Bool, _ error: CGLocationError?) -> Void
typealias CGLocationInfoArrayCompletion = (_ locationInfoArray: [CGLocationDetailInfo]?) -> Void
typealias CGLocationInfoCompletion = (_ locationInfo: CGLocationDetailInfo?) -> Void

@available(iOS 8.0, *)
class CGLocationManager: NSObject, CLLocationManagerDelegate {
    
    let configuration : CGLocationConfiguration
    
    
    
    fileprivate var _locationManager        = CLLocationManager.init()
    fileprivate var _geocoder : CLGeocoder?
    
    /// 定位是否可用回调数组
    private var _availableLocationArray = [CGAvailableLocationCompletion]()
    /// 定位
    fileprivate var _currentLocationCompletionArray = [CGLocationInfoCompletion]()
    
    private var enableUpdatingLocation : Bool = false {
        didSet {
            
            if self.isUserLocationVisible() {
                if enableUpdatingLocation != oldValue {
                    if enableUpdatingLocation {
                        
                        _locationManager.startUpdatingLocation()
                    }else {
                        
                        _locationManager.stopUpdatingLocation()
                    }
                }
            }else {
                enableUpdatingLocation  = false
            }
        }
    }
    
    init(configuration: CGLocationConfiguration) {
        
        self.configuration  = configuration
        
        super.init()
        
        _locationManager.delegate           = self
        _locationManager.activityType       = configuration.activityTypeForLocation
        _locationManager.desiredAccuracy    = configuration.desiredAccuracy
        _locationManager.distanceFilter     = configuration.distanceFilter
        
    }
    
    func currentLocation() -> Void {
        
        self.availableLocation { (isUserLocationVisible, error) in
            
            if isUserLocationVisible {
                self.enableUpdatingLocation = true
            }
        }
    }
    
    func isUserLocationVisible() -> Bool {
        
        var returnValue = false
        
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            returnValue = true
        }
        
        return returnValue
    }
    
    func availableLocation(completion: @escaping (_ isUserLocationVisible : Bool, _ error: CGLocationError?) -> Void) -> Void {
        
        let locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        
        var error : CGLocationError?
        var isVisible   = false
        let authorizationStatus : CLAuthorizationStatus?
        
        if locationServicesEnabled {
            
            authorizationStatus = CLLocationManager.authorizationStatus()
            if authorizationStatus == .notDetermined {
                
                _availableLocationArray.append(completion)
                
                if configuration.locationAuthorizedModel == .authorizedAlways {
                    
                    _locationManager.requestAlwaysAuthorization()
                }else {
                    _locationManager.requestWhenInUseAuthorization()
                }
                
            }else {
                
                isVisible   = self.isUserLocationVisible()
            }
        }else {
            authorizationStatus = nil
        }
        
        if isVisible {
            
            completion(isVisible, nil)
        }else {
            
            if let status = authorizationStatus {
                
                if status == .notDetermined {
                    return
                }
                
                error   = CGLocationError.init(authorizationStatus: status)
            }else {
                // 授权信息为 用户未选择
                error   = CGLocationError.init()
            }
            
            completion(isVisible, error)
        }
    }
    
    //MARK:- CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status != .notDetermined && _availableLocationArray.count > 0 {
            
            for value in _availableLocationArray {
                self.availableLocation(completion: value)
            }
            _availableLocationArray.removeAll()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            
        }
        
    }
    
}


// MARK: - 编码／反编码
fileprivate extension CGLocationManager {
    
    var geocoder : CLGeocoder! {
        
        if _geocoder == nil {
            _geocoder = CLGeocoder.init()
        }
        
        return _geocoder!
    }
    
    func handleLocations(_ locations: [CLLocation], completion: CGLocationInfoArrayCompletion) -> Void {
        
    }
    
    func addressName(from location: CLLocation, completion: @escaping CGLocationInfoCompletion) -> Void {
        
        let geocoder = self.geocoder
        
        geocoder?.reverseGeocodeLocation(location, completionHandler: { (paramPlacemarks, paramError) in
            
            let locationInfo    = CGLocationDetailInfo.init(location: location, placemark: paramPlacemarks, error: paramError)
            completion(locationInfo)
        })
    }
    
    func addressNames(from locations: [CLLocation], completion: CGLocationInfoCompletion) -> Void {
        
    }
    
}
