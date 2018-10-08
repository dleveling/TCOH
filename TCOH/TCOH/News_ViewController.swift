//
//  News_ViewController.swift
//  TCOH
//
//  Created by student on 11/22/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class News_ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var sjpicker: UITextField!
    var i = 0
    var myData:NSArray = []
    
    let picker = UIDatePicker()
    var course = [String]()
    
    
    func getJSONFromUrl(){
        Request_SJ_News = "\(ip)/~comsci/comsci_tcoh/selectCourse.php?teacherId=\(teacherID)"
        if let url = NSURL(string:Request_SJ_News)
        {
            if let data = NSData(contentsOf:url as URL)
            {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)  as? NSArray
                {
                    self.myData = jsonObj!
                    while i < myData.count{
                    if let data:[String:Any] = myData[i] as? [String:Any]{
                            //course[i] = data["courseId"] as! String
                            course.append(data["courseId"] as! String)
                            print(course[i])
                    }
                    i=i+1
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONFromUrl()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: backgroundName)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
                
        textview.layer.borderWidth = 1.0
        textview.layer.masksToBounds = false
        textview.layer.borderColor = UIColor.black.cgColor
        textview.layer.cornerRadius = textview.frame.height/50
        textview.clipsToBounds = true
        // Do any additional setup after loading the view.
        ////////////////////////////////////////////////
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        sjpicker.inputView = pickerView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(add_SJ_ViewController.donePressed03))
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.textAlignment = NSTextAlignment.center
        
        toolBar.setItems([doneButton], animated: true)
        
        sjpicker.inputAccessoryView = toolBar
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
    
    func donePressed03(_ sender: UIBarButtonItem) {
        sjpicker.resignFirstResponder()
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        
        sjpicker.text = "Sunday"
        sjpicker.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return course.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return course[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sjpicker.text = course[row]
    }


}
