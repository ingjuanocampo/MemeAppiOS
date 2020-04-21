//
//  CacheMemeRepository.swift
//  MemeApp
//
//  Created by juan ocampo on 4/19/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import Foundation

class CacheMemeRepository: MemeRepository {
    
    var memes = [Meme]()

    func getAlll() -> [Meme] {
        return memes
    }
    
    func append(_ meme: Meme) {
        memes.append(meme)
    }
}
