//
//  Meme.swift
//  MemeApp
//
//  Created by juan ocampo on 4/12/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit

//topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage
class Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage) {
        self.bottomText = bottomText
        self.topText = topText
        self.originalImage = originalImage
    }
    
    
    func generateMemedImage(view: UIView) -> UIImage {
        
        // TODO: Hide toolbar and navbar
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return memedImage
    }
}
