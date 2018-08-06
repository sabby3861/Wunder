//
//  WUAnnotationView.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import MapKit

class WUAnnotationView: MKAnnotationView{
  override var annotation: MKAnnotation? {
    willSet {
      guard let artwork = newValue as? WUAnnotation else {return}
      
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      /*
      let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                              size: CGSize(width: 30, height: 30)))
      mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
      rightCalloutAccessoryView = mapsButton
      */
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      
      if let imageName = artwork.imageName {
        image = UIImage(named: imageName)
      } else {
        image = nil
      }
      
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = artwork.subtitle
      detailCalloutAccessoryView = detailLabel
    }
  }

}
