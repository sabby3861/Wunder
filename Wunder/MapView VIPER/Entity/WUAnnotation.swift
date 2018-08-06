//
//  WUAnnotation.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import MapKit

class WUAnnotation: NSObject, MKAnnotation {
  let title: String?
  let locationName: String
  let coordinate: CLLocationCoordinate2D
  var identifier = "car location"
  
  init?(json: WUPlaceMark?) {
    self.title = json?.name
    self.locationName = (json?.address)!
    if let latitude = json?.coordinates.first,
      let longitude = json?.coordinates[1] {
      self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    } else {
      self.coordinate = CLLocationCoordinate2D()
    }
  }
  
  var subtitle: String? {
    return locationName
  }
  var imageName: String? {
    return "Car"
  }
}
