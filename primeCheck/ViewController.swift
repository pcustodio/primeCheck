//
//  ViewController.swift
//  primeCheck
//
//  Created by Paulo Custódio on 30/07/2020.
//  Copyright © 2020 Paulo Custódio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var isPrimeBtn: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    
    var enteredValues = [Int]()
    var foundPrimes = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add round corners to button... because it's prettier
        isPrimeBtn.layer.cornerRadius = 5.0
        
        //clear label
        answerLabel.text = ""
        
        //conform to delegate and force only numbers in textfield
        numberField.delegate = self
        
        //looks for single or multiple taps and then dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    
    //MARK: - Add Numbers
    
    @IBAction func checkPrimes(_ sender: Any) {
        
        //check for prime numbers
        if let userString = numberField.text {
            let userInt = Int(userString)
            
            if let number = userInt {
                var isPrime = true
                if number == 1 || number == 0 {
                    isPrime = false
                }
                var i = 2
                while i < number {
                    if number % i == 0 {
                        isPrime = false
                    }
                    i += 1
                }
                if isPrime {
                    foundPrimes.append(number)
                    enteredValues.append(number)
                } else {
                    enteredValues.append(number)
                }
            }
        }
        
        //update label
        if enteredValues.count == 0 {
            answerLabel.text = "No numbers entered."
        } else {
            if foundPrimes.count == 0 {
                answerLabel.text = "Entered numbers: \(enteredValues). \n\nNo prime numbers."
            } else {
                answerLabel.text = "Entered numbers: \(enteredValues). \n\nPrime numbers: \(foundPrimes)"
            }
        }
        
        //clear text field
        numberField.text = ""
        
        //close keyboard
        self.view.endEditing(true)
        
    }
    
    
    //MARK: - Reset
    
    @IBAction func resetBtn(_ sender: Any) {
        answerLabel.text = ""
        enteredValues.removeAll()
        foundPrimes.removeAll()
    }
    
    
    //MARK: - Misc
    
    //force textfield to accept only numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    //calls this function when the tap is recognized to dismiss keyboard
    @objc func dismissKeyboard() {
        //causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}

