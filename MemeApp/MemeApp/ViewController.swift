//
//  ViewController.swift
//  MemeApp
//
//  Created by juan ocampo on 4/11/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField?
    @IBOutlet weak var bottomTextField: UITextField?
    var topDelegatetextField: TextDescriptionDelegate?
    var bottomDelegatetextField: TextDescriptionDelegate?
    let topDefaultText = "Top text"
    let bottomDefaultText = "Bottom text"
        
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth: 3.0
    ]

    @IBOutlet weak var imagePickerView: UIImageView?
    @IBOutlet weak var cameraButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topDelegatetextField = TextDescriptionDelegate(defaultText: topDefaultText)
        bottomDelegatetextField = TextDescriptionDelegate(defaultText: bottomDefaultText)

        topTextField?.delegate = topDelegatetextField
        topTextField?.text = topDefaultText
        topTextField?.isHidden = true
        topTextField?.defaultTextAttributes = memeTextAttributes

        bottomTextField?.delegate = bottomDelegatetextField
        bottomTextField?.text = bottomDefaultText
        bottomTextField?.isHidden = true
        bottomTextField?.defaultTextAttributes = memeTextAttributes
        
        cameraButton?.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }

    @IBAction func cameraSelected(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    // Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Choose the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        for key in info {
            if let image = key.value as? UIImage {
                imagePickerView?.image = image
                topTextField?.isHidden = false
                bottomTextField?.isHidden = false

            }
        }
        dismiss(animated: true, completion: nil)
    
    }
    
    func save() {
            // Create the meme
            let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
    }
    
   
    
    func generateMemedImage() -> UIImage {

        // TODO: Hide toolbar and navbar

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        // TODO: Show toolbar and navbar

        return memedImage
    }
    
    
    // Keyboard adjustments
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottomTextField?.isEditing == true {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if bottomTextField?.isEditing == true {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}

