//
//  SortingGameVC.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class SortingGameVC: UIViewController {

    let seconds = UIImageView(frame: CGRect(x: 200, y: 720, width: 20, height: 30))
    let seconds1 = UIImageView(frame: CGRect(x: 230, y: 720, width: 20, height: 30))
    let minutes = UIImageView(frame: CGRect(x: 160, y: 720, width: 20, height: 30))
    let scoreImg = UIImageView(frame: CGRect(x: 950, y: 720, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x: 975, y: 720, width: 20, height: 30))
    let airRegion = UIView(frame: CGRect(x:0, y:130, width: 1024, height: 320))
    let seaRegion = UIView(frame: CGRect(x: 0, y:450, width: 750, height:130))
    let seaRegion1 = UIView(frame: CGRect(x: 0, y:630, width: 500, height:130))
    let landRegion = UIView(frame: CGRect(x: 750, y:450, width: 300, height:150))
    let landRegion1 = UIView(frame: CGRect(x: 500, y:630, width: 530, height:150))

    var imagePath = [UIPanGestureRecognizer]()
    var thisDifficulty = GameSelector()
    var solvedVehicle: [Bool]!
    var originalLocations = [CGPoint]()
    var getVehicles = Vehicles(difficulty: "")
    var vehicleImage: UIImage!
    var timer = Time(seconds: 0)
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[ScoreTracker]]!
    var tempScore: [ScoreTracker]!

    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }

    func startGame() {
        tempScore = highScoreList[1]
        getVehicles = Vehicles(difficulty: thisDifficulty.difficulty!)
        self.imagePath = [UIPanGestureRecognizer](repeatElement(UIPanGestureRecognizer(target: self, action: #selector(pathfinder)), count: getVehicles.allArray.count))
        solvedVehicle = [Bool](repeatElement(false, count: getVehicles.allArray.count))
        allSetupProcess()
    }

    func allSetupProcess() {
        // Timers
        timer = setUpTimer()
        timer.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SortingGameVC.updateTimeUI)), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SortingGameVC.updateScoreTime)), userInfo: nil, repeats: true)

        // Gesture
        for i in 0..<getVehicles.allArray.count {
            imagePath[i] = UIPanGestureRecognizer(target: self, action: #selector(pathfinder))
        }

        // backGround
        let background = UIImageView(frame: CGRect(x: 0, y: 75, width: 1024, height: 693))
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named:"air-land-water")
        self.view.addSubview(background)
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 150))
        bar.backgroundColor = UIColor(red: 90/255, green: 90/255, blue: 90/255, alpha: 1)
        self.view.addSubview(bar)

        timeUI()
    }

    func setUpTimer() -> Time {
        var thisTime: Time
        if thisDifficulty.difficulty == "Easy"{
            thisTime = Time(seconds: 60)
        } else if thisDifficulty.difficulty == "Medium"{
            thisTime = Time(seconds: 45)
        } else {
            thisTime = Time(seconds:30)
        }
        return thisTime
    }

    @objc func updateTimeUI() {
        if timer.seconds > 0{
            timer.updateImages(time: TimeInterval(timer.seconds))
            minutes.image = timer.minutesImg
            seconds.image = timer.secondsImg
            seconds1.image = timer.seconds1Img

            timer.seconds -= 1
        } else {
            timer.updateImages(time: TimeInterval(timer.seconds))
            seconds1.image = timer.seconds1Img
            timer.timer.invalidate()
            loss()
        }
    }

    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
    }

    @objc func pathfinder(_ sender: UIPanGestureRecognizer) {

        let imageView = sender.view!

        switch sender.state {
        case .began, .changed:
            moving(view: imageView, sender: sender)
        case .ended:
            checkRegion(view: imageView, sender: sender)
        default:
            break
        }
    }

    func moving(view: UIView, sender: UIPanGestureRecognizer) {
        let point = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }

    func returnAnimation(index: Int, view: UIView) {
        UIView.animate(withDuration: 2, animations: {
            view.frame.origin = self.originalLocations[index]})
    }

    func checkRegion(view: UIView, sender: UIPanGestureRecognizer) {
        for i in 0 ..< imagePath.count {
            if imagePath[i] == sender {
                if getVehicles.allArray[i].isAir {
                    if view.frame.intersects(airRegion.frame) {
                        solved(index: i)
                    } else {
                        unsolved(index: i)
                        returnAnimation(index: i, view: view)
                    }
                } else if getVehicles.allArray[i].isWater {
                    if view.frame.intersects(seaRegion.frame) || view.frame.intersects(seaRegion1.frame) {
                        solved(index: i)
                    } else {
                        unsolved(index: i)
                        returnAnimation(index: i, view: view)
                    }
                } else if getVehicles.allArray[i].isLand {
                    if view.frame.intersects(landRegion.frame) || view.frame.intersects(landRegion1.frame){
                        solved(index: i)
                    } else {
                        unsolved(index: i)
                        returnAnimation(index: i, view: view)
                    }
                }
            }
        }
    }

    func solved(index: Int) {
        if !solvedVehicle[index] {
            solvedVehicle[index] = true
            scoreCalculation()
            updateScoreUI()
            allSolved()
        } else {
            return
        }
    }

    func scoreCalculation(){
        if scoreSeconds <= 2 {
            finalScore += 5
        } else if scoreSeconds <= 4 && scoreSeconds > 2 {
            finalScore += 4
        } else {
            finalScore += 3
        }
        scoreSeconds = 0
    }

    func unsolved(index: Int) {
        if solvedVehicle[index] {
            solvedVehicle[index] = false
            allSolved()
        } else {
            return
        }
    }

    func allSolved() {
        for i in 0..<solvedVehicle.count {
            if !solvedVehicle[i] {
                return
            }
        }
        scoreTimer.invalidate()
        timer.timer.invalidate()
        checkHighScores()
        win()
    }

    func timeUI() {
        let timeUIPos = UIImageView(frame: CGRect(x: 70,y: 720,width: 50,height: 30 ))
        timeUIPos.contentMode = .scaleAspectFill
        let image : UIImage = UIImage(named: "time")!
        timeUIPos.image = image
        self.view.addSubview(timeUIPos)

        minutes.contentMode = .scaleAspectFill
        minutes.image = timer.minutesImg
        self.view.addSubview(minutes)

        seconds.contentMode = .scaleAspectFill
        seconds.image = timer.secondsImg
        self.view.addSubview(seconds)

        seconds1.contentMode = .scaleAspectFill
        seconds1.image = timer.seconds1Img
        self.view.addSubview(seconds1)

        scoreUI()
    }

    func scoreUI(){
        let scoreUIPos = UIImageView(frame: CGRect(x:785, y: 720, width: 80, height: 30))
        scoreUIPos.contentMode = .scaleAspectFill
        scoreUIPos.image = UIImage(named:"score")
        self.view.addSubview(scoreUIPos)

        scoreImg.contentMode = .scaleAspectFill
        scoreImg.image = numberImageArray[0]
        self.view.addSubview(scoreImg)

        score1Img.contentMode = .scaleAspectFill
        score1Img.image = numberImageArray[0]
        self.view.addSubview(score1Img)

        spawnGame()
    }

    func updateScoreUI() {
        scoreImg.image = numberImageArray[finalScore / 10]
        score1Img.image = numberImageArray[finalScore % 10]
    }

    func checkHighScores() {
        let potentialHS = ScoreTracker(gameType: "Sort", score: finalScore)

        for i in 0..<tempScore.count {
            if tempScore[i].score < finalScore {
                tempScore.insert(potentialHS, at: i)
                tempScore.remove(at: 5)
                highScoreList[1] = tempScore
                ScoreTracker.updateDatabase(highScoreList)
                return
            }

        }
    }

    func spawnGame() {
        for i in 0 ..< getVehicles.allArray.count {
            if thisDifficulty.difficulty == "Easy" {
                pickVehicles(index: i)

            } else if thisDifficulty.difficulty == "Medium" {
                pickVehicles(index: i)

            } else {
                pickVehicles(index: i)
            }
        }
    }

    func pickVehicles(index: Int) {
        let vehicleImage = UIImageView(frame: CGRect(x:(index * 70) + 20, y:80, width: 60, height: 60))
        vehicleImage.contentMode = .scaleAspectFit
        vehicleImage.image = classify(vehicle: getVehicles.allArray[index])
        vehicleImage.isUserInteractionEnabled = true
        vehicleImage.addGestureRecognizer(imagePath[index])
        self.view.addSubview(vehicleImage)
        originalLocations.append(vehicleImage.frame.origin)
    }

    func classify(vehicle: Vehicle) -> UIImage {
        if vehicle.isAir {
            return airArrayImage[vehicle.typeID!]
        } else if vehicle.isWater {
            return waterArrayImage[vehicle.typeID!]
        } else {
            return landArrayImage[vehicle.typeID!]
        }
    }

    func win() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.presentWinAlert()
    }

    func loss() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.endTimeAlert()
    }
}