//
//  ViewController.swift
//  Calculator
//
//  Created by 水垣岳志 on 2018/01/26.
//  Copyright © 2018年 mzgkworks.com. All rights reserved.
//

import UIKit

enum Operator {
    case undefined          // 未定義
    case addition           // 加法（＋）
    case subtraction        // 減法（－）
    case multiplication     // 乗法（×）
    case division           // 除法（÷）
}

class ViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var label: UILabel!

    // MARK: - Property
    var firstValue = 0
    var secondValue: Int!   // 暗黙的アンラップ -> 演算子ボタンでの連続計算をするための判断のため
    var currentOperator = Operator.undefined

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - User Action
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        // 本にあるようなswitch文は使用しない（ボタンのタイトルを対応する数値に置き換えているだけなので）
        let value = Int(sender.currentTitle!)!

        if currentOperator == .undefined {
            firstValue = firstValue * 10 + value
            label.text = String(firstValue)
        }
        else {
            secondValue = (secondValue ?? 0) * 10 + value // nilなら0を代入して計算
            label.text = String(secondValue)
        }
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        // ＝をタップせずに、続けて演算を行う
        if let _ = secondValue {
            self.equalButtonTapped(sender)
        }

        switch sender.currentTitle! {
        case "+":
            currentOperator = .addition
        case "-":
            currentOperator = .subtraction
        case "×":
            currentOperator = .multiplication
        case "÷":
            currentOperator = .division
        default:
            currentOperator = .undefined
        }
    }

    @IBAction func equalButtonTapped(_ sender: UIButton) {
        // ２つ目の数字が入力されてなければ処理しない
        guard let _ = secondValue else {
            return
        }

        var value = 0

        switch currentOperator {
        case .addition:
            value = firstValue + secondValue
        case .subtraction:
            value = firstValue - secondValue
        case .multiplication:
            value = firstValue * secondValue
        case .division:
            if secondValue != 0 {
                value = firstValue / secondValue
            }
            else {  // 0除算
                label.text = "Divide by 0."
                firstValue = 0
                secondValue = nil
                currentOperator = .undefined
                return
            }
        case .undefined:
            return  // 演算子ボタンが押されてない場合は処理しない
        }

        label.text = String(value)
        firstValue = value      // 結果から続けて演算を行う
        secondValue = nil
        currentOperator = .undefined
    }

    @IBAction func allClearButtonTapped(_ sender: UIButton) {
        firstValue = 0
        secondValue = nil
        currentOperator = .undefined
        label.text = ""
    }
}

