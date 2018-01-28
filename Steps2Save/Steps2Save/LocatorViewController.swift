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
        "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSIsImtpZCI6Ino0NHdNZEh1OHdLc3VtcmJmYUs5OHF4czVZSSJ9.eyJhdWQiOiJodHRwczovL3dlZ21hbnMtZXMuYXp1cmUtYXBpLm5ldCIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0Zi8iLCJpYXQiOjE1MTcxMTU0NzgsIm5iZiI6MTUxNzExNTQ3OCwiZXhwIjoxNTE3MTE5Mzc4LCJhaW8iOiJZMk5nWVBnMUs4enFnSllsTy9mVHoyOVdYY2l3QXdBPSIsImFwcGlkIjoiMjQ5NjBkOTctNGZiZS00MzNkLWFiOGEtZWZlYjg5YWE1MjRlIiwiYXBwaWRhY3IiOiIxIiwiaWRwIjoiaHR0cHM6Ly9zdHMud2luZG93cy5uZXQvMTMxOGQ1N2YtNzU3Yi00NWIzLWIxYjAtOWIzYzM4NDI3NzRmLyIsIm9pZCI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInN1YiI6ImRlNTA1ODBiLWY3NTItNDIzMi05Y2I2LWI4OWE1ZDhjNGM3MCIsInRpZCI6IjEzMThkNTdmLTc1N2ItNDViMy1iMWIwLTliM2MzODQyNzc0ZiIsInV0aSI6IjliX1ZObHdiSzA2ZDBUQjVmODBSQUEiLCJ2ZXIiOiIxLjAifQ.fnC_h4aGFQxBNCmScVgfUZMnAUBnOXS1onQDbNRKydrUCzc3Xmg4ldXuqDd4cS638C12J-VjmLeZLzE3R9smEkxGDUXLZMOY-KGWlw4f3aMnE2W87BRg5t35sCiN8Ut9x1vZZ8AbnzC2r3XXKij6yF1Mu1jfbf4F6ekO4aQJuCwyVR-A1d5Iu65c6fA9feUTYwqMl-SZ3pHHTa_-79cPFOJ-NW8XqciI76bLPmpR6cLCctK8h3ij-asfEY5ZHOA7fQlrZgjkcnyUvHLXmfo-THgj3gsh5dGDKXXNCkTViA6XOpohig9UwNlbBj1NY24Yv9EKmtLN2Cf04OjDyAL0qg"
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
