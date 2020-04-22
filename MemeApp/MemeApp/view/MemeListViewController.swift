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
      print("viewWillAppear")
    }
        
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewDidLoad() {
        print("viewDidLoad")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeViewCell")!
        let meme = self.memes?[(indexPath as NSIndexPath).row]
        
        if let memeImage = meme?.memeImage {
            cell.imageView?.image = memeImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
