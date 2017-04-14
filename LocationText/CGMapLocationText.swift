//
//  CGMapLocationText.swift
//  CGTestMapManager
//
//  Created by DY on 2017/4/6.
//  Copyright © 2017年 -. All rights reserved.
//

import UIKit

extension String {
    func map_locationString() -> String {
        return self.locationString(value: nil, table: "CGMapLocationText")
    }
}

extension String {
    
    func locationString() -> String {
        return self.locationString(value: nil)
    }
    
    func locationString(value: String?) -> String {
        return self.locationString(value: value, table: nil)
    }
    
    func locationString(value: String?, table: String?) -> String {
        return Bundle.main.localizedString(forKey: self, value: value, table: table)
    }
}
