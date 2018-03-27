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
    
    @IBAction func memoryBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender)
    }
    @IBAction func sortingBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender)
    }
    @IBAction func balloonBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender)
    }
    @IBAction func easyBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender)
    }
    @IBAction func mediumBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender)
    }
    @IBAction func hardBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender)
    }
    @IBAction func playBtnPushed(_ sender: UIButton) {
    }
    
    func gameChoiceAction(_ button: UIButton) {
        hideGameChosenOptions()
        showChosenOptions(button)
        enableLevelOptions()
    }
    
    func levelChoiceAction(_ button: UIButton) {
        hideLevelChosenOption()
        showChosenOptions(button)
        enablePlayButton()
    }
    
    func enableLevelOptions() {
        easyBtn.isEnabled = true
        mediumBtn.isEnabled = true
        hardBtn.isEnabled = true
    }
    
    func enablePlayButton() {
        playBtn.isEnabled = true
    }
    
    func showChosenOptions(_ button: UIButton) {
        button.alpha = 1.0
        enableLevelOptions()
    }
    
    func hideGameChosenOptions() {
        memoryBtn.alpha = 0.5
        sortingBtn.alpha = 0.5
        balloonBtn.alpha = 0.5
    }
    func hideLevelChosenOption() {
        easyBtn.alpha = 0.5
        mediumBtn.alpha = 0.5
        hardBtn.alpha = 0.5
    }
    
}

