//
//  ViewController.swift
//  guessNumber
//
//  Created by Machir on 2021/7/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var chanceLabel: UILabel!
    
    var randomNumber = Int.random(in: 0...50)
    var lowestNumber = 0
    var hightNumber = 50
    var chance = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameInit()
    }

    func gameInit() {
        //初始遊戲函數
        randomNumber = Int.random(in: 0...50)
        lowestNumber = 0
        hightNumber = 50
        chance = 6
        
        numberTextField.text = nil
        rangeLabel.text = "範圍\(lowestNumber)~\(hightNumber)"
        chanceLabel.text = "剩餘猜測次數:\(chance)"
    }
    
    func running() {
        
        //TextField文字轉數字
        let enterNumber = Int(numberTextField.text!)
        
        //判斷:猜數是否正確
        if enterNumber == randomNumber {
            let winAlertController = UIAlertController(title: "答對了", message: "恭喜你", preferredStyle: .alert)
            
            let winalertAction = UIAlertAction(title: "重新開始", style: .default) {
                (_) in self.gameInit()
            }
            winAlertController.addAction(winalertAction)
            present(winAlertController, animated: true, completion: nil)
            
            //判斷:猜數是否大於答案
        } else if enterNumber != nil && enterNumber! > randomNumber {
            if enterNumber ?? hightNumber >= hightNumber {
                let overNumberAlartController = UIAlertController(title: "再輸入一次", message: "輸入的內容不在範圍內", preferredStyle: .alert)
                
                let overNumberAlartAction = UIAlertAction(title: "好", style: .default, handler: nil)
                
                overNumberAlartController.addAction(overNumberAlartAction)
                present(overNumberAlartController, animated: true, completion: nil)
            } else {
                chance -= 1
                hightNumber = enterNumber!
            }
            
            //判斷:猜數是否小於答案
        } else {
            if enterNumber ?? lowestNumber <= lowestNumber {
                let overNumberAlartController = UIAlertController(title: "再輸入一次", message: "輸入的內容不在範圍內", preferredStyle: .alert)
                
                let overNumberAlartAction = UIAlertAction(title: "好", style: .default, handler: nil)
                
                overNumberAlartController.addAction(overNumberAlartAction)
                present(overNumberAlartController, animated: true, completion: nil)
            } else {
                chance -= 1
                lowestNumber = enterNumber!
            }
        }
        
        //次數用完直接重新開始
        if chance == 0 {
            let runOutOfChanceAlertController = UIAlertController(title: "次數用完了", message: "答案是\(randomNumber)", preferredStyle: .alert)
            
            let runOutOfChanceAlertAction = UIAlertAction(title: "重新開始", style: .default) { (_) in
                self.gameInit()
            }
            
            runOutOfChanceAlertController.addAction(runOutOfChanceAlertAction)
            present(runOutOfChanceAlertController, animated: true, completion: nil)
        }
        
        //顯示範圍Label，剩餘猜測次數Label，TextField輸入完之後再顯示nil
        rangeLabel.text = "範圍\(lowestNumber)~\(hightNumber)"
        chanceLabel.text = "剩餘猜測次數:\(chance)"
        numberTextField.text = nil
    }

    @IBAction func guessNumberButton(_ sender: UIButton) {
        running()
        view.endEditing(true)
    }
    @IBAction func restartButton(_ sender: UIButton) {
        gameInit()
    }
    
    
}

