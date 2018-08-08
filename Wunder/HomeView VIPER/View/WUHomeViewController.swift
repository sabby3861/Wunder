//
//  WUHomeViewController.swift
//  Wunder
//
//  Created by sanjay on 02/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import UIKit

class WUHomeViewController: UIViewController {
  var presenter: WUHomePresenterProtocol?
  var placeMarks: [WUPlaceMark] = [WUPlaceMark]()
  @IBOutlet weak var tableView: WUTableView!
  @IBOutlet weak var mapViewButton: UIBarButtonItem!
  var container: UIView!
  var loadingView: UIView!
  var actInd: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.title = "Car Info"
    showActivityIndicatory(uiView: self.view)
    self.presenter?.fetchCarInformation()
    tableView.addCellIdentifiers(["WUCarInfoCell"])
    tableView.delegate = self
    tableView.dataSource = self
    /*
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 220*/
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /// Push to MapView Contrroler
  ///
  /// - Parameter sender: navigation bar button object
  @IBAction func mapViewButtonClicked(_ sender: Any) {
    self.presenter?.showMapViewController(placeMarks: placeMarks)
  }
  
  func showActivityIndicatory(uiView: UIView) {
    container = UIView()
    container.frame = uiView.frame
    container.center = uiView.center
    container.backgroundColor = UIColor(white: 0.5, alpha: 0.3)//UIColor(hex: "0xffffff").withAlphaComponent( 0.3)
    loadingView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = uiView.center
    loadingView.backgroundColor = UIColor(white: 0.5, alpha: 0.7)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    actInd = UIActivityIndicatorView()
    actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
    actInd.activityIndicatorViewStyle =
      UIActivityIndicatorViewStyle.whiteLarge
    actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
    loadingView.addSubview(actInd)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    actInd.startAnimating()
  }
  
  func removeActivity() {
    actInd.stopAnimating()
    actInd.removeFromSuperview()
    loadingView.removeFromSuperview()
    container.removeFromSuperview()
  }
}





// MARK: - HomeView Protocol from Presenter Output to view communication
extension WUHomeViewController: WUHomeViewProtocol{
  func showCarInformation(with placeMarks: [WUPlaceMark]){
    self.placeMarks = placeMarks
    DispatchQueue.main.async {
      self.removeActivity()
      self.tableView.reloadData()
    }
  }
}



// MARK: - Extension for TableView DataSource
extension WUHomeViewController:UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return placeMarks.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "WUCarInfoCell", for: indexPath) as! WUCarInfoCell
    cell.displayData(data: placeMarks[indexPath.row])
    return cell
  }
}

// MARK: - Extension for TableView Delegate
extension WUHomeViewController:UITableViewDelegate{
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
    return UITableViewAutomaticDimension
  }
}
