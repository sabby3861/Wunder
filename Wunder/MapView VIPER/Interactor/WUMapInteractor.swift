//
//  WUMapInteractor.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class WUMapInteractor: WUMapInteractorProtocol {
  var output: WUMapOutputProtocol?
  func formatAnnotations(placeMarks: [WUPlaceMark]) {
    let annotations = placeMarks.compactMap { WUAnnotation(json: $0) }
    output?.carInfoDidFetch(placeMarks: annotations)
  }
}
