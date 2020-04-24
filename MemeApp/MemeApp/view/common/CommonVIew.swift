//
//  CommonVIew.swift
//  MemeApp
//
//  Created by juan ocampo on 4/22/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit




func getMemeTextAttributes(_ forPreview: Bool = false) -> [NSAttributedString.Key: Any] {
    var sizeMeme :Float = 40
    if forPreview {
        sizeMeme = 20
    }
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: CGFloat(sizeMeme))!,
        NSAttributedString.Key.strokeWidth: -3.0
    ]
    
    return memeTextAttributes
    
}
