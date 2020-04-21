//
//  MemeRepository.swift
//  MemeApp
//
//  Created by juan ocampo on 4/19/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import Foundation

protocol MemeRepository {
    
    func getAlll() -> [Meme]
    
    func append(_ meme: Meme)

}
