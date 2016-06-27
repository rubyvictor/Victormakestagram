//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Victor Lee on 27/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse

class TimelineViewController: UIViewController {
    
    var photoTakingHelper: PhotoTakingHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tabBarController?.delegate = self
        
        
    }
}

    // MARK: Tab Bar Delegate
    
    extension TimelineViewController: UITabBarControllerDelegate {
        
        func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
            if (viewController is PhotoViewController) {
                takePhoto()
                return false
            } else {
                return true
            }
            
        }
        func takePhoto() {
            // instantiate photo taking class, provide callback for when photo is selected
            photoTakingHelper = PhotoTakingHelper(viewController: self.tabBarController!) { (image: UIImage?) in
                
                //this part of the code is the closure. whenever the photoTakingHelper has received an image, it will call this closure. It is a trailing closure, which is a closure outside of the class parantheses
                // don't do anything, yet...
            }
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


