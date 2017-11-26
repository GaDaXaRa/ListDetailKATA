//
//  GamesListViewController.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: GamesListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollection()
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    private func setUpCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GamesListViewController: GamesListView {
    func reload() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GamesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numGames()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCollectionViewCell", for: indexPath) as! GameItemCollectionViewCell
        cell.configure(with: presenter.game(at: indexPath))
        return cell
    }
}

extension GamesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath)
    }
}
