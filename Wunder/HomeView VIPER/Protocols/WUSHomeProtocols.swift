//
//  WUSHomeProtocols.swift
//  Wunder
//
//  Created by sanjay on 03/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation


/// View Protocols
protocol WUHomeViewProtocol: class
{
  var presenter: WUHomePresenterProtocol? { get set }
  func showCarInformation(with placeMarks: [WUPlaceMark])
}

/// View -> Interactor and View -> Router Communication Protocols
protocol WUHomePresenterProtocol: class
{
  var view: WUHomeViewProtocol? { get set }
  var router: WUHomeRouterProtocol? { get set }
  var interactor: WUHomeInteractorProtocol?{get set}
  func fetchCarInformation()
}


/// Interactor -> Presenter Communication Protocols
protocol WUHomeInteractorProtocol: class
{
  var output: WUHomeOutputProtocol? { get set }
  func decodeJSONInformation()
}

protocol WUHomeOutputProtocol: class
{
  func carInfoDidFetch(placeMarks: [WUPlaceMark])
}

/// Router Protocols and assembling Module
protocol WUHomeRouterProtocol: class
{
  static func assembleModule(view: WUHomeViewController)
}
