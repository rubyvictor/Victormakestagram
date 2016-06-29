//
//  Post.swift
//  Makestagram
//
//  Created by Victor Lee on 28/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Parse

//1
class Post : PFObject, PFSubclassing {
    var image: UIImage?
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: PFUser?
    
    //MARK: PFSubclassing protocol
    
    //3
    static func parseClassName() -> String {
        return "Post"
    }
    
    override init() {
        super.init()
    }
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            //inform Parse about this subclass
            self.registerSubclass()
        }
    }
    
    
    func uploadPost() {
    
        
        
        if let image = image {
            //1
            guard let imageData = UIImageJPEGRepresentation(image, 0.8) else {return}
            guard let imageFile = PFFile(name: "image.jpg", data: imageData) else {return}
            
            //2
            user = PFUser.currentUser()
            
            self.imageFile = imageFile
            
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            
            }
            
            
                saveInBackgroundWithBlock() { (success: Bool, error: NSError?) in
                    UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            
        }
    }
    
}
}