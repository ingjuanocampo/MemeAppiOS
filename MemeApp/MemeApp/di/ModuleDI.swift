//
//  ModuleDI.swift
//  MemeApp
//
//  Created by juan ocampo on 4/19/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import Foundation


class ModuleDI {
    
    static var memeRepositoryInstance: MemeRepository? = nil
    
    static func providesMemeRepository() -> MemeRepository {
        if (memeRepositoryInstance == nil) {
            memeRepositoryInstance = CacheMemeRepository()
        }
        return memeRepositoryInstance!
    }
    
}
