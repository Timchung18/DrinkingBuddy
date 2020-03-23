//
//  ProfileViewController.swift
//  drinking_buddy
//
//  Created by Timothy Cheung on 3/10/20.
//  Copyright © 2020 timothycheung80. All rights reserved.
//

import UIKit
import Parse
class ProfileViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        var postslist = [PFObject]()
        usernameLabel.text = user?.username
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                postslist = posts!
            }
        }
        var str = String(postslist.count)
        var str1 = "You have had " + str + "drink(s)"
        countLabel.text = str1

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
