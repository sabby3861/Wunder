//
//  WUMapProtocols.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
/// VIPER Architecture Impplementation

/// View Protocols
protocol WUMapViewProtocol: class
{
  var presenter: WUMapPresenterProtocol? { get set }
  func showPinsOverMap(with placeMarks: [WUAnnotation])
}

/// View -> Interactor and View -> Router Communication Protocols
protocol WUMapPresenterProtocol: class
{
  var view: WUMapViewProtocol? { get set }
  var router: WUMapRouterProtocol? { get set }
  var interactor: WUMapInteractorProtocol?{get set}
  func intializeAnnotations(placeMarks: [WUPlaceMark])
}


/// Interactor -> Presenter Communication Protocols
protocol WUMapInteractorProtocol: class
{
  var output: WUMapOutputProtocol? { get set }
  func formatAnnotations(placeMarks: [WUPlaceMark])
}

protocol WUMapOutputProtocol: class
{
  func carInfoDidFetch(placeMarks: [WUAnnotation])
}

/// Router Protocols and assembling Module
protocol WUMapRouterProtocol: class
{
  static func assembleModule(placeMarks: [WUPlaceMark]) -> WUMapViewController
}
