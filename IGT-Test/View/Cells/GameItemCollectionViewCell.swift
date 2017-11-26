//
//  GameItemCollectionViewCell.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol CollectioItemViewModel {
    var itemTitle: String {get}
}

class GameItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with viewModel: CollectioItemViewModel) {
        titleLabel.text = viewModel.itemTitle
    }
}
