//
//  WUSHomeInteractor.swift
//  Wunder
//
//  Created by sanjay on 03/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
class WUSHomeInteractor: WUHomeInteractorProtocol {
  var output: WUHomeOutputProtocol?
  
  func decodeJSONInformation(){
    let parser = WUJSONParser()
    let service = WUCarInfo()
    parser.request(resource: service.carInfoService) { [unowned self] result in
      print("Resul Is \(result)")
      switch result {
      case .success(let data):
        print("Data is \(data)")
        self.output?.carInfoDidFetch(placeMarks: data.placemarks)
      case .failure(let missing):
        let error = missing.localizedDescription
        print("Description  \(error)")
        WUAlertViewController.showAlert(withTitle: "Error", message:  String(describing: missing))
      }
    }
  }
}
