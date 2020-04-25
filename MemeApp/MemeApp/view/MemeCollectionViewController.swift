//
//  MemeCollectionViewController.swift
//  MemeApp
//
//  Created by juan ocampo on 4/20/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var memes:[Meme]? = nil
    private var memeRepository = ModuleDI.providesMemeRepository()
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        memes = memeRepository.getAlll()
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        let space:CGFloat = 3.0
           let dimension = (view.frame.size.width - (2 * space)) / 3.0

           flowLayout.minimumInteritemSpacing = space
           flowLayout.minimumLineSpacing = space
           flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        let meme = memes?[indexPath.row]
        cell.image?.image = meme?.originalImage
        
        let topText = NSMutableAttributedString(string: meme?.topText ?? "", attributes: getMemeTextAttributes(true))
        cell.topText.attributedText = topText
        let bottomText = NSMutableAttributedString(string: meme?.bottomText ?? "", attributes: getMemeTextAttributes(true))
        cell.bottomText.attributedText = bottomText
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeSelected = memes?[indexPath.row]
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        controller.memeToEdit = memeSelected
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
