//
//  ViewController.swift
//  SearchingTable
//
//  Created by Buse ERKUŞ on 4.03.2019.
//  Copyright © 2019 Buse ERKUŞ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var record = MyData()
    var mode: Mode!
    
    var  delegate: MyCollectionViewController!
    
    let nameTF = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let genderSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    let ageStepper = UIStepper(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    let genderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
    let ageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 21))
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveRecord))
    let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelRecord))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpNavigation()
        
        genderSwitch.addTarget(self, action: #selector(genderSwitchTouch), for: .valueChanged)
        
        ageStepper.addTarget(self, action: #selector(ageStepperMove), for: .valueChanged)
        
        nameTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        view.addSubview(nameTF)
        view.addSubview(genderSwitch)
        view.addSubview(ageStepper)
        view.addSubview(genderLabel)
        view.addSubview(ageLabel)
        
        view.backgroundColor = .yellow
        
        setUpContraints()
        
        setUpValues()
        
    }
    
    func setUpNavigation() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        navigationItem.titleView = titleLabel
        if record.name.isEmpty {
            titleLabel.text = "Add Record"
        } else {
            titleLabel.text = "Edit Record"
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.leftBarButtonItem = cancelButton
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        record.name = textField.text!
        saveButton.isEnabled = !record.name.isEmpty
    }
    
    
    @objc func saveRecord() {
        
        if mode == .add {
            delegate?.add(record: record)
        } else if mode == .edit {
            delegate?.modify(record: record)
        }
        else {
            print ("This Shouldn't Happen")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancelRecord() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func genderSwitchTouch() {
        
        record.gender = genderSwitch.isOn
        genderLabel.text = (genderSwitch.isOn) ? "Female" : "Male"
    }
    
    @objc func ageStepperMove() {
        record.age = Int(ageStepper.value)
        ageLabel.text = String(describing: record.age)
    }
    
    func setUpValues() {
        
        nameTF.text = record.name
        nameTF.placeholder = "Your Name"
        nameTF.textAlignment = .center
        genderSwitch.isOn = record.gender
        genderLabel.text = (genderSwitch.isOn) ? "Female" : "Male"
        ageStepper.minimumValue = 18
        ageStepper.maximumValue = 100
        ageStepper.value = Double(record.age)
        ageLabel.text = String(describing: record.age)
        saveButton.isEnabled = !record.name.isEmpty
        nameTF.becomeFirstResponder()
    }
    
    func setUpContraints() {
        
        let nameCentreX = NSLayoutConstraint(item: nameTF, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0)
        let nameTop = NSLayoutConstraint(item: nameTF, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 100)
        let nameHeight = NSLayoutConstraint(item: nameTF, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let nameWidth = NSLayoutConstraint(item: nameTF, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 160)
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([nameCentreX, nameTop, nameHeight, nameWidth])
        
      
        
        let genderCentreX = NSLayoutConstraint(item: genderSwitch, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: -30)
        let genderTop = NSLayoutConstraint(item: genderSwitch, attribute: .top, relatedBy: .equal, toItem: nameTF, attribute: .bottom, multiplier: 1.0, constant: 100)
        let genderHeight = NSLayoutConstraint(item: genderSwitch, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let genderWidth = NSLayoutConstraint(item: genderSwitch, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 60)
        
        genderSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([genderCentreX, genderTop, genderHeight, genderWidth ])
       
        
        let ageCentreX = NSLayoutConstraint(item: ageStepper, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: -40)
        let ageTop = NSLayoutConstraint(item: ageStepper, attribute: .top, relatedBy: .equal, toItem: genderSwitch, attribute: .bottom, multiplier: 1.0, constant: 100)
        let ageHeight = NSLayoutConstraint(item: ageStepper, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let ageWidth = NSLayoutConstraint(item: ageStepper, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 80)
        
        ageStepper.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([ageCentreX, ageTop,ageWidth, ageHeight])
        
       
        let glLeft = NSLayoutConstraint(item: genderLabel, attribute: .left, relatedBy: .equal, toItem: genderSwitch, attribute: .right, multiplier: 1.0, constant: 16)
        let glTop = NSLayoutConstraint(item: genderLabel, attribute: .top, relatedBy: .equal, toItem: genderSwitch, attribute: .top, multiplier: 1.0, constant: 0)
        let glHeight = NSLayoutConstraint(item: genderLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let glWidth = NSLayoutConstraint(item: genderLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 80)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([glLeft, glTop, glWidth, glHeight])
        
        
        let alLeft = NSLayoutConstraint(item: ageLabel, attribute: .left, relatedBy: .equal, toItem: ageStepper, attribute: .right, multiplier: 1.0, constant: 32)
        let alTop = NSLayoutConstraint(item: ageLabel, attribute: .top, relatedBy: .equal, toItem: ageStepper, attribute: .top, multiplier: 1.0, constant: 0)
        let alHeight = NSLayoutConstraint(item: ageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 30)
        let alWidth = NSLayoutConstraint(item: ageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 80)
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([alLeft, alTop, alWidth, alHeight])
        
        
    }
    
}
