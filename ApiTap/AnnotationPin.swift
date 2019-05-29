//
//  AnnotationPin.swift
//  ApiTap
//
//  Created by appzorro on 4/12/18.
//  Copyright © 2018 ApiTap. All rights reserved.
//

import MapKit

class AnnotationPin:NSObject,MKAnnotation{
    var title:String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String,subtitle:String,coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
