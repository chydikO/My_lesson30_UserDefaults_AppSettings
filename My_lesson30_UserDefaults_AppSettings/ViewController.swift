//
//  ViewController.swift
//  My_lesson30_UserDefaults_AppSettings
//
//  Created by Олег Чудновский on 12.07.2020.
//  Copyright © 2020 Олег Чудновский. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
        @IBOutlet private var switchControl: UISwitch!
        @IBOutlet private var textField: UITextField!
        @IBOutlet private var datePicker: UIDatePicker!
        @IBOutlet private var contentBottomConstraint: NSLayoutConstraint!

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tap)
            
            setupData()
            
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(
                forName: UIResponder.keyboardWillChangeFrameNotification,
                object: nil, queue: .main) { (notification) in
                    self.handleKeyboard(notification: notification)
            }
            notificationCenter.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil, queue: .main) { (notification) in
                    self.handleKeyboard(notification: notification)
            }
        }

        //MARK: - Private
        private func handleKeyboard(notification: Notification) {
          // 1
          guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            contentBottomConstraint.constant = 0
            view.layoutIfNeeded()
            return
          }

          guard
            let info = notification.userInfo,
            let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {
              return
          }

          // 2
          let keyboardHeight = keyboardFrame.cgRectValue.size.height
          UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.contentBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
          })
        }
        
        //MARK: - Private
        private func setupData() {
            switchControl.isOn = AppSettings.shared.switchValue
            textField.text = AppSettings.shared.stringValue
            datePicker.date = AppSettings.shared.dateValue ?? Date()
        }
        
        private func clearData() {
            AppSettings.shared.clear()
            setupData()
        }
        
        //MARK: - Actions
        @IBAction private func switchControlChanged() {
            AppSettings.shared.switchValue = switchControl.isOn
        }
        
        @IBAction private func datePickerChanged() {
            AppSettings.shared.dateValue = datePicker.date
        }
        
        @IBAction private func textFieldChanged() {
            AppSettings.shared.stringValue = textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        
        @IBAction private func clearDataButtonClicked() {
            let alert = UIAlertController(title: "Удалить данные?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { [weak self] _ in
                self?.clearData()
            }))
            alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        @IBAction private func hideKeyboard() {
            view.endEditing(true)
        }

    }

    extension ViewController: UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
    }
