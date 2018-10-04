//
//  homeFeedViewController.swift
//  instagram
//
//  Created by Robert Bolt on 10/2/18.
//  Copyright © 2018 Robert Bolt. All rights reserved.
//

import UIKit
import Parse

class homeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var posts: [Post] = []
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.current() will now be nil
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
    }
    
    @IBAction func onCamera(_ sender: Any) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! feedCell
        //cell.userImage.image = messagesArray[indexPath.row][""]
        //cell.chatMessage?.text = messagesArray[indexPath.row]["text"] as? String
        let post = self.posts[indexPath.row].media as PFFile
        /*if let user = posts[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.captionLabel.text = user.username
        } else {
            // No user found, set default username
            cell.captionLabel.text = "🤖"
        }*/
        return cell
    }
    
    func getPosts(){
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("media")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                // do something with the data fetched
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
                print(error?.localizedDescription)
            }
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
