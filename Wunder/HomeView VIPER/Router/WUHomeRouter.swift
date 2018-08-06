//
//  WUHomeRouter.swift
//  Wunder
//
//  Created by sanjay on 02/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation

class WUHomeRouter: WUHomeRouterProtocol {
  static func assembleModule(view: WUHomeViewController){
    let presenter = WUHomePresenter()
    let router = WUHomeRouter()
    let interactor = WUSHomeInteractor()
    presenter.view = view
    presenter.interactor = interactor
    presenter.router = router
    
    interactor.output = presenter
    view.presenter = presenter
    //router.viewController = view
  }
}
