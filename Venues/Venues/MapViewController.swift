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
            
        }
    }
    
    var locationManager = CLLocationManager() {
      
        didSet {
            
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
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
                        
                    }
                }
            }
            
        }
    }
  
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
       
        print(error)
    }
    
    
    
    //MARK: - MapView
    
//    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//    
//        
////        configure annotation
//        
//       let annotation =  mapView.dequeueReusableAnnotationViewWithIdentifier("Pin")
//    
//        if annotation == nil {
//            annotation = MKPointAnnotation()
//        
//        }
//        
//    }
    

    

//    
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    

}
