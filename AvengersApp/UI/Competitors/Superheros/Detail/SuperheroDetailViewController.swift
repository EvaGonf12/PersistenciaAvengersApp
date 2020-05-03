//
//  SuperheroDetailViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 27/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
import PopupDialog

class SuperheroDetailViewController: UIViewController {

    @IBOutlet weak var shImage: UIImageView!
    @IBOutlet weak var shPower: UIImageView!
    @IBOutlet weak var shPowerEditButton: UIButton!
    @IBOutlet weak var shDescription: UITextView!
    @IBOutlet weak var carouserView: UIView!
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: "CarouselCollectionViewCell")
        return cv
    }()
    
    var viewModel: SuperheroDetailViewModel? {
        didSet { self.viewModel?.viewWasLoaded() }
    }

    convenience init(viewModel: SuperheroDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel?.viewWasLoaded()
        
        // Carousel
        collectionView.backgroundColor = UIColor.init(named: Colors.WhiteBg.rawValue)
        carouserView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: carouserView.topAnchor),
            collectionView.leftAnchor
                .constraint(equalTo: carouserView.leftAnchor),
            collectionView.rightAnchor
            .constraint(equalTo: carouserView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: carouserView.bottomAnchor)
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
        let startsVC = PowerPopupViewController(power: self.viewModel?.superheroPower ?? 0)
        
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

extension SuperheroDetailViewController: SuperheroDetailViewDelegate {
    func superheroDetailFetched() {
        self.shImage.image = UIImage.init(named: self.viewModel?.superheroImage ?? "img_hero_default")
        self.shPower.image = UIImage.init(named: self.viewModel?.superheroPowerImg ?? "img_hero_default")
        self.shDescription.text = self.viewModel?.superheroDescription
    }
    
    func reloadData() {
        self.viewDidLoad()
    }
}

extension SuperheroDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 30)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.superheroBattles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell,
           let cellViewModel = self.viewModel?.superheroBattles?[indexPath.row],
           let winner = cellViewModel.winner {
            
            cell.title = cellViewModel.name
            cell.color = WinnerEnum(rawValue: winner) == .Superhero ? Colors.Win : Colors.Lost
            return cell
        }
        fatalError()
    }
}
