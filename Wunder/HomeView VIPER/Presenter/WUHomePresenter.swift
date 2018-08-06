//
//  WUHomePresenter.swift
//  Wunder
//
//  Created by sanjay on 03/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class WUHomePresenter: WUHomePresenterProtocol {
  var view: WUHomeViewProtocol?
  var router: WUHomeRouterProtocol?
  var interactor: WUHomeInteractorProtocol?
  
  func fetchCarInformation(){
    interactor?.decodeJSONInformation()
  }
  
}


// MARK: - Presenter to view communication
extension WUHomePresenter:WUHomeOutputProtocol{

  func carInfoDidFetch(placeMarks: [WUPlaceMark]){
    view?.showCarInformation(with: placeMarks)
  }
}
