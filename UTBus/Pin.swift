//
//  Pin.swift
//  UTBus
//
//  Created by Rodolfo Martinez on 2015-06-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    let title: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
}