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
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSIsImtpZCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSJ9.eyJhdWQiOiJodHRwczovL3dlZ21hbnMtZXMuYXp1cmUtYXBpLm5ldCIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0Zi8iLCJpYXQiOjE1MTcxMjk3NTIsIm5iZiI6MTUxNzEyOTc1MiwiZXhwIjoxNTE3MTMzNjUyLCJhaW8iOiJZMk5nWUxndlZ2WXhUdEpOZjVuNnY4QXJYeDNZQUE9PSIsImFwcGlkIjoiMjQ5NjBkOTctNGZiZS00MzNkLWFiOGEtZWZlYjg5YWE1MjRlIiwiYXBwaWRhY3IiOiIxIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvMTMxOGQ1N2YtNzU3Yi00NWIzLWIxYjAtOWIzYzM4NDI3NzRmLyIsIm9pZCI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInN1YiI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInRpZCI6IjEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0ZiIsInV0aSI6IlNEcUtuNTZpeGtpSkJ4Ujh0eHdmQUEiLCJ2ZXIiOiIxLjAifQ.On6u4s6DKXOF_JL6TF3JW0b1T9E73t7q8a_SqzNTDh85oMcfzliPXLzXPCF3luZ2Z1uVKRPhgUDgSGD-oN31x5pjl4u-JAdjc6NhUprW2XdSFMXILP_jweLjofVHB6sTDlPKhXD4R8V_-7prKWvl9iZW6fF2hXZUkiWhwb3PKWEiAeMPHNbEO_HxoYoM8b1hgpWCvBs7zVgT9BHsXIEA9JF38omeB3EAJxZPs3gfXyq26ur1hzRyGuuffD3iYLXt0WMTIPrH92SZZXr-YVtSwivo6XXAyp9LkiQsvR3B9jz26y949CjPgo8tetrLGwcmdzwkO7ASISyqIfPjY6vZ5g"
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
