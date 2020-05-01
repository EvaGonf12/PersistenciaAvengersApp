//
//  VillainDetailViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
import PopupDialog

class VillainDetailViewController: UIViewController {

    @IBOutlet weak var vImage: UIImageView!
    @IBOutlet weak var vPower: UIImageView!
    @IBOutlet weak var vPowerEditButton: UIButton!
    @IBOutlet weak var vDescription: UITextView!
    @IBOutlet weak var carouselView: UIView!
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        return cv
    }()
    
    var viewModel: VillainDetailViewModel? {
        didSet { self.viewModel?.viewWasLoaded() }
    }

    convenience init(viewModel: VillainDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.viewWasLoaded()
        
        // Carousel
        collectionView.backgroundColor = UIColor.init(named: Colors.WhiteBg.rawValue)
        carouselView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: carouselView.topAnchor),
            collectionView.leftAnchor
                .constraint(equalTo: carouselView.leftAnchor),
            collectionView.rightAnchor
            .constraint(equalTo: carouselView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: carouselView.bottomAnchor)
        ])
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
        self.viewModel?.backButtonTapped()
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        // Create a custom view controller
        let startsVC = PowerPopupViewController(power: self.viewModel?.villainPower ?? 0)
        
        // Create the dialog
        let popup = PopupDialog(viewController: startsVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: true,
                                panGestureDismissal: false)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCELAR", height: 60) {
            print("CANCELAR")
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "CAMBIAR", height: 60) {
            guard let power = startsVC.power else { return }
            self.viewModel?.changePower(newPower: power)
        }
        
        buttonOne.layer.cornerRadius = 8
        buttonTwo.layer.cornerRadius = 8
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }

}

extension VillainDetailViewController: VillainDetailViewDelegate {
    
    func villainDetailFetched() {
        self.vImage.image = UIImage.init(named: self.viewModel?.villainImage ?? "img_hero_default")
        self.vPower.image = UIImage.init(named: self.viewModel?.villainPowerImg ?? "img_hero_default")
        self.vDescription.text = self.viewModel?.villainDescription
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
}

extension VillainDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.villainBattles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        cell.color = Colors.Primary
        cell.title = self.viewModel?.villainBattles?[indexPath.row]
        return cell
    }
}
