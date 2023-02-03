//
//  ViewController.swift
//  tic-tac-toe3
//
//  Created by Confetti on 2.02.23.
//

import UIKit

class ViewController: UIViewController {
    enum Turn {
        case X
        case O
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.X
    var currentTurn = Turn.X
    
    var X = "X"
    var O = "O"
    var board = [UIButton]()
    
    var xScore = 0
    var oScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    func initBoard()
    {
        board = [
            a1, a2, a3,
            b1, b2, b3,
            c1, c2, c3
        ]
    }
    @IBAction func tapResetButton(_ sender: UIButton) {
        resetBoard()
    }
    
    @IBAction func boardtapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if (checkWinner(X)) {
            xScore += 1
            resultAlert(title: "Crosses Win!")
        } else if (checkWinner(O)) {
            oScore += 1
            resultAlert(title: "Noughts Win!")
        }
        
        if (fullBoard())
        {
            resultAlert(title: "Draw")
        }
    }
    
    func checkWinner(_ s: String) -> Bool {
        
        // Horizontal
        if (isSymbol(a1, s) && isSymbol(a2, s) && isSymbol(a3, s)) ||
        (isSymbol(b1, s) && isSymbol(b2, s) && isSymbol(b3, s)) ||
        (isSymbol(c1, s) && isSymbol(c2, s) && isSymbol(c3, s)){
            return true
        }
        
        //Vertical
        if (isSymbol(a1, s) && isSymbol(b1, s) && isSymbol(c1, s)) ||
        (isSymbol(a2, s) && isSymbol(b2, s) && isSymbol(c2, s)) ||
        (isSymbol(a3, s) && isSymbol(b3, s) && isSymbol(c3, s)){
            return true
        }
        
        //Diagonal
        if (isSymbol(a1, s) && isSymbol(b2, s) && isSymbol(c3, s)) ||
        (isSymbol(a3, s) && isSymbol(b2, s) && isSymbol(c1, s)){
            return true
        }
        
        return false
    }
    
    func isSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func resultAlert(title: String)
    {
        let message = "\nCrosses " + String(xScore) + "\n\nNoughts " + String(oScore)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: {
            (_) in self.resetBoard()
        }))
        self.present(alert, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        
        switch firstTurn {
        case Turn.X:
            firstTurn = Turn.O
            turnLabel.text = O
        case Turn.O:
            firstTurn = Turn.X
            turnLabel.text = X
        }
        currentTurn = firstTurn
    }
    
    func fullBoard() -> Bool {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func addToBoard(_ sender: UIButton) {
        if(sender.title(for: .normal) == nil) {
            switch currentTurn {
                case Turn.X:
                    sender.setTitle(X, for: .normal)
                    currentTurn = Turn.O
                    turnLabel.text = O
                case Turn.O:
                    sender.setTitle(O, for: .normal)
                    currentTurn = Turn.X
                    turnLabel.text = X
            }
            sender.isEnabled = false
        }
    }
    
}

