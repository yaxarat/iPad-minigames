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
    //var allScores = [[ScoreTracker!]]
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func memoryBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender, "Memory")
    }
    @IBAction func sortingBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender, "Sorting")
    }
    @IBAction func balloonBtnPushed(_ sender: UIButton) {
        gameChoiceAction(sender, "Balloon")
    }
    @IBAction func easyBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender, "easy")
    }
    @IBAction func mediumBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender, "medium")
    }
    @IBAction func hardBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender, "hard")
    }
    @IBAction func playBtnPushed(_ sender: UIButton) {
        moveToGame(selectedGame.game!)
    }
    
    func gameChoiceAction(_ button: UIButton, _ game: String) {
        hideGameChosenOptions()
        showChosenOptions(button)
        selectedGame.game = game
        enableLevelOptions()
    }
    
    func levelChoiceAction(_ button: UIButton, _ level: String) {
        hideLevelChosenOption()
        showChosenOptions(button)
        selectedGame.difficulty = level
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
    
    func moveToGame(_ game: String){
        if game == "Memory" {
            performSegue(withIdentifier: "toMemoryGameVC", sender: self)
        } else if game == "Sorting" {
            performSegue(withIdentifier: "toSortingGameVC", sender: self)
        } else if game == "Balloon" {
            performSegue(withIdentifier: "toBalloonGameVC", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MemoryGameVC{
            destination.title = "Memory"
            destination.difficulty = selectedGame
            //destination.highScoreList = allScores
        }
        
//        if let destination = segue.destination as? SortingGameVC{
//            destination.title = "Sort The Vehicles"
//            destination.ourDifficulty = selectedGame
//            destination.highScoreList = ScoreTracker
//        }
//
//        if let destination = segue.destination as? BaloonGameVC{
//            destination.title = "Balloon Pop"
//            destination.ourDifficulty = selectedGame
//            destination.highScoreList = ScoreTracker
//        }
    }
    
}

