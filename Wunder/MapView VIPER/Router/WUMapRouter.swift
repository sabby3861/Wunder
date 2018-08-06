//
//  WUMapRouter.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
import UIKit
class WUMapRouter: WUMapRouterProtocol {
  static func assembleModule(placeMarks: [WUPlaceMark]) -> WUMapViewController{
    let storyboard = UIStoryboard.storyboard(storyboard: .Main)
    let view: WUMapViewController = storyboard.instantiateVieController()
    view.jsonData = placeMarks
    let presenter = WUMapPresenter()
    let router = WUMapRouter()
    let interactor = WUMapInteractor()
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.output = presenter
    view.presenter = presenter
    //router.viewController = view
    return view
  }
}
