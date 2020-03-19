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
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
    }
}
