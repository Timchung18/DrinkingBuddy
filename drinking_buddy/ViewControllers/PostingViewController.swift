//
//  PostingViewController.swift
//  drinking_buddy
//
//  Created by Timothy Cheung on 3/10/20.
//  Copyright © 2020 timothycheung80. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse
class PostingViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var orderField: UITextField!
    @IBOutlet weak var placeField: UITextField!
    @IBOutlet weak var costField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: today)
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPhotoButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        //let scaledImage = image.af_imageScaled(to: size)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        photoView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["order"] = orderField.text!
        post["place"] = placeField.text!
        post["cost"] = costField.text!
        post["date"] = dateLabel.text!
        post["author"] = PFUser.current()!
        let imageData = photoView.image!.pngData()!
        let file = PFFileObject(name: "image.png", data: imageData)
        post["image"] = file
        post.saveInBackground { (success, error) in
            if success {
                print("saved!")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error!")
            }
        }
        
        let orderPost = PFObject(className: "Orders")
        orderPost["order"] = orderField.text!
        orderPost["count"] = 1
        orderPost.saveInBackground { (success, error) in
            if success {
                print("saved")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error")
            }
        }
        
    }
}
