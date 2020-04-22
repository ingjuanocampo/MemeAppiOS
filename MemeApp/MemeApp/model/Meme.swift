//
//  Meme.swift
//  MemeApp
//
//  Created by juan ocampo on 4/12/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit

//topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage
struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    var memeImage: UIImage? = nil
    
    init(topText: String, bottomText: String, originalImage: UIImage) {
        self.bottomText = bottomText
        self.topText = topText
        self.originalImage = originalImage
    }
    
    mutating func generateMemedImage(view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        self.memeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
                
        return self.memeImage ?? UIImage()
    }
}
