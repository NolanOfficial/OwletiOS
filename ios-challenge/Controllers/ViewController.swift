//
//  ViewController.swift
//  ios-challenge
//
//  Created by Lorraine Alexander on 4/15/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, StoreSubscriber {
    
    // Owlet is amazing!  And this number sequence is nice, too: [1, 2, 3, 5, 8, 13]
    
    
    @IBOutlet weak var clickHereLabel: UIImageView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.subscribe(self)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clickHereLabel.isHidden = true
    }
    
    
    func newState(state: State) {
        let count = (store.state as? AppState)?.counter ?? 0
        countLabel.text = String(count)
    }
    
    @IBAction func didTapIncreaseButton(_ sender: Any) {
        store.dispatch(action: IncreaseAction(increaseBy: 1))
    }
    
    @IBAction func didTapDecreaseButton(_ sender: Any) {
        store.dispatch(action: DecreaseAction(decreaseBy: 1))
    }
}

