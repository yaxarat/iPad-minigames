//
//  ViewController.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var memoryBtn: UIButton!
    @IBOutlet weak var sortingBtn: UIButton!
    @IBOutlet weak var balloonBtn: UIButton!
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    
    var selectedGame = GameSelector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func memoryBtnPushed(_ sender: Any) {
    }
    @IBAction func sortingBtnPushed(_ sender: Any) {
    }
    @IBAction func balloonBtnPushed(_ sender: Any) {
    }
    @IBAction func easyBtnPushed(_ sender: Any) {
    }
    @IBAction func mediumBtnPushed(_ sender: Any) {
    }
    @IBAction func hardBtnPushed(_ sender: Any) {
    }
    @IBAction func playBtnPushed(_ sender: Any) {
    }
}

