//
//  ViewController.swift
//  simonsays
//
//  Created by Christinaa Danks on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorButtons: [CircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerLbls: [UILabel]!
    @IBOutlet var scoreLbls: [UILabel]!
    
    var currentPlayer = 0
    var scores = [0,0]
    
    var sequenceIndex = 0
    var colorSequence = [Int]()
    var colorsToTap = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtons = colorButtons.sorted() {
            $0.tag < $1.tag
        }
        playerLbls = playerLbls.sorted() {
            $0.tag < $1.tag
        }
        scoreLbls = scoreLbls.sorted() {
            $0.tag < $1.tag
        }
        createNewGame()
    }
    
    func createNewGame() {
        colorSequence.removeAll()
        actionButton.setTitle("start game", for: .normal)
        actionButton.isEnabled = true
        for button in colorButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
    }
    
    func addNewColor() {
        colorSequence.append(Int(arc4random_uniform(UInt32(4))))
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(button: colorButtons[colorSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("tap the circles", for: .normal)
            for button in colorButtons {
                button.isEnabled = true
            }
        }
    }
    
    func flash(button: CircularButton) {
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 1.0
            button.alpha = 0.5
        }) { Bool in
            self.playSequence()
        }
    }
    
    @IBAction func colorBtnHandle(_ sender: CircularButton) {
        print("button \(sender.tag) tapped")
    }
    
    @IBAction func actionBtnHandle(_ sender: UIButton) {
        sequenceIndex = 0
        actionButton.setTitle("memorize", for: .normal)
        actionButton.isEnabled = false
        view.isUserInteractionEnabled = false
        addNewColor()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.playSequence()
        }
    }
    

}

