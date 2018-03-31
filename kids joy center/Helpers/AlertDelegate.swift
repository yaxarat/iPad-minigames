//
//  AlertDelegate.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/28/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class AlertMessage {
    var viewController: UIViewController?
    var score = 0
    init(viewController: UIViewController, score: Int){
        self.viewController = viewController
        self.score = score
    }

    func winAlert() {
        let alert = UIAlertController(title: "Great Job", message: "Your Score Was: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Return to Menu", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)

        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
    
    func loseAlert() {
        let alert = UIAlertController(title: "Ouch!", message: "Time is UP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Return to Menu", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)
        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }

    func balloonAlert() {
        let alert = UIAlertController(title: "Ehm!", message: "That's enough game for today!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it...", style: .cancel, handler: { action in
        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
}
