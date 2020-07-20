//
//  ImagesTableView.swift
//  Pixabay
//
//  Created by Erik Mai on 20/7/20.
//  Copyright © 2020 Erik Mai. All rights reserved.
//

import UIKit

class ImagesTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var images: [PixabayImage] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
           
        }
    }
    
    let cellName = ImagesTableViewCell.reuseIdentifierString
    
    init() {
        super.init(frame: .zero, style: .grouped)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        let nib = UINib(nibName: "ImagesTableViewCell", bundle: nil)
        register(nib, forCellReuseIdentifier: cellName)
        backgroundColor = .white
        dataSource = self
        delegate = self
        separatorStyle = .none
        showsVerticalScrollIndicator = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? ImagesTableViewCell {
            let image = images[indexPath.row]
            cell.setImage(image)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
