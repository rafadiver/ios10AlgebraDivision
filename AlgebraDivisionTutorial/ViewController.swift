//
//  ViewController.swift
//  AlgebraDivisionTutorial
//
//  Created by Maria Susana Moline Venanzi on 4/14/17.
//  Copyright © 2017 Uberbliss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblQuestionLabel: UILabel!
    @IBOutlet weak var txtInputText: UITextField!
    @IBOutlet weak var btnCheckButton: UIButton!
    @IBOutlet weak var lblIsCorrectLabel: UILabel!

    @IBOutlet weak var pgvProgressView: UIProgressView!
    @IBOutlet weak var lblProgressLabel: UILabel!
    
    
    var previousResults: [Bool] = [false, false, false, false]
    
    var randomNumber: Int?
    var valueOfX: Int?
    var lastValueOfX: Int?
    var questionAnswer :Int = 1
    // rn1 / x =  rn2
    var userAnswer: Int?
    var currentAnswerIndex: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chooseQuestionNumbers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressCheckAnswerButton(_ sender: UIButton) {
        
        if let _ = Int(txtInputText.text!){
            userAnswer = Int(txtInputText.text!)!
            checkIfCorrect()
        }
        txtInputText.text?.removeAll()
        chooseQuestionNumbers()
        let progress = pgvProgressView.progress
        lblProgressLabel.text = String(Int(progress * 4)) + "/4"
        
        
    }
    
    
    // n1 / x = n2
    // n1 = x * n2
    
    func chooseQuestionNumbers() {
        valueOfX = Int(arc4random_uniform(13))
        if (valueOfX == lastValueOfX){
            chooseQuestionNumbers()
        }
        lastValueOfX = valueOfX
        randomNumber = questionAnswer * valueOfX!
        lblQuestionLabel.text = String(randomNumber!) + "  /  x  =  " + String(questionAnswer)
    }
    
  
    
    
    func advanceDificulty() {
        var allcorrect : Bool = true
       
        for index1 in 0..<previousResults.count{
            if (previousResults[index1] == false){
            allcorrect = false
            }
        
        }
        if (allcorrect == true && questionAnswer < 12) {
            questionAnswer += 1
            lblIsCorrectLabel.text = " Correct and advancing dificulty"
            
            for index2 in 0..<previousResults.count{
            previousResults[index2] = false
            }
            pgvProgressView.progress = 0
            currentAnswerIndex = 0
            
        }
    }
    
    
    
    func checkIfCorrect() {
        
        if (userAnswer == valueOfX){
            previousResults[currentAnswerIndex] = true
            currentAnswerIndex += 1
            lblIsCorrectLabel.text = "Thats correct"
            pgvProgressView.progress += 0.25
            advanceDificulty()
            lblIsCorrectLabel.backgroundColor = UIColor.green
        } else {
            for index in 0..<previousResults.count {
                previousResults[index] = false
                
            }
            lblIsCorrectLabel.text = " wrong, good try"
            currentAnswerIndex = 0
            pgvProgressView.progress = 0
            lblIsCorrectLabel.backgroundColor = UIColor.red
        }
    }
}

