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
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSIsImtpZCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSJ9.eyJhdWQiOiJodHRwczovL3dlZ21hbnMtZXMuYXp1cmUtYXBpLm5ldCIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0Zi8iLCJpYXQiOjE1MTcxNTEzMTUsIm5iZiI6MTUxNzE1MTMxNSwiZXhwIjoxNTE3MTU1MjE1LCJhaW8iOiJZMk5nWVBBK29tTXFZZks1dzF6T3B5L3lxc3dIQUE9PSIsImFwcGlkIjoiMjQ5NjBkOTctNGZiZS00MzNkLWFiOGEtZWZlYjg5YWE1MjRlIiwiYXBwaWRhY3IiOiIxIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvMTMxOGQ1N2YtNzU3Yi00NWIzLWIxYjAtOWIzYzM4NDI3NzRmLyIsIm9pZCI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInN1YiI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInRpZCI6IjEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0ZiIsInV0aSI6IjJpTEltMmRGRGttNXNsZHRBMk1nQUEiLCJ2ZXIiOiIxLjAifQ.MklN8qMXJ6azqORprPmy0IdmCp0uVxfpTgUjv6f3aftT7Dv2LyyAcVovbPz56ZsUveot-dtzCddOWcnOQn-Siq-U8NDi5kc2TFsGnABsTG-rKuNzlhwo3Dc3tbnRZuOgygenqdJPrzOJpLhJPw9vQg1KTdV0TqJny2o6UDU2f7MsTpnxFPiGdtzL3uYaWLxFf4uOBFHC0gP_LsN8lqQA3vMhF-gKY7dLaVy8ennvAt4uvnueQf9wWb8n40ILN8E6GqJJHdHu3UExH2-t4hNJLu0dFLpAvvtTHzI1DdL6EsZzl8Pu2t6n2vQy6EbmBk37pU7SCl6_LLeBb6ktcZ69rQ"
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
