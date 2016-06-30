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
    
    @IBOutlet weak var tableView: UITableView!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var posts : [Post] = []
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated
        )
        
        ParseHelper.timelineRequestForCurrentUser {
            (result: [PFObject]?, error: NSError?) -> Void in
            self.posts = result as? [Post] ?? []
            
            self.tableView.reloadData()
        }
       
        }
    
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
                
                let post = Post()
                post.image.value = image!
                post.uploadPost()
                    
                }
            
            }
        }
        
    extension TimelineViewController: UITableViewDataSource {
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return posts.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
            
            let post = posts[indexPath.row]
            //1
            post.downloadImage()
            // 2
            cell.post = post
            
            return cell
        
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


