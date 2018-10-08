//
//  OFH_ViewController.swift
//  TCOH
//
//  Created by student on 12/14/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class OFH_ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    
    @IBOutlet weak var dayOFH: UITextField!
    @IBOutlet weak var beginOFH: UITextField!
    @IBOutlet weak var endOFH: UITextField!

    var myData:NSArray = []
    
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
        
        createDatePicker()
        createDatePicker2() 
        // Do any additional setup after loading the view.
        let pickerView = UIPickerView()
        pickerView.delegate = self
        dayOFH.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(add_SJ_ViewController.donePressed03))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.textAlignment = NSTextAlignment.center
        
        toolBar.setItems([doneButton], animated: true)
        
        dayOFH.inputAccessoryView = toolBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        beginOFH.inputAccessoryView = toolbar
        beginOFH.inputView = picker
        // format picker for date
        picker.datePickerMode = .time
        picker.locale = Locale.init(identifier: "en_GB")
    }
    
    @objc func donePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        let dateString = formatter.string(from: picker.date)
        beginOFH.text = "\(dateString)"
        self.view.endEditing(true)
    }
    //////////////////////////////////////////////////////////////////////
    func createDatePicker2() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        toolbar.setItems([done], animated: false)
        
        endOFH.inputAccessoryView = toolbar
        endOFH.inputView = picker2
        // format picker for date
        picker2.datePickerMode = .time
        picker2.locale = Locale.init(identifier: "en_GB")
    }
    
    @objc func donePressed2() {
        // format date
        let formatter = DateFormatter()
        formatter.dateFormat = "H:mm"
        let dateString = formatter.string(from: picker2.date)
        endOFH.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    //////////////////////////////////////////////////////////////////////
    
    
    func donePressed03(_ sender: UIBarButtonItem) {
        dayOFH.resignFirstResponder()
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
        dayOFH.text = "Sunday"
        dayOFH.resignFirstResponder()
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
        dayOFH.text = days[row]
    }

}
