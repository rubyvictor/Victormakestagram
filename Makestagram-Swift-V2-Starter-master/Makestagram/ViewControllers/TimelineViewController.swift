//
//  TimelineViewController.swift
//  Makestagram
//
//  Created by Victor Lee on 27/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import Parse
import ConvenienceKit



class TimelineViewController: UIViewController, TimelineComponentTarget {
    
    @IBOutlet weak var tableView: UITableView!
    
    var timelineComponent: TimelineComponent<Post, TimelineViewController>!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var posts : [Post] = []
    
    //add two properties for timeLineComponent
    //TimelineComponent that we want the timeline to initially show the newest 5 posts (index 0 to 4). When the user reaches the end of the timeline, we load an additional 5. 
    let defaultRange = 0...4
    let additionalRangeSize = 5
    
    func loadInRange(range: Range<Int>, completionBlock: ([Post]?) -> Void) {
        // 1
        ParseHelper.timelineRequestForCurrentUser(range) { (result: [PFObject]?, error: NSError?) -> Void in
            // 2
            let posts = result as? [Post] ?? []
            // 3
            completionBlock(posts)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        timelineComponent.loadInitialIfRequired()
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            // extend viewDidLoad method to initialise timelinecomponent
        timelineComponent = TimelineComponent(target: self)
            
        self.tabBarController?.delegate = self
        
        
    }
    
}

extension TimelineViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        timelineComponent.targetWillDisplayEntry(indexPath.row)
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
        return timelineComponent.content.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
            
            
            //updated method for timelinecomponent
            let post = timelineComponent.content[indexPath.row]
            //1
            post.downloadImage()
            
            //add loading likes lazily by extending this func
            post.fetchLikes()
            
            
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


