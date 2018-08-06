//
//  WUMapPresenter.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class WUMapPresenter: WUMapPresenterProtocol {
  var view: WUMapViewProtocol?
  
  var router: WUMapRouterProtocol?
  
  var interactor: WUMapInteractorProtocol?
  
  func intializeAnnotations(placeMarks: [WUPlaceMark]){
    interactor?.formatAnnotations(placeMarks: placeMarks)
  }
}

// MARK: - Presenter to view communication
extension WUMapPresenter: WUMapOutputProtocol{
  func carInfoDidFetch(placeMarks: [WUAnnotation]) {
    view?.showPinsOverMap(with: placeMarks)
  }
  
  
}
