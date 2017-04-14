//
//  CGLocationDetailInfo.swift
//  CGTestMapManager
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 -. All rights reserved.
//

import UIKit
import CoreLocation


/// 地址解析的类型
///
/// - cancel: 取消的解析
/// - unknown: 未知无法解析
/// - location: 使用 CLLocation 类型变量解析，使用CLGeocoder reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping CoreLocation.CLGeocodeCompletionHandler) 方法
/// - addressDictionary: 使用 [AnyHashable : Any] 类型变量解析，使用geocodeAddressDictionary(_ addressDictionary: [AnyHashable : Any], completionHandler: @escaping CoreLocation.CLGeocodeCompletionHandler) 方法
/// - addressName: 使用 String 类型变量解析，使用geocodeAddressString(_ addressString: String, completionHandler: @escaping CoreLocation.CLGeocodeCompletionHandler)方法
/// - addressNameAndRegion: 使用 String, CLRegion 类型变量解析，使用 geocodeAddressString(_ addressString: String, in region: CLRegion?, completionHandler: @escaping CoreLocation.CLGeocodeCompletionHandler)
enum CGLocationGeocoderType : Int {
    case cancel
    case unknown
    case location
    case addressDictionary
    case addressName
    case addressNameAndRegion
}

class CGLocationDetailInfo: NSObject {

    let geocoderType : CGLocationGeocoderType
    
    let location : CLLocation?
    
    let addressDictionary : Dictionary<AnyHashable, Any>?
    let addressName : String?
    let region : CLRegion?
    
    let placemark : [CLPlacemark]?
    
    let error : Error?
    
    private init(geocoderType: CGLocationGeocoderType, location: CLLocation?, addressDictionary: Dictionary<AnyHashable, Any>?, addressName: String?, region: CLRegion?, placemark : [CLPlacemark]?, error : Error?) {
        
        self.geocoderType       = geocoderType
        
        self.location           = location
        self.addressDictionary  = addressDictionary
        self.addressName        = addressName
        self.region             = region
        self.placemark          = placemark
        self.error              = error
        
        super.init()
    }
    
    convenience init(location: CLLocation, placemark: [CLPlacemark]?, error : Error?) {
        self.init(geocoderType: .location, location: location, addressDictionary: nil, addressName: nil, region: nil, placemark: placemark, error: error)
    }
    
    convenience init(addressDictionary: Dictionary<AnyHashable, Any>?, placemark: [CLPlacemark]?, error : Error?) {
        self.init(geocoderType: .addressDictionary, location: nil, addressDictionary: addressDictionary, addressName: nil, region: nil, placemark: placemark, error: error)
    }
    
    convenience init(addressName: String, region: CLRegion?, placemark: [CLPlacemark]?, error : Error?) {
        
        let geocoderType : CGLocationGeocoderType
        if region == nil {
            geocoderType = .addressName
        }else {
            geocoderType = .addressNameAndRegion
        }
        self.init(geocoderType: geocoderType, location: nil, addressDictionary: nil, addressName: addressName, region: region, placemark: placemark, error: error)
    }
}
