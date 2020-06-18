//
//  MapView.swift
//  Mclytics
//
//  Created by Gunjan Raval on 15/06/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import MapKit

class MapView: MKMapView, MKMapViewDelegate,CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var lat : Double!
    var lng : Double!
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()
    var addressString : String = ""
    var  delegateApp: FormFieldsVC?
    var idString = ""

    func initDesign(latitude:Double,longitute:Double,str_id :String) {
        self.mapType = MKMapType.standard
        self.isZoomEnabled = true
        self.isScrollEnabled = true
        print(self.userLocation.coordinate)
        idString = str_id
        determineMyCurrentLocation()
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.3
        self.addGestureRecognizer(longPressRecogniser)
        
        if latitude != 0.0 && longitute != 0.0{
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitute)
            getAddressFromLatLon(pdblLatitude: latitude, withLongitude: longitute)
            lat = annotation.coordinate.latitude
            lng = annotation.coordinate.longitude
            if let delegate = self.delegateApp {
                delegate.getLatlongFormMAP(lat: lat, long: lng, str_id: idString)
            }
            self.addAnnotation(annotation)
            centerMapOnLocation(location: annotation.coordinate)
        }
    }
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
    }
    //---------------------------------------
    //MARK:- Gesture Method
    //---------------------------------------
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }
        
        let touchPoint = gestureRecognizer.location(in: self)
        let touchMapCoordinate = self.convert(touchPoint, toCoordinateFrom: self)
        annotation.coordinate = CLLocationCoordinate2D(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
        getAddressFromLatLon(pdblLatitude: touchMapCoordinate.latitude, withLongitude: touchMapCoordinate.longitude)
        lat = annotation.coordinate.latitude
        lng = annotation.coordinate.longitude

        if let delegate = self.delegateApp {
            delegate.getLatlongFormMAP(lat: lat, long: lng, str_id: idString)
        }
        self.addAnnotation(annotation)
        centerMapOnLocation(location: annotation.coordinate)

    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D){
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView!.rightCalloutAccessoryView = btn
        } else {
            annotationView!.annotation = annotation
        }
        
  
        return annotationView
    }
    
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        lat = userLocation.coordinate.latitude
        lng = userLocation.coordinate.longitude
        
        self.showsUserLocation = true


    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
 
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        lat = pdblLatitude
        lng = pdblLongitude
        addressString = ""
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = pdblLatitude
        center.longitude = pdblLongitude
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil){
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                    return
                }
                let pm = placemarks! as [CLPlacemark]
                if pm.count > 0 {
                    let pm = placemarks![0]
                    print(pm)
                    if pm.subThoroughfare != nil {
                        self.addressString = self.addressString + pm.subThoroughfare! + ", "
                    }
                    if pm.thoroughfare != nil {
                        self.addressString = self.addressString + pm.thoroughfare! + ", "
                    }
                    if pm.subLocality != nil {
                        self.addressString = self.addressString + pm.subLocality! + ", "
                    }
                    if pm.locality != nil {
                        self.addressString = self.addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        self.addressString = self.addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        self.addressString = self.addressString + pm.postalCode! + " "
                    }
                    UserDefaults.standard.set(self.addressString, forKey: "Address")
                    print(self.addressString)
                    self.annotation.title = self.addressString
                }
        })
    }

}
