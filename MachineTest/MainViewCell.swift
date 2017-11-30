//
//  MovieViewCell.swift
//  MachineTest
//
//  Created by Ashin Asok on 29/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import UIKit

class MainViewCell: UITableViewCell {

    
    @IBOutlet var header: UILabel!
    @IBOutlet var collectionViewOutlet: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension MainViewCell{
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDelegate & UICollectionViewDataSource> (_ dataSourceDelegate: D , forRow row: Int)
    {
        collectionViewOutlet.delegate = dataSourceDelegate
        collectionViewOutlet.dataSource = dataSourceDelegate
        collectionViewOutlet.tag = row
        collectionViewOutlet.reloadData()
    }
}
