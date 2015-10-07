//
//  MapViewController.swift
//  Venues
//
//  Created by Mac Bellingrath on 10/6/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate {
    
    
    var location: CLLocation?
    

    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            
            mapView.delegate = self
            mapView.showsUserLocation = true
            
            
        }
    }
    
    var locationManager: CLLocationManager! {
      
        didSet {
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager = CLLocationManager()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "presentSearchEntryView")

        // Do any additional setup after loading the view.
    }
    
    
    //present alertcontroller to get query string
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func searchForVenue(withQuery venue: String, andLocation location: CLLocation) {
        
        Request.session().query = venue
        Request.session().getVenuesWithLocation(location) {}
        
        //
    }

    
    //MARK: - Search Bar Delegate Methods
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("ended")
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //thanks jo 
        if let searchText = searchBar.text, let location = location {

            searchForVenue(withQuery: searchText, andLocation: location)
            
            print(searchText, location)
        }
    }
    
    
    //MARK: - Location Manager
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        if let location = locations.first {
            
            Request.session().getVenuesWithLocation(location) {
                
                var _annotations = [MKAnnotation]()
            
                // add annotations to mv
                for venue in Request.session().venues {
                    
                   
                    
                    if let locationInfo = venue["location"] as? Dict {
                        
                        let lat = locationInfo["lat"] as? Double ?? 0
                        let lng = locationInfo["lng"] as? Double ?? 0
                        
                        
                        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                       
                        let title = venue["name"] as? String
                        
                        
                        let annotion = MKPointAnnotation()
                        
                        annotion.coordinate = coord
                        annotion.title = title
    
                    
                        self.mapView.addAnnotation(annotion)
                        _annotations.append(annotion)
                        
                    }
                }
                self.mapView.showAnnotations(_annotations, animated: true)
            }
        
        }
        
    }
  
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
       
        print(error)
    }
    
    
    
    //MARK: - MapView
    
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("Pin")
//        
//        if annotationView == nil {
//            annotationView?.image =
//            
//            
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//            annotationView
////            annotationView?.leftCalloutAccessoryView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
////            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
////            imageView.image = UIImage(named: "swift")
////            annotationView?.leftCalloutAccessoryView = imageView
//            
//            
//            
//            
//            
//        }
//        
//        
//        let button = UIButton(type: .DetailDisclosure)
//       
//        button.addTarget(self, action: "showVenueDetail", forControlEvents: .TouchUpInside)
//        
//        
//        annotationView?.rightCalloutAccessoryView = button
//        
//        return annotationView
//
//        
//    }
    
    
    //MARK: - Segue
    
    func showVenueDetail() {
        print("ShowVenueDetail Tapped")
    }
    

}
