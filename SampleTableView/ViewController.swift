//
//  ViewController.swift
//  SampleTableView
//
//  Created by Suresh on 04/04/18.
//  Copyright © 2018 FIngent. All rights reserved.
//  Developed by pc

import UIKit

class ViewController: UIViewController {
    var heightOfKeyboard : CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(baseView)

        baseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        baseView.addSubview(textfieldForScrolling)
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":textfieldForScrolling]))
        baseView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":textfieldForScrolling]))

        /// adding some of the observers
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func changesMade(){
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)

    }
    func adjustingHeight(show:Bool, notification:NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeHeight = (keyboardFrame.height) * (show ? 1 : -1)
        if heightOfKeyboard == nil{
            heightOfKeyboard = changeHeight
        }
        UIView.animate(withDuration: animationDurarion, animations: {
            if self.heightOfKeyboard != nil{
                if show == true{
                    self.baseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (self.view.frame.size.height - self.heightOfKeyboard!))
                    self.baseView.layoutIfNeeded()
                }
                else{
                    self.baseView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height:self.view.frame.size.height)
                    self.baseView.layoutIfNeeded()
                }
            }
        }) { (bool) in
            
        }
       
    }
    let baseView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2.0
       // view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let tableViewForScrolling : TPKeyboardAvoidingTableView = {
        let tableView = TPKeyboardAvoidingTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let textfieldForScrolling : UITextField = {
        let textFielsd = UITextField()
        textFielsd.backgroundColor = UIColor.blue
        textFielsd.translatesAutoresizingMaskIntoConstraints = false
        return textFielsd
    }()



}
//        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":baseView]))
//        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":baseView]))

/* self.view.addSubview(tableViewForScrolling)
 self.view.addSubview(textfieldForScrolling)
 
 self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tableViewForScrolling]))
 self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":textfieldForScrolling]))
 self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0][v1(50)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":tableViewForScrolling,"v1":textfieldForScrolling]))*/

