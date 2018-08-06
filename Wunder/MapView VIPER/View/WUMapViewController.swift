//
//  WUMapViewController.swift
//  Wunder
//
//  Created by sanjay on 05/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit
import MapKit

class WUMapViewController: UIViewController, WUMapViewProtocol {
  var presenter: WUMapPresenterProtocol?
  let locationManager = CLLocationManager()
  var jsonData: [WUPlaceMark]?
  var annotations: [WUAnnotation] = []
  
  func showPinsOverMap(with placeMarks: [WUAnnotation]) {
    print("Annotations are \(placeMarks)")
    annotations = placeMarks
  }
  
  
  @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    requestLocationAccess()
    presenter?.intializeAnnotations(placeMarks: jsonData!)
    mapView.register(WUAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    mapView.addAnnotations(annotations)
    //mapView.layoutMargins = UIEdgeInsets(top: 10, right: 10, bottom: 10, left: 10)
    mapView.layoutMargins = UIEdgeInsetsMake(10, 10, 10, 10)
    mapView.showAnnotations(mapView.annotations, animated: true)
  }
  
  
  @IBAction func mapSegmentClicked(_ sender: Any) {
    let segment = sender as? UISegmentedControl
    if segment?.selectedSegmentIndex == 0 {
      mapView.mapType = .standard
    } else if segment?.selectedSegmentIndex == 1 {
      mapView.mapType = .satellite
    }else{
      mapView.mapType = .hybrid
    }
  }
  /// Location Manager authorization check
  func requestLocationAccess() {
    let status = CLLocationManager.authorizationStatus()
    
    switch status {
    case .authorizedAlways, .authorizedWhenInUse:
      mapView.showsUserLocation = true
      return
      
    case .denied, .restricted:
      print("location access denied")
      WUAlertViewController.showAlert(withTitle: "Wunder",message: "In order to use the application, please enabe to location service for the WeSerVite", buttons: ["No", "Open Settings"], delegate: self)

    default:
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  
  /// Open Setting App
  ///
  /// - Parameter title: String to check for the button pressed
  func openLocationSettings(title: String) {
    guard title != "No" else {
      return
    }
    if !CLLocationManager.locationServicesEnabled() {
      if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
        // If general location settings are disabled then open general location settings
        UIApplication.shared.open(url, completionHandler: nil)
      }
    } else {
      if let url = URL(string: UIApplicationOpenSettingsURLString) {
        // If general location settings are enabled then open location settings for the app
        UIApplication.shared.open(url, completionHandler: nil)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
}

extension WUMapViewController: MKMapViewDelegate{
 
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    // get the particular pin that was tapped
    let pinToZoomOn = view.annotation
    // optionally you can set your own boundaries of the zoom
    let span = MKCoordinateSpanMake(0.2, 0.2)
    // or use the current map zoom and just center the map
    // let span = mapView.region.span
    // now move the map
    let region = MKCoordinateRegion(center: pinToZoomOn!.coordinate, span: span)
    mapView.region.center = (pinToZoomOn?.coordinate)!
    mapView.setRegion(region, animated: true)
    hideUnhideAnnotations(hide: pinToZoomOn)
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    let location = view.annotation as! WUAnnotation
    mapView.deselectAnnotation(location, animated: true)
    hideUnhideAnnotations(unHide: false)
  }
  
  
  /// HideUnhide Annotations
  ///
  /// - Parameters:
  ///   - selectedAnnotation: selected annotation to keep visible
  ///   - unHide: Bool value to make sure if annotation needs to unhide for other views
  func hideUnhideAnnotations(hide selectedAnnotation: MKAnnotation? = nil, unHide: Bool = true) {
    let _ = mapView.annotations.compactMap { annotation in
      if annotation.isEqual(selectedAnnotation){
        self.mapView.view(for: annotation)?.isHidden = false
        print("Called hidden")
      }else{
        self.mapView.view(for: annotation)?.isHidden = unHide
      }
    }
    mapView.fitAllAnnotations(shouldZoom: unHide)
  }
  
}

extension MKMapView {
  func fitAllAnnotations(shouldZoom: Bool) {
    guard shouldZoom == false else {
      return
    }
    var zoomRect = MKMapRectNull;
    for annotation in annotations {
      let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
      let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
      zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(20, 20, 20, 20), animated: true)
  }
}


// MARK: - AlertView Delegate/ to open settings in case of location access is not there
extension WUMapViewController: WUAlertDelegate{
  func alert(buttonClickedIndex:Int, buttonTitle: String, tag: Int){
    openLocationSettings(title: buttonTitle)
  }
}

