//
//  ViewController.swift
//  TicTacToe
//
//  Created by local192 on 10/12/2020.
//

import UIKit

class ViewController: UIViewController {

    var activePlayer = 1
    var player1:[Int] = [Int]()
    var player2:[Int] = [Int]()
    var winner = 0
    
    //button for auto play
    
    @IBOutlet weak var bu1: UIButton!
    @IBOutlet weak var bu2: UIButton!
    @IBOutlet weak var bu3: UIButton!
    @IBOutlet weak var bu4: UIButton!
    @IBOutlet weak var bu5: UIButton!
    @IBOutlet weak var bu6: UIButton!
    @IBOutlet weak var bu7: UIButton!
    @IBOutlet weak var bu8: UIButton!
    @IBOutlet weak var bu9: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func BuSelectEvent(_ sender: Any) {
        let buSelect = sender as! UIButton
        playGame(buSelect)
    }
    
    func playGame(_ buSelect : UIButton){
        if activePlayer == 1 {
            buSelect.setTitle("X", for: UIControl.State.normal)
            buSelect.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
            player1.append(buSelect.tag)
            findWinner(player1, activePlayer)
            viewWinner()
            activePlayer = 2
            autoPlay()
        }else if activePlayer == 2 {
            buSelect.setTitle("O", for: UIControl.State.normal)
            buSelect.backgroundColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
            
            player2.append(buSelect.tag)
            findWinner(player1, activePlayer)
            viewWinner()
            activePlayer = 1
        }
        buSelect.isEnabled = false
        buSelect.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 0.5), for: UIControl.State.disabled)
    }
    
    
    func findWinner(_ playertab : [Int], _ activePlayer : Int){
        // rows
        if ( ( playertab.contains(1) &&
                playertab.contains(2) &&
                playertab.contains(3)) ||
        (playertab.contains(4) &&
            playertab.contains(5) &&
            playertab.contains(6)) ||
        (playertab.contains(7) &&
            playertab.contains(8) &&
            playertab.contains(9))
        ) {
            self.winner = activePlayer
        }
        // colums
        if ( ( playertab.contains(1) &&
                playertab.contains(4) &&
                playertab.contains(7)) ||
        (playertab.contains(2) &&
            playertab.contains(5) &&
            playertab.contains(8)) ||
        (playertab.contains(3) &&
            playertab.contains(6) &&
            playertab.contains(9))
        ) {
            self.winner = activePlayer
        }
    }
    
    func viewWinner(){
        if self.winner == 1 || self.winner == 2 {
            let msg = "the winner is player\(self.winner)"
            let alert = UIAlertController(title: "TicTacToe", message: msg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Game Over ...", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func autoPlay() {
        var emptyCells: [Int] = [Int]()
        for index in 1...9 {
            if ( !(self.player1.contains(index) || self.player2.contains(index) )) {
                emptyCells.append(index)
            }
        }
        if ( !emptyCells.isEmpty) {
            let randIndex = arc4random_uniform(UInt32(emptyCells.count))
            let cellId = emptyCells[Int(randIndex)]
            var buSelect: UIButton
            switch cellId {
            case 1:
                buSelect = self.bu1
            case 2:
                buSelect = self.bu2
            case 3:
                buSelect = self.bu3
            case 4:
                buSelect = self.bu4
            case 5:
                buSelect = self.bu5
            case 6:
                buSelect = self.bu6
            case 7:
                buSelect = self.bu7
            case 8:
                buSelect = self.bu8
            case 9:
                buSelect = self.bu9
            default:
                buSelect = self.bu1
            }
            playGame(buSelect)
        }
    }
}

