//
//  CalcNeedFinalViewController.swift
//  EasyGC
//
//  Created by James Feng on 8/22/15.
//  Copyright (c) 2015 James Feng. All rights reserved.
//

import UIKit

class CalcNeedFinalViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gradeTextFieldQ1: UITextField!
    @IBOutlet weak var weightTextFieldQ1: UITextField!
    @IBOutlet weak var gradeTextFieldQ2: UITextField!
    @IBOutlet weak var weightTextFieldQ2: UITextField!
    @IBOutlet weak var weightTextFieldFinal: UITextField!
    @IBOutlet weak var targetGradeTextField: UITextField!
    @IBOutlet weak var finalGradeNeededLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        gradeTextFieldQ1.becomeFirstResponder()
        
        gradeTextFieldQ1.delegate = self
        weightTextFieldQ1.delegate = self
        gradeTextFieldQ2.delegate = self
        weightTextFieldQ2.delegate = self
        weightTextFieldFinal.delegate = self
        targetGradeTextField.delegate = self
        
        gradeTextFieldQ1.tag = 0
        weightTextFieldQ1.tag = 1
        gradeTextFieldQ2.tag = 2
        weightTextFieldQ2.tag = 3
        weightTextFieldFinal.tag = 4
        targetGradeTextField.tag = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func calculateButtonPressed(sender: UIButton) {
        
        var q1Grade = Double((gradeTextFieldQ1.text as NSString).doubleValue)
        var q1Weight = Double((weightTextFieldQ1.text as NSString).doubleValue)/100
        
        var q2Grade = Double((gradeTextFieldQ2.text as NSString).doubleValue)
        var q2Weight = Double((weightTextFieldQ2.text as NSString).doubleValue)/100
        
        var finalWeight = Double((weightTextFieldFinal.text as NSString).doubleValue)/100
        
        var targetGrade = Double((targetGradeTextField.text as NSString).doubleValue)
        
        var totalWeight:Double = q1Weight + q2Weight + finalWeight
        
        var gradeNeeded = (targetGrade - q1Grade * q1Weight - q2Grade * q2Weight)/finalWeight
        var roundedGradeNeeded = Double(round(100 * gradeNeeded)/100)
        
        
        if gradeTextFieldQ1.text.isEmpty || weightTextFieldQ1.text.isEmpty || gradeTextFieldQ2.text.isEmpty || weightTextFieldQ2.text.isEmpty || weightTextFieldFinal.text.isEmpty || targetGradeTextField.text.isEmpty {
            showAlertWithText(message: "Please input a value in all fields.")
        }
        else if gradeTextFieldQ1.text.doubleValue == nil || weightTextFieldQ1.text.doubleValue == nil || gradeTextFieldQ2.text.doubleValue == nil || weightTextFieldQ2.text.doubleValue == nil || weightTextFieldFinal.text.doubleValue == nil || targetGradeTextField.text.doubleValue == nil {
            showAlertWithText(message: "Please input only rational numbers.")
        }
        else if q1Grade < 0 || q1Weight < 0 || q2Grade < 0 || q2Weight < 0 ||  finalWeight < 0 || targetGrade < 0 {
            showAlertWithText(message: "Values cannot be negative.")
        }
        else if totalWeight != 1.0 {
            showAlertWithText(message: "The total weight must add up to 100%.")
        }
        else {
            finalGradeNeededLabel.text = "\(roundedGradeNeeded)" + "%"
            finalGradeNeededLabel.hidden = false
        }
    }
    
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        gradeTextFieldQ1.text = ""
        weightTextFieldQ1.text = ""
        gradeTextFieldQ2.text = ""
        weightTextFieldQ2.text = ""
        weightTextFieldFinal.text = ""
        targetGradeTextField.text = ""
        finalGradeNeededLabel.hidden = true
    }
    
    func showAlertWithText(header:String = "Something went wrong!", message:String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }

}
