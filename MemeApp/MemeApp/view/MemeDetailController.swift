//
//  MemeDetailController.swift
//  MemeApp
//
//  Created by juan ocampo on 4/23/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit


class MemeDetailController: UIViewController {
    
    
    var meme: Meme? = nil
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    
    
    override func viewDidLoad() {
        memeImage?.image = meme?.originalImage
        topLabel?.defaultTextAttributes = getMemeTextAttributes()
        
        topLabel?.text = meme?.topText
        
        
        bottomLabel?.defaultTextAttributes = getMemeTextAttributes()
        

        
    }
    
    
}
