//
//  RootWireframe.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class RootWireframe: NSObject {
    fileprivate var navigationController: UINavigationController!
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    override init() {
        super.init()
        self.navigationController = UINavigationController(rootViewController: GamesDependencies.gamesListViewController(wireframe: self))
    }
}

extension RootWireframe: GamesWireframe {
    func openDetail(with game: GameItem, user: User?) {
        navigationController.pushViewController(GamesDependencies.gameDetailViewController(for: game, user: user), animated: true)
    }    
}
