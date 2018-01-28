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
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSIsImtpZCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSJ9.eyJhdWQiOiJodHRwczovL3dlZ21hbnMtZXMuYXp1cmUtYXBpLm5ldCIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0Zi8iLCJpYXQiOjE1MTcxMjQ2NjksIm5iZiI6MTUxNzEyNDY2OSwiZXhwIjoxNTE3MTI4NTY5LCJhaW8iOiJZMk5nWU9qVFpMcnBsaml6T2x1c3ovU2I2YXB2QUE9PSIsImFwcGlkIjoiMjQ5NjBkOTctNGZiZS00MzNkLWFiOGEtZWZlYjg5YWE1MjRlIiwiYXBwaWRhY3IiOiIxIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvMTMxOGQ1N2YtNzU3Yi00NWIzLWIxYjAtOWIzYzM4NDI3NzRmLyIsIm9pZCI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInN1YiI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInRpZCI6IjEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0ZiIsInV0aSI6IkxUVXFRUlM0aUU2OThEWUoweGdkQUEiLCJ2ZXIiOiIxLjAifQ.Kp8e47E4BieMXLwUVDPzH7hMSqc-k9ewcZSnDAUXnQiRlOg2B5VySeYJtRJH475SC0F3LZY8yt4UTbO88tPVJEPNISspRmhhJxKsXNBDOCGnwozRnddcRCYmUh8leDhlsAYXDzIANoyC2LRym2-Jj3wHZdaCUHFlenxuSbegNf80C3h8XzzGnjYyVe5ldF2-pvwOk0lJj9MkUm3lCWb3W_xcs3d_sgPU1vSS3GGq-v11a7XZDYE-5rsfOJkwPuZ6_tvirgm1MuaAiWxQxTY8jNxXLR-CVwBKZP7lL6S6Mz2Fhj47lDtqhJzq-xRa78AKhKuAMSaBoNpgCXCXZWLcjg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for user permission to access location infos
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        // Show the user current location
        map.showsUserLocation = true
        map.delegate = self
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
