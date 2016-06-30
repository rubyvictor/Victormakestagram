//
//  PostTableViewCell.swift
//  Makestagram
//
//  Created by Victor Lee on 29/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import UIKit
import Bond


class PostTableViewCell : UITableViewCell {
    var post: Post? {
        didSet {
            //1
            if let post = post {
                //2
                //bind the image of the post to the 'postImage' view
                post.image.bindTo(postImageView.bnd_image)
                
            }
        }
    }
    
    
    @IBOutlet weak var postImageView: UIImageView!
    

}





