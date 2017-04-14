//
//  CGLocationConfiguration.swift
//  CGTestMapManager
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 -. All rights reserved.
//

import UIKit
import CoreLocation.CLLocation

/// 应用定位的方式
///
/// - authorizedWhenInUse: 使用期间内使用定位
/// - authorizedAlways: 总是使用定位
enum CGLocationModel : Int {
    
    case authorizedWhenInUse
    case authorizedAlways
}


/// 这个值是和更新位置信息有关，当一定时间范围内没有检测用户的位置变化的话，则自动暂停位置服务，等到位置发生变化后才唤醒，这个目的是为了节省系统电量
///
/// - other:
/// - automotiveNavigation: 汽车使用
/// - fitness: 徒步使用
/// - otherNavigation: 船，火车，飞机使用
enum CGLocationActivityType : Int {
    
    case other
    
    case automotiveNavigation
    
    case fitness
    
    case otherNavigation
}

enum CGLocationAccuracyType : Int {
    
    case bestForNavigation
    case best
    
    case nearestTenMeters
    case hundredMeters
    case kilometer
    case threeKilometers
}

class CGLocationConfiguration: NSObject {
    
    /// 使用定位的类型
    let locationAuthorizedModel : CGLocationModel
    
    /// 定位的精度
    let desiredAccuracyType : CGLocationAccuracyType
    
    /// 最小距离范围数据更新
    let distanceFilter : Double
    
    let activityType : CGLocationActivityType
    
    /// 忽略两CLLocation之间的距离，当在这个距离之内时停止解析后续CLLocation
    let ignoreLocationDistance : Double
    
    var desiredAccuracy : CLLocationAccuracy {
        
        let desiredAccuracy : CLLocationAccuracy
        switch desiredAccuracyType {
        case .bestForNavigation:
            desiredAccuracy = kCLLocationAccuracyBestForNavigation
        case .best:
            desiredAccuracy = kCLLocationAccuracyBest
        case .nearestTenMeters:
            desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        case .hundredMeters:
            desiredAccuracy = kCLLocationAccuracyHundredMeters
        case .kilometer:
            desiredAccuracy = kCLLocationAccuracyKilometer
        case .threeKilometers:
            desiredAccuracy = kCLLocationAccuracyThreeKilometers
        }
        return desiredAccuracy
    }
    
    var activityTypeForLocation : CLActivityType {
        
        let activityType : CLActivityType
        switch self.activityType {
        case .other:
            activityType = .other
        case .automotiveNavigation:
            activityType    = .automotiveNavigation
        case .fitness:
            activityType    = .fitness
        case .otherNavigation:
            activityType    = .otherNavigation
        }
        return activityType
    }
    
    init(locationAuthorizedModel: CGLocationModel, desiredAccuracyType: CGLocationAccuracyType, distanceFilter: Double, activityType : CGLocationActivityType, ignoreLocationDistance: Double) {
        
        self.locationAuthorizedModel    = locationAuthorizedModel
        self.desiredAccuracyType        = desiredAccuracyType
        self.distanceFilter             = distanceFilter
        self.activityType               = activityType
        self.ignoreLocationDistance     = ignoreLocationDistance
        
        super.init()
    }
    
    convenience override init() {
        self.init(locationAuthorizedModel: .authorizedWhenInUse, desiredAccuracyType: .best, distanceFilter: 1, activityType: .other, ignoreLocationDistance: 1)
    }
}
