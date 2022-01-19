//
//  ViewController.swift
//  Lab1_SravanSriramoju_C0828149_iOS
//
//  Created by Sravan Sriramoju on 2022-01-18.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Score: UILabel!
    
    @IBOutlet weak var player2Score: UILabel!
    
    @IBOutlet weak var resultmsgLB: UILabel!
    
    var activePlayer = 1
    
    var activeGame = true
    var p1score = 0
    var p2score = 0
    var wincombinations = PlayerWinCombination()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        player2Score.text = "0"
        player1Score.text = "0"
        
        // code for swipe gestures so that game gets reset upon swipe
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(playagain(gesture:)))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(playagain(gesture:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(playagain(gesture:)))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(playagain(gesture:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
    }
    
    // method for game replay
    
    @objc func playagain(gesture: UISwipeGestureRecognizer) {
        let swipeGesture = gesture as UISwipeGestureRecognizer
        switch swipeGesture.direction {
        case .left, .right, .up, .down:
            wincombinations.gameState = [0,0,0,0,0,0,0,0,0]
            activeGame = true
            resultmsgLB.text = ""
            
            for i in 1..<10 {
                if let button = view.viewWithTag(i) as? UIButton {
                    button.setImage(nil, for: [])
                    button.alpha = 1
                }
            }
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let activePosition = sender.tag - 1
        if wincombinations.gameState[activePosition] == 0 && activeGame {
            wincombinations.gameState[activePosition] = activePlayer
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
                }
             else {
                sender.setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
                }
        }
        
        checkGameHasWinner()
        if checkGameIsDraw() && activeGame {
            resultmsgLB.text = "It was a tie"
        }
    }
    
    // method to check which player is the winner
    
    func checkGameHasWinner() {
        for combination in wincombinations.winningCombination {
            if wincombinations.gameState[combination[0]] != 0 &&
                wincombinations.gameState[combination[1]] == wincombinations.gameState[combination[2]] &&
                wincombinations.gameState[combination[2]] == wincombinations.gameState[combination[0]] {
            
                activeGame = false
                
                if wincombinations.gameState[combination[0]] == 1 {
                    print("Player-1 won")
                    resultmsgLB.text = "Player-1 won!!"
                    p1score += 1
                    player1Score.text = String(p1score)
                } else {
                    print("Player-2 won")
                    resultmsgLB.text = "Player-2 won!!"
                    p2score += 1
                    player2Score.text = String(p2score)
                }

            }
        }
    }
    
    // methpd to check if game was a tie
    
    func checkGameIsDraw() -> Bool {
        for state in wincombinations.gameState {
            if state == 0 {
                return false
            }
        }
        return true
    }

}

