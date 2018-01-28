//
//  SecondViewController.swift
//  Steps2Save
//
//  Created by Sneha Vaswani on 1/27/18.
//  Copyright © 2018 Sneha Vaswani. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class LocatorViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager!
    let headers: HTTPHeaders = [
        "Location-Subscription-Key": "840dab19ea294013b18e515997c9395e",
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSIsImtpZCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSJ9.eyJhdWQiOiJodHRwczovL3dlZ21hbnMtZXMuYXp1cmUtYXBpLm5ldCIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0Zi8iLCJpYXQiOjE1MTcxNjM5MzMsIm5iZiI6MTUxNzE2MzkzMywiZXhwIjoxNTE3MTY3ODMzLCJhaW8iOiJZMk5nWUtoTHVpUVFzazF5M2d5dDY2M3VpNTA2QUE9PSIsImFwcGlkIjoiMjQ5NjBkOTctNGZiZS00MzNkLWFiOGEtZWZlYjg5YWE1MjRlIiwiYXBwaWRhY3IiOiIxIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvMTMxOGQ1N2YtNzU3Yi00NWIzLWIxYjAtOWIzYzM4NDI3NzRmLyIsIm9pZCI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInN1YiI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInRpZCI6IjEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0ZiIsInV0aSI6InFmN0s1RWEtX2tXZFNXZlQ0U01VQUEiLCJ2ZXIiOiIxLjAifQ.IfRKAMsurn5XXucuWkbDwVVPVp6JDnv4ERsfy9UG-NT4zCd8bJlPXMg6PDyVDWLI8RgZxDbSDlPV8ALtsiVZ9PM_tCPgDEHvydao-UHxidrcaeKEgqEBXJVtirYAObuamupWShKxTMTkPnEuVqAvo4KcnfacOeZMH6zaf7mFGSckxyVwzL6d8ugOLFbKcoXlYhXH3hxNT6wv4KyzpFKyQJXoTYIdOlGqrE_WHpAUtfQibrxUsMs7_sOOUXZdNTBaVSkompkd7zaRbAHV51CUB_qb5ihMXTFjF3k6_7IyhwyPSPv4eX9xiQiFQaguyVJnSSrR2_Cq2NIXGsgC793rRQ"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for user permission to access location infos
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        // Show the user current location
        map.showsUserLocation = true
        map.delegate = self
        
//        let parameters = [
//            "Client_id": "24960d97-4fbe-433d-ab8a-efeb89aa524e",
//            "Client_secret": "A8N7VeeCdFD5N4OxeQT1gFaXNStrxieEplYl3SYdxTs=",
//            "Grant_type": "client_credentials",
//            "Resource": "https://wegmans-es.azure-api.net"
//        ]
//        Alamofire.request("https://login.microsoftonline.com/1318d57f-757b-45b3-b1b0-9b3c3842774f/oauth2/token", method: .post, parameters: parameters, encoding: URLEncoding()).response { response in
//
//            print(response.response)
//            let json = JSON(response.response)
//            print(json)
//        }
        
        Alamofire.request("https://wegmans-es.azure-api.net/locationpublic/location/stores", headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let json = JSON(response.result.value!)
                    for store in json.array! {
                        let lat = CLLocationDegrees(store["Location"]["Latitude"].doubleValue)
                        let long = CLLocationDegrees(store["Location"]["Longitude"].stringValue)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long!)
                        annotation.title = "Wegmans"
                        self.map.addAnnotation(annotation)
                    }
                    let lat = CLLocationDegrees(43.083912)
                    let long = CLLocationDegrees(-77.67455)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    annotation.title = "Sam, Sneha, and George"
                    self.map.addAnnotation(annotation)
                case .failure(let _):
                    print("There was an error with the Wegmans API")
                }
        }
        
        
    }
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: self.map.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    
}
