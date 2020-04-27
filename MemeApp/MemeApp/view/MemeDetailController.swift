//
//  MemeDetailController.swift
//  MemeApp
//
//  Created by juan ocampo on 4/26/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//


import UIKit


class MemeDetailController: UIViewController {

    var meme: Meme? = nil
       
    @IBOutlet weak var memeImage: UIImageView!

    override func viewDidLoad() {
     memeImage?.image = meme?.memeImage
    }

}
