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
  var presenter: WUHomePresenterProtocol? { get }
  func showCarInformation(with placeMarks: [WUPlaceMark])
}

/// View -> Interactor and View -> Router Communication Protocols
protocol WUHomePresenterProtocol: class
{
  var view: WUHomeViewProtocol? { get }
  var router: WUHomeRouterProtocol? { get }
  var interactor: WUHomeInteractorProtocol?{get}
  func fetchCarInformation()
  func showMapViewController(placeMarks: [WUPlaceMark])
}


/// Interactor -> Presenter Communication Protocols
protocol WUHomeInteractorProtocol: class
{
  var output: WUHomeOutputProtocol? { get }
  func decodeJSONInformation()
}

protocol WUHomeOutputProtocol: class
{
  func carInfoDidFetch(placeMarks: [WUPlaceMark])
}

/// Router Protocols and assembling Module
protocol WUHomeRouterProtocol: class
{
  var viewController: WUHomeViewController?{get}
  static func assembleModule(view: WUHomeViewController)
  func pushToMapView(placeMarks: [WUPlaceMark])
}
