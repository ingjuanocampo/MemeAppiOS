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
    @IBOutlet weak var imagePickerView: UIImageView?
    
    @IBOutlet weak var cameraButton: UIButton?
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var toolbar: UIToolbar?
    @IBOutlet weak var clearBotton: UIButton?
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topDelegatetextField = TextDescriptionDelegate(defaultText: topDefaultText)
        bottomDelegatetextField = TextDescriptionDelegate(defaultText: bottomDefaultText)

        topTextField?.delegate = topDelegatetextField
        topTextField?.text = topDefaultText
        topTextField?.isHidden = true
        topTextField?.defaultTextAttributes = memeTextAttributes
        
        shareButton?.isEnabled = false
        clearBotton?.isEnabled = false

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
    
    @IBAction func shareSelected(_ sender: Any) {
        saveAndShare()
    }
    
    @IBAction func clearSelected(_ sender: Any) {
        clearView()
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    // Cancel Image selector
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Choose the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        for key in info {
            if let image = key.value as? UIImage {
                imagePickerView?.image = image
                enableTextFields(enable: true)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func enableTextFields(enable: Bool) {
        topTextField?.isHidden = !enable
        bottomTextField?.isHidden = !enable
        shareButton?.isEnabled = enable
        clearBotton?.isEnabled = enable
    }
    
    func saveAndShare() {
        if let image = imagePickerView?.image {
            let meme = Meme(topText: topTextField?.text ?? "", bottomText: bottomTextField?.text ?? "", originalImage: image)
            toggleViewsVisibility(isHidden: true)
            let controller = UIActivityViewController(activityItems: [meme.generateMemedImage(view: self.view)], applicationActivities: nil)
            controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
                if completed {
                    self.clearView()
                }
            }
            
            toggleViewsVisibility(isHidden: false)
            present(controller, animated: true, completion: nil)
        }
    }
    
    private func toggleViewsVisibility(isHidden: Bool) {
        shareButton?.isHidden = isHidden
        toolbar?.isHidden = isHidden
        clearBotton?.isHidden = isHidden
    }
    
    private func clearView() {
        topTextField?.text = topDefaultText
        bottomTextField?.text = bottomDefaultText
        imagePickerView?.image = nil
        enableTextFields(enable: false)
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
        if bottomTextField?.isEditing == true && view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
