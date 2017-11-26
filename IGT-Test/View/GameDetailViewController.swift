//
//  GameDetailViewController.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol GameDetailViewModel {
    var gameName: String {get}
    var gameJackpot: String {get}
}

class GameDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBountyLabel: UILabel!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var gameJackpotLabel: UILabel!
    
    var presenter: GameDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
}

extension GameDetailViewController: GameDetailView {
    func configure(with viewModel: GameDetailViewModel) {
        gameNameLabel.text = viewModel.gameName
        gameJackpotLabel.text = viewModel.gameJackpot
    }
}
