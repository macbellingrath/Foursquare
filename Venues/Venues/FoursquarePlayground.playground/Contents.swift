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


private let API_URL = "https://api.foursquare.com/v2/venues/search?"
private let CLIENT_ID = "2TRR152OKMAQKZP2WQ5H2GXISAFJ3C1GOJJXD1VB0QOMFMAN"
private let CLIENT_SECRET = "GAIN0DUEJUFOAEOAAD1VUI2B214P0F3DXHASHNRUUZGZZYGS"


class Request: NSObject {
    
 
    //Basic approach to return singleton
    class func session() -> Request {
        
        return _singleton
        
    }
    
    var venues: [Dict] = []
    
    var query: String = "sushi"
    
    //    lazy var config = NSURLSessionConfiguration.defaultSessionConfiguration()
    //    lazy var session = NSURLSession(configuration: self.config)
    
    
    
    
    func getVenuesWithLocation(location: CLLocation) {
        
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
                            
                        }
                    }
                }
            }
        }
    }
}

let _singleton = Request()

_singleton.getVenuesWithLocation(CLLocation(latitude: 100, longitude: 100))













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

