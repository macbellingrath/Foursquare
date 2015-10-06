//
//  Request.swift
//  Venues
//
//  Created by Mac Bellingrath on 10/6/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import CoreLocation

typealias Dict = [String : AnyObject]

//private let _singleton = Request()
private let _singleton = Request()
private let API_URL = "https://api.foursquare.com/v2/venues/search?"



class Request: NSObject {


    //Basic approach to return singleton
    class func session() -> Request {
       
        return _singleton
    
    }
    
    var venues: [Dict] = []
    
    var query: String = "Sushi"
    
//    lazy var config = NSURLSessionConfiguration.defaultSessionConfiguration()
//    lazy var session = NSURLSession(configuration: self.config)
    

    

    func getVenuesWithLocation(location: CLLocation, withCompletion completion: () -> ()) {
    
        let urlString = API_URL + "client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET + "&v=20130815" + "&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)" + "&query=" + query
        
        if let url = NSURL(string: urlString) {
            
            let request = NSMutableURLRequest(URL: url)
            
            request.HTTPMethod = "GET"
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                
                ( data,  response,  error) in
                
                if let data = data {
                
                   if let resultInfo = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? Dict {
                    
                    if let responseInfo = resultInfo?["response"] as? Dict {
                       
                        self.venues = responseInfo["venues"] as? [Dict] ?? []
                        
                        print(self.venues)
                    
                        dispatch_async(dispatch_get_main_queue()) {  completion() }
                        
                     
                       
                        
                                }
                            }
                        }
                    }
            
                    task.resume()
            
            }
    
    }
}


    
    
    
      
    
    
    
    



//class NetworkOperation {
//    
//    var objects = [[String:String]]()
//    
//    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
//    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
//    let queryURL: NSURL
//    
//    typealias JSONDictionaryCompletion = ([String: AnyObject]? -> Void)
//    
//    init(url: NSURL) {
//        self.queryURL = url
//    }
//    
//    func downloadJSONFromURL(completion: JSONDictionaryCompletion) throws {
//        
//        let request = NSURLRequest(URL: queryURL)
//        let dataTask = session.dataTaskWithRequest(request) {
//            (let data, let response, let error) in
//            
//            // 1. Check HTTP response for successful GET request
//            if let httpResponse = response as? NSHTTPURLResponse {
//                switch(httpResponse.statusCode) {
//                case 200:
//                    // 2. Create JSON object with data
//                    let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
//                    completion(jsonDictionary)
//                default:
//                    print("GET request not successful. HTTP status code: \(httpResponse.statusCode)")
//                }
//            } else {
//                print("Error: Not a valid HTTP response")
//            }
//            
//        }
//        
//        dataTask.resume()
//    }
//}

