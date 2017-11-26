//
//  FullScreenAdaptiveLayout.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class FullScreenTwoColumnsAdaptiveLayout: UICollectionViewFlowLayout {
    private let collectionWidth = UIScreen.main.bounds.width
    private let baseMargin: CGFloat = 10
    private let baseScreenWidth: CGFloat = 320.0
    private let aspectRatio: CGFloat = 200/145
    
    override init() {
        super.init()
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        self.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.minimumLineSpacing = margin
        self.minimumInteritemSpacing = margin
        self.scrollDirection = .vertical
    }
}

extension FullScreenTwoColumnsAdaptiveLayout {
    private var itemWidth: CGFloat {
        return ((collectionWidth - (2 * margin) - interitemWidth) / 2).rounded(.down)
    }
    
    private var itemHeight: CGFloat {
        return (itemWidth * aspectRatio).rounded(.down)
    }
    
    private var margin: CGFloat {
        return (baseMargin * marginsRatio).rounded(.down)
    }
    
    private var interitemWidth: CGFloat {
        return (baseMargin * marginsRatio).rounded(.down)
    }
    
    private var marginsRatio: CGFloat {
        return collectionWidth / baseScreenWidth
    }
}
