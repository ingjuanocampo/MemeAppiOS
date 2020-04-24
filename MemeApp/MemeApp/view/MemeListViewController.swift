//
//  MemeListViewController.swift
//  MemeApp
//
//  Created by juan ocampo on 4/20/20.
//  Copyright © 2020 juan ocampo. All rights reserved.
//

import UIKit


class MemeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var memes:[Meme]? = nil
    private var memeRepository = ModuleDI.providesMemeRepository()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        memes = memeRepository.getAlll()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell", for: indexPath) as! MemeTableCell
        
        let meme = self.memes?[(indexPath as NSIndexPath).row]
        
        if let memeImage = meme?.originalImage {
            cell.memeImage?.image = memeImage
        }
        let memeText = (meme?.topText ?? "") + (meme?.bottomText ?? "")
        
        cell.memeText.text = memeText
        
        let topText = NSMutableAttributedString(string: meme?.topText ?? "", attributes: getMemeTextAttributes(true))
        cell.topText.attributedText = topText
        let bottomText = NSMutableAttributedString(string: meme?.bottomText ?? "", attributes: getMemeTextAttributes(true))
        cell.bottomText.attributedText = bottomText

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
