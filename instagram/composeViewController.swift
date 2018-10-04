//
//  composeViewController.swift
//  instagram
//
//  Created by Robert Bolt on 10/2/18.
//  Copyright © 2018 Robert Bolt. All rights reserved.
//

import UIKit

class composeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var tapGesture = UITapGestureRecognizer()
    @IBOutlet weak var captionText: UITextField!
    @IBOutlet weak var imagePicker: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(composeViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        imagePicker.addGestureRecognizer(tapGesture)
        imagePicker.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func onShare(_ sender: Any) {
        Post.postUserImage(image: imagePicker.image, withCaption: captionText.text, withCompletion: nil)
         self.performSegue(withIdentifier: "homeSegue", sender: nil)
    }
    
    @IBAction func onCancell(_ sender: Any) {
        self.performSegue(withIdentifier: "homeSegue", sender: nil)
    }
    
/*    func resize(image: UIImage, newSize: CGSize) -> UIImage {
       let resizeImageView = UIImageView(frame: CGRect(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }*/
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        imagePicker.image = editedImage
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
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
