//
//  ViewController.swift
//  Practise Memorable Places
//
//  Created by Mohamed Salah Zidane on 7/31/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    @IBOutlet weak var map: MKMapView!
    var Manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
        if activePlaces == -1{
            Manager.delegate = self
            Manager.desiredAccuracy = kCLLocationAccuracyBest
            Manager.requestWhenInUseAuthorization()
            Manager.startUpdatingLocation()
            
        }else {
            if places.count > activePlaces {
                if let name = places[activePlaces]["name"] {
                    if let lat = places[activePlaces]["lat"]{
                        if let long = places[activePlaces]["long"]{
                            if let latitude = Double(lat){
                                if let longitude = Double(long){
                                    let coordinates = CLLocationCoordinate2D (latitude: latitude, longitude: longitude)
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let region = MKCoordinateRegion (center: coordinates, span: span)
                                    self.map.setRegion(region, animated: false)
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinates
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @objc func longPress(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.began{
            let touchPoint = gestureRecognizer.location(in: self.map)
            let newCoordinates = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            let location = CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude)
            var title = ""
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                
                if error != nil{
                    print(error!)
                }else {
                    if let placemark = placemarks?[0]{
                        if placemark.country != nil {
                            title += placemark.country! + ","
                        }
                        if placemark.subLocality != nil {
                            title  += placemark.subLocality! + ","
                        }
                        if placemark.administrativeArea != nil {
                            title += placemark.administrativeArea! + ","
                        }
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        
                    }
                }
                if title == ""{
                    title = "Added \(NSData())"
                }
                let annotation = MKPointAnnotation()
                annotation.coordinate = newCoordinates
                annotation.title = title
                self.map.addAnnotation(annotation)
                places.append(["name": title, "lat" : String(newCoordinates.latitude),"long": String(newCoordinates.longitude)])
                UserDefaults.standard.set(places, forKey: "places")
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        self.map.setRegion(region, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

