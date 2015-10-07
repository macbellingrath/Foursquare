//
//  ProfileViewController.swift
//  Venues
//
//  Created by Mac Bellingrath on 10/7/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import SafariServices
import WebKit


let kSafariViewControllerCloseNotification = "kSafariViewControllerCloseNotification"

class ProfileViewController: UIViewController, UITextFieldDelegate, SFSafariViewControllerDelegate {
    
    
    var safariVC: SFSafariViewController?
    

    @IBAction func connectToFoursquareButtonPressed(sender: UIButton) {
      
        var safariVC: SFSafariViewController?
        let url = NSURL(string: "https://foursquare.com/oauth2/authenticate?client_id=" + CLIENT_ID + "&response_type=code&redirect_uri=venues://venues")
     
        if let login = url {
          
            print(login)
            
        
      
           safariVC = SFSafariViewController(URL: login)
          
            safariVC!.delegate = self
            
            presentViewController(safariVC!, animated: true, completion: nil)
            
            
        }
    
    
    }
    
    
    func safariLogin(notification: NSNotification) {
        let notifUrl = notification.object as! NSURL
        print("notifUrl: \(notifUrl)")
        let urlString = String(notifUrl)
        let code = extractCode(urlString)
        print("code: \(code)")
    
    }

    
    @IBOutlet weak var connectButton: UIButton! {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "safariLogin:", name: kSafariViewControllerCloseNotification, object: nil)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - SFSafariViewControllerDelegate Methods
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        
     controller.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    // MARK: - Utils
    
    func extractCode(urlString: String) -> String? {
        var code: String? = nil
        let url = NSURL(string: urlString)
        let urlQuery = (url?.query != nil) ? url?.query : urlString
        let components = urlQuery?.componentsSeparatedByString("&")
        for comp in components! {
            if (comp.rangeOfString("code=") != nil) {
                code = comp.componentsSeparatedByString("=").last
            }
        }
        return code
    }
    
    

    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
