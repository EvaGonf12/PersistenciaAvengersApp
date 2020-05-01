//
//  PowerPopupViewController.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 29/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
import PopupDialog

enum StarState: String {
    case Empty = "star"
    case Fill = "star.fill"
}

class PowerPopupViewController: UIViewController {

    
    var stateStar0: StarState = .Empty
    var stateStar1: StarState = .Empty
    var stateStar2: StarState = .Empty
    var stateStar3: StarState = .Empty
    var stateStar4: StarState = .Empty
    
    var power : Int?
    
    @IBOutlet weak var star0: UIButton!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    
    convenience init(power: Int) {
        self.init()
        self.power = power
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
        
    func updateUI() {
        guard let power = self.power else { return }
        stateStar0 = power > 0 ? .Fill : .Empty
        stateStar1 = power > 1 ? .Fill : .Empty
        stateStar2 = power > 2 ? .Fill : .Empty
        stateStar3 = power > 3 ? .Fill : .Empty
        stateStar4 = power > 4 ? .Fill : .Empty
        
        star0.setImage(UIImage(systemName: stateStar0.rawValue), for: .normal)
        star1.setImage(UIImage(systemName: stateStar1.rawValue), for: .normal)
        star2.setImage(UIImage(systemName: stateStar2.rawValue), for: .normal)
        star3.setImage(UIImage(systemName: stateStar3.rawValue), for: .normal)
        star4.setImage(UIImage(systemName: stateStar4.rawValue), for: .normal)
    }
    
    @IBAction func starAction(_ sender: UIButton) {
        self.power = (self.power == 1 && sender.tag == 1) ? -1 : sender.tag
        self.updateUI()
    }

}
