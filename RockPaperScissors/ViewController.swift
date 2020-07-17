//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Andrei Tekhtelev on 2020-04-25.
//  Copyright © 2020 HomeDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var iPhoneScoreLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var revokeLabel: UILabel!
    
    var myHand = ""
    let hands =  ["👊", "✋", "✌️"]
    let losesAgainst = ["👊" : "✌️", "✋" : "👊", "✌️" : "✋"]
    var imageName: String = ""
    var selected = false
    var userScore = 0
    var iPhoneScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activatePlayButton(active: false)
        resetButtonsStyle()
    }
    
    
    @IBAction func selectRock(_ sender: Any) {
        if selected {
            revokeSelection()
        } else {
            myHand = "👊"
            selectedButtonsStyle(selectedButton: rockButton, buttonTwo: paperButton, buttonThree: scissorsButton, hand:  myHand)
        }
    }
    
    @IBAction func selectPaper(_ sender: Any) {
        if selected {
            revokeSelection()
        } else {
            myHand = "✋"
            selectedButtonsStyle(selectedButton: paperButton, buttonTwo: rockButton, buttonThree: scissorsButton, hand: myHand)
        }
    }
    
    @IBAction func selectScissors(_ sender: Any) {
        if selected {
            revokeSelection()
        } else {
            myHand = "✌️"
            selectedButtonsStyle(selectedButton: scissorsButton, buttonTwo: rockButton, buttonThree: paperButton, hand: myHand)
        }
    }
    
    func finishGame () {
        let iPhoneHand = hands.randomElement()!
        var message = ""
        if iPhoneHand == myHand {
            message = " It's a tie"
            imageName = "tie"
        } else if losesAgainst[iPhoneHand] == myHand {
            message = " iPhone won 😭😭😭"
            imageName = "\(iPhoneHand)vs\(myHand)"
            iPhoneScore += 1
            iPhoneScoreLabel.text = "\(iPhoneScore)"
        } else {
            message = "You won 🏆🏆🏆"
            imageName = "\(myHand)vs\(iPhoneHand)"
            userScore += 1
            userScoreLabel.text = "\(userScore)"
        }
        label.text = "You've selected \(myHand)\niPhone selected \(iPhoneHand)\n\(message)"
        resultImage.isHidden = false
        resultImage.image = UIImage(named: imageName)

        
    }
    
    @IBAction func play(_ sender: Any) {
        if playButton.titleLabel?.text == "Play Again" {
            resultImage.image = UIImage(named: "empty")
            resetButtonsStyle ()
            playButton.setTitle("", for: [])
            playButton.layer.borderWidth = 0
            activatePlayButton(active: false)
            label.text = "Select a hand"
            selected = false
        } else {
            var counter = 30
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if counter > 0 {
                    self.activatePlayButton(active: false)
                    self.label.text = "You've selected \(self.myHand)\niPhone is selecting in \(counter/10)\n\(self.hands.randomElement()!)"
                } else {
                    timer.invalidate()
                    self.finishGame()
                    self.resetButtonsStyle()
                    self.activatePlayButton(active: true)
                    self.playButton.setTitle("Play Again", for: [])
                    self.selectedButtonsStyle()
                }
                counter -= 1
            }
        }
    }
    
    
    func selectedButtonsStyle (selectedButton : UIButton,buttonTwo : UIButton, buttonThree: UIButton, hand: String) {
        selectedButton.layer.cornerRadius = 5
        selectedButton.layer.borderWidth = 3
        selectedButton.layer.borderColor = UIColor.orange.cgColor
        buttonTwo.alpha = 0.3
        buttonTwo.isEnabled = false
        buttonThree.alpha = 0.3
        buttonThree.isEnabled = false
        resultImage.isHidden = true
        activatePlayButton(active: true)
        label.text = "You've selected \(myHand)"
        selected = true
        revokeLabel.isHidden = false
    }
    
    func selectedButtonsStyle () {
        rockButton.alpha = 0.3
        paperButton.alpha = 0.3
        scissorsButton.alpha = 0.3
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
    }
    
    func revokeSelection () {
        resetButtonsStyle ()
        self.playButton.setTitle("", for: [])
        self.activatePlayButton(active: false)
        //playButton.layer.borderWidth = 0
        selected = false
        label.text = "Select a hand"
        resultImage.isHidden = false
    }
    
    func resetButtonsStyle () {
        rockButton.layer.borderColor = UIColor.white.cgColor
        paperButton.layer.borderColor = UIColor.white.cgColor
        scissorsButton.layer.borderColor = UIColor.white.cgColor
        rockButton.layer.cornerRadius = 5
        paperButton.layer.cornerRadius = 5
        scissorsButton.layer.cornerRadius = 5
        rockButton.layer.borderWidth = 2
        paperButton.layer.borderWidth = 2
        scissorsButton.layer.borderWidth = 2
        rockButton.alpha = 1
        paperButton.alpha = 1
        scissorsButton.alpha = 1
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorsButton.isEnabled = true
        revokeLabel.isHidden = true
    }
    
    func activatePlayButton (active: Bool) {
        if active {
            self.playButton.isEnabled = true
            self.playButton.alpha = 1
            playButton.layer.cornerRadius = 5
            playButton.layer.borderWidth = 2
            playButton.layer.borderColor = UIColor.orange.cgColor
            
        } else {
            self.playButton.isEnabled = false
            playButton.layer.cornerRadius = 5
            playButton.layer.borderWidth = 2
            self.playButton.alpha=0.2
            playButton.setTitle("Play", for: [])
            playButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
}

