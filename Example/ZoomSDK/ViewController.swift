//
//  ViewController.swift
//  ZoomSDK
//
//  Created by George Lim on 2017-07-24.
//  Copyright © 2017 George Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor(white: 249 / 255, alpha: 1)
    
    let joinButton = UIButton()
    joinButton.backgroundColor = .black
    joinButton.setTitle("Join Meeting", for: .normal)
    joinButton.addTarget(self, action: #selector(joinMeeting), for: .touchUpInside)
    joinButton.layer.cornerRadius = 5
    
    let startButton = UIButton()
    startButton.backgroundColor = .black
    startButton.setTitle("Start Meeting", for: .normal)
    startButton.addTarget(self, action: #selector(startMeeting), for: .touchUpInside)
    startButton.layer.cornerRadius = 5
    
    joinButton.frame = CGRect(x: view.center.x - 75, y: view.center.y - 25 + 60, width: 150, height: 50)
    startButton.frame = CGRect(x: view.center.x - 75, y: view.center.y - 25 - 60, width: 150, height: 50)
    view.addSubview(joinButton)
    view.addSubview(startButton)
  }
  
  func joinMeeting() {
    let alert = UIAlertController(title: "Meeting Credentials", message: nil, preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: {
      (textField) in
      textField.keyboardType = .numberPad
      textField.placeholder = "Meeting Number"
    })
    
    alert.addTextField(configurationHandler: {
      (textField) in
      textField.placeholder = "No Password"
      textField.isSecureTextEntry = true
    })
    
    let okay = UIAlertAction(title: "Join", style: .default, handler: {
      (action) in
      guard let meetingNumberText = alert.textFields?[0].text, let meetingNumber = Int(meetingNumberText), let meetingPassword = alert.textFields?[1].text else { return }
      
      // Join Zoom meeting.
      ZoomService.sharedInstance.joinMeeting(number: meetingNumber, password: meetingPassword)
    })
    
    alert.addAction(okay)
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  func startMeeting() {
    let alert = UIAlertController(title: "Add Password?", message: "Secure your next meeting with a password. Keep the creeps out!", preferredStyle: .alert)
    
    alert.addTextField(configurationHandler: {
      (textField) in
      textField.placeholder = "No Password"
      textField.isSecureTextEntry = true
    })
    
    let start = UIAlertAction(title: "Start", style: .default, handler: {
      (action) in
      guard let meetingPassword = alert.textFields?[0].text else { return }
      
      // Start Zoom meeting.
      ZoomService.sharedInstance.startMeeting(password: meetingPassword)
    })
    
    alert.addAction(start)
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
}
