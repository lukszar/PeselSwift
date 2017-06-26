//
//  ViewController.swift
//  PeselSwiftDemo
//
//  Created by Łukasz Szarkowicz on 23.06.2017.
//  Copyright © 2017 Łukasz Szarkowicz. All rights reserved.
//

import UIKit
import PeselSwift

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    
    
    @IBAction func validateAction(_ sender: Any) {
        
        if let text = inputField.text {
            
            let pesel = Pesel(pesel: text)
            let result = pesel.validate()
            
            switch result {
            case .success:
                peselCorrect()
                
            case .error(let error):
                peselIncorrect(with: error)
            }
            
            showBirthDate(pesel.birthdate())
        }
        
        inputField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusLabel.text = nil
        birthdateLabel.text = nil
        
        peselReset()
        inputField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peselReset() {
        let newColor = UIColor(red: 100.0 / 255.0, green: 150.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0)
        statusLabel.text = nil
        statusLabel.textColor = newColor
        inputField.tintColor = newColor
        inputField.backgroundColor = UIColor.clear
    }
    
    func peselCorrect() {
        
        statusLabel.text = "PESEL number is validated succesfully"
        statusLabel.textColor = UIColor.green
        inputField.tintColor = UIColor.green
        inputField.backgroundColor = UIColor.green.withAlphaComponent(0.3)
    }
    
    func peselIncorrect(with error: Pesel.ValidateError) {
        
        var errorReason = "PESEL number validation failure:\n"
        switch error {
        case .otherThanDigits:
            errorReason.append("should contains only digits.")
        case .wrongChecksum:
            errorReason.append("number is not valid.")
        case .wrongLength:
            errorReason.append("number should be 11 digits only.")
        }
        statusLabel.text = errorReason
        statusLabel.textColor = UIColor.red
        inputField.tintColor = UIColor.red
        inputField.backgroundColor = UIColor.red.withAlphaComponent(0.3)
    }
    
    func birthDateReset() {
        birthdateLabel.text = nil
    }
    
    func showBirthDate(_ date: Date?) {
        
        guard let date = date else {
            birthDateReset()
            return
        }
        
        let birthDate = DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
        
        birthdateLabel.text = "Birthday: ".appending(birthDate)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        birthDateReset()
        peselReset()
        return true
    }
}
