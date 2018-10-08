//
//  add_SJ_ViewController.swift
//  TCOH
//
//  Created by student on 12/1/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class add_SJ_ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    
    @IBOutlet weak var sj_ID: UITextField!
    @IBOutlet weak var sj_Name: UITextView!
    
    var myData:NSArray = []
    @IBOutlet weak var sectioncourse: UITextField!
    @IBOutlet weak var room: UITextField!
    @IBOutlet weak var begintime: UITextField!
    @IBOutlet weak var endtime: UITextField!
    @IBOutlet weak var dayfield: UITextField!
    
    let picker = UIDatePicker()
    let picker2 = UIDatePicker()
    let picker3 = UIDatePicker()
    
    var days = ["อาทิตย์","จันทร์","อังคาร","พุธ","พฤหัสบดี","ศุกร์","เสาร์"]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: backgroundName)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        sj_Name.layer.borderWidth = 1.0
        sj_Name.layer.masksToBounds = false
        sj_Name.layer.borderColor = UIColor.init(red: 0.86, green: 0.86, blue: 0.86, alpha: 1.0).cgColor
        sj_Name.layer.cornerRadius = sj_Name.frame.height/13
        sj_Name.clipsToBounds = true
        // Do any additional setup after loading the view.
        createDatePicker()
        createDatePicker2()
        ////////////////////////////////////////////////
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        dayfield.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(add_SJ_ViewController.donePressed03))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.textAlignment = NSTextAlignment.center
        
        toolBar.setItems([doneButton], animated: true)
        
        dayfield.inputAccessoryView = toolBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func FindSJName(_ sender: UITextField) {
        //sectioncourse.text = sj_ID.text
       guard let length = sender.text?.characters.count else{
            return
        }
        if length == maxLengthSubjectID{

            CourseID = sj_ID.text!
            getJSONFromUrlSubject()
            sj_Name.text = CourseDetail
            
            }
            else if length > maxLengthSubjectID{
            sender.deleteBackward()
            }
    }
    
    
    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        begintime.inputAccessoryView = toolbar
        begintime.inputView = picker
        // format picker for date
        picker.datePickerMode = .time
        picker.locale = Locale.init(identifier: "en_GB")
    }
    
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        let dateString = formatter.string(from: picker.date)
        begintime.text = "\(dateString)"
        self.view.endEditing(true)
    }
    ///////////////////////////////////////////////////////////////////////////
    func createDatePicker2() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        toolbar.setItems([done], animated: false)
        
        endtime.inputAccessoryView = toolbar
        endtime.inputView = picker2
        
        // format picker for date
        picker2.datePickerMode = .time
        picker2.locale = Locale.init(identifier: "en_GB")
    }
    
    @objc func donePressed2() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        //formatter.dateStyle = .none
        //formatter.timeStyle = .short
        let dateString = formatter.string(from: picker2.date)
        endtime.text = "\(dateString)"
        self.view.endEditing(true)
    }
    ///////////////////////////////////////////////////////////////////////////
    
    func donePressed03(_ sender: UIBarButtonItem) {
        dayfield.resignFirstResponder()
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
        dayfield.text = "Sunday"
        dayfield.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dayfield.text = days[row]
    }

}
