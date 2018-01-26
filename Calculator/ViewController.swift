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
    var secondValue = 0
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
            secondValue = secondValue * 10 + value
            label.text = String(secondValue)
        }

        print("value : \(value)")
        print("first : \(firstValue)")
        print("second : \(secondValue)")
    }

    @IBAction func operatorButtonTapped(_ sender: UIButton) {
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

        print(currentOperator)
    }

    @IBAction func equalButtonTapped(_ sender: UIButton) {
    }

    @IBAction func allClearButtonTapped(_ sender: UIButton) {
    }
}

