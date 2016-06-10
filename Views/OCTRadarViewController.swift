//
//  RadarViewController.swift
//  ZhaiClans
//
//  Created by yuhan zhang on 1/23/16.
//  Copyright © 2016 Octopus. All rights reserved.
//

import UIKit

class OCTRadarViewController: UIViewController, BMKLocationServiceDelegate, BMKRadarManagerDelegate, BMKMapViewDelegate, OCTTopBarViewDelegate {
    var nearbyInfos: [AnyObject]!
    
    var service: BMKLocationService!
    
    var mapView: BMKMapView!
    
    
    var currentLocation = CLLocationCoordinate2D()
    
    var option: BMKRadarNearbySearchOption!
    
    var manager: BMKRadarManager!
    
    
    var searchButton: UIButton?
    
    
    override func viewDidLoad() {

        service = BMKLocationService()
        service.delegate = self
        
        nearbyInfos = []

        
        configTopBar()
        configMapView()
        configManager()
    }
    
    
    private func configTopBar() {
        let topbar = OCTTopBarView(style: TopBarStyle.Dark).configTitleLabel("地图").configLeftButton()
        topbar.delegate = self
        self.view.addSubview(topbar)
    }
    
    
    
    func configMapView() {
        mapView = BMKMapView(frame: CGRect(x: 0, y: 64, width: OCTScreenWidth, height: OCTScreenHeight - 64))
        mapView.zoomEnabled = true
        mapView.zoomLevel = 17
        
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollow
        mapView.showsUserLocation = true
        
        let displayParam = BMKLocationViewDisplayParam()
        displayParam.isAccuracyCircleShow = false
        mapView.updateLocationViewWithParam(displayParam)
        

        self.view.addSubview(mapView)

    }
    
    
    func configManager() {
        manager = BMKRadarManager.getRadarManagerInstance()
        manager.addRadarManagerDelegate(self)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        mapView.viewWillAppear()
        mapView.delegate = self
        manager.startAutoUpload(5)
        service.startUserLocationService()
//
//        mapView.showsUserLocation = false
//        mapView.userTrackingMode = BMKUserTrackingModeFollow
//        mapView.showsUserLocation = true
//        
//        let displayParam = BMKLocationViewDisplayParam()
//        displayParam.isAccuracyCircleShow = false
//        mapView.updateLocationViewWithParam(displayParam)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        mapView.viewWillDisappear()
        mapView.delegate = nil
        service.stopUserLocationService()
        manager.removeRadarManagerDelegate(self)
        manager.stopAutoUpload()
    }
    
    
    
    func configBackground() {
        self.view.backgroundColor = AppBackgroundColor
    }
    
    
    
    func didFailToLocateUserWithError(error: NSError!) {
        Logger.debug("did fail to locate user")
        Logger.debug("\(error)")
    }
    
    
    
    func addSearchButton() -> UIButton {
        if self.searchButton == nil {
            searchButton = UIButton()
            searchButton?.addTarget(self, action: "didClickSearchButton", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return self.searchButton!
    }
    
    
    func didClickSearch() {
        
        mapView.showsUserLocation = false
        mapView.userTrackingMode = BMKUserTrackingModeFollow
        mapView.showsUserLocation = true
        
        option = BMKRadarNearbySearchOption()
        option.radius = 100
        option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR
        option.centerPt = currentLocation
        
        
        let res = manager.getRadarNearbySearchRequest(option)
        if res {
            Logger.debug("succeed")
        } else {
            Logger.debug("failed")
            
        }
        
    }
    
    
    
    func getRadarAutoUploadInfo() -> BMKRadarUploadInfo! {
        let info = BMKRadarUploadInfo()
        
        Logger.info("\(currentLocation)")
        
//        lock.lock()
        info.extInfo = "MyName"
        info.pt = currentLocation
//        lock.unlock()
    
        return info
    }
    
    
    func onGetRadarNearbySearchResult(result: BMKRadarNearbyResult!, error: BMKRadarErrorCode) {
        if error == BMK_RADAR_NO_ERROR {
            nearbyInfos = result.infoList
            
            var annotations = [AnyObject]()
            
            for info in nearbyInfos {
                let annotation = BMKPointAnnotation()
                annotation.coordinate = info.pt
                annotation.title = info.userId
                annotation.subtitle = info.extInfo
                annotations.append(annotation)
            }
            
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
            
        } else {
            Logger.debug("\(error)")
        }
    }
    
    
    
    func didUpdateUserHeading(userLocation: BMKUserLocation!) {
        mapView.updateLocationData(userLocation)
    }
    
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        currentLocation.latitude = userLocation.location.coordinate.latitude
        currentLocation.longitude = userLocation.location.coordinate.longitude
        print(currentLocation)
        
        mapView.updateLocationData(userLocation)
        
//        let annotation = BMKPointAnnotation()
//        
//        annotation.coordinate = userLocation.location.coordinate
//        annotation.title = "李卫天"
//        mapView.addAnnotation(annotation)
//        mapView.showAnnotations([annotation], animated: true)
    }
    
    
    
    deinit {
        Logger.debug("deinit")
    }
    
}



