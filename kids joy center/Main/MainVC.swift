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
    
    let highScoreView = UIView(frame: CGRect(x: 300, y: 100, width: 400, height: 600))
    let highScoreExit = UIButton(frame: CGRect(x: 20, y: 560, width: 60, height: 30))
    var memoryHighScores = [ScoreTracker](repeatElement(ScoreTracker(gameType: "Memory", score: 0), count: 5))
    var sortingHighScores = [ScoreTracker](repeatElement(ScoreTracker(gameType: "Sort", score: 0), count: 5))
    var balloonHighScores = [ScoreTracker](repeatElement(ScoreTracker(gameType: "Balloon",score: 0), count: 5))
    var selectedGame = GameSelector()
    var allScores: [[ScoreTracker]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHighScore()
    }
    
    // For highscore button
    @IBAction func displayScores(_ sender: UIBarButtonItem) {
        if !highScoreView.isDescendant(of: self.view){
            LoadHighScore()
        }
    }
    
    // Loads highscore pop up
    func setupHighScore() {
        allScores = [memoryHighScores, sortingHighScores, balloonHighScores]
        
        if let readAllScores = UserDefaults.standard.object(forKey: "allScores") as? Data {
            allScores = NSKeyedUnarchiver.unarchiveObject(with: readAllScores) as! [[ScoreTracker]]
        } else {
            setHighScore()
        }
    }
    
    // Opens highscore pop up
    func LoadHighScore() {
        highScoreView.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 0.9)
        self.view.addSubview(highScoreView)
        
        highScoreExit.setTitle("Back", for: .normal)
        highScoreExit.setTitleColor(UIColor.white, for: .normal)
        highScoreExit.addTarget(self, action: #selector(closeHighScore(sender:)), for: .touchUpInside)
        highScoreView.addSubview(highScoreExit)
        highScoreView.addSubview(entry(message: "High Scores:", yCoordinate: 30))
        highScoreView.addSubview(entry(message: "Memory Game", yCoordinate: 60))
        highScoreView.addSubview(entry(message: "Sorting Game", yCoordinate: 230))
        highScoreView.addSubview(entry(message: "Balloon Game", yCoordinate: 410))
        
        // Shows scores
        displayScore(gameType: 0, Location: 85, view: highScoreView)
        displayScore(gameType: 1, Location: 255, view: highScoreView)
        displayScore(gameType: 2, Location: 435, view: highScoreView)
    }
    
    // Closes highscore pop up
    @objc func closeHighScore(sender: UIButton) {
        highScoreView.removeFromSuperview()
    }
    
    // Display function for the score presentation
    func displayScore(gameType: Int, Location: Int, view: UIView) {
        for i in 0..<5 {
            let currentScore = String(describing: allScores[gameType][i].score)
            view.addSubview(entry(message:currentScore, yCoordinate: Location + (i*30)))
        }
    }
    
    // Writes the score entries
    func entry(message: String, yCoordinate: Int) -> UILabel {
        let highscoreEntry = UILabel(frame: CGRect(x: 100, y: yCoordinate, width: 200, height: 30))
        highscoreEntry.textAlignment = .center
        highscoreEntry.textColor = UIColor.white
        highscoreEntry.text = message
        return highscoreEntry
    }
    
    // Highscore inputs
    func setHighScore() {
        for i in 0..<allScores.count {
            for j in 0..<allScores[i].count{
                if i == 0 {
                    let newHS = ScoreTracker(gameType: "Memory", score: 0)
                    allScores[i][j] = newHS
                    update()
                } else if i == 1 {
                    let newHS = ScoreTracker(gameType: "Sort", score: 0)
                    allScores[i][j] = newHS
                    update()
                } else if i == 2 {
                    let newHS = ScoreTracker(gameType: "Balloon", score: 0)
                    allScores[i][j] = newHS
                    update()
                }
            }
        }
        showTable()
        
    }
    
    func showTable() {
        for i in 0..<allScores.count {
            for j in 0..<allScores[i].count{
                print(allScores[i][j].game)
                print("\(allScores[i][j].score)")
            }
        }
    }
    
    func update(){
        let highScoreData = NSKeyedArchiver.archivedData(withRootObject: allScores)
        UserDefaults.standard.set(highScoreData, forKey: "allScores")
        UserDefaults.standard.synchronize()
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: "allScores")
        UserDefaults.standard.synchronize()
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
        levelChoiceAction(sender, "Easy")
    }
    @IBAction func mediumBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender, "Medium")
    }
    @IBAction func hardBtnPushed(_ sender: UIButton) {
        levelChoiceAction(sender, "Hard")
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
            destination.highScoreList = allScores
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

