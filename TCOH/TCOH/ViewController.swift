//
//  ViewController.swift
//  TCOH
//
//  Created by student on 11/15/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var loding: UIActivityIndicatorView!
    @IBOutlet weak var loadbar: UIProgressView!
    
    var id = ""
    var pass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: backgroundName)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Login(_ sender: Any) {
        /*if userBox.text == "1"{
            self.navigationController!.show(self.storyboard!.instantiateViewController(withIdentifier: "mainmenu") as UIViewController, sender: self)
        }RequestLogin*/
        
        var title = ""
        var title2 = ""
        var message = ""
        loding.startAnimating()
        
        if userBox.text == "" {
            title = "Error"
            message = "กรุณาใส่รหัสบุคลากร"
            self.showAlert(title: title, message: message)
            
            return
        }else {
            id = userBox.text!
        }
        if passBox.text == "" {
            title = "Error"
            message = "กรุณาใส่รหัสบุคลากร"
            self.showAlert(title: title, message: message)
            
            return
        }else {
            pass = passBox.text!
        }
        
        
        let myUrl = NSURL(string: RequestLogin);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        
        request.httpMethod = "POST";
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = Data()
        
        let param = [
            "teacherId": id,
            "teacherPass" : pass
        ]
        
        if param.count > 0 {
            request.httpBody?.append(createBodyWithParameters(parameters: param))
        }
        
        //////////////////////////////////////////////////////////////
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error=\(String(describing: error))")
                title = "Error"
                message = "error=\(String(describing: error))"
                return
            }
            do{
                let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
                
                title2 = (jsonObj?["Alert"] as? String)!
                if(title2 == "1"){
                    teacherName = (jsonObj?["teacherName"] as? String)!
                    teacherImg = (jsonObj?["teacherImg"] as? String)!
                    print(jsonObj?["teacherName"] as! String)
                    print(teacherName)
                    print(teacherImg)
                }
                print(jsonObj?["Alert"] as! String)
            }catch{
                print("error=\(String(describing: error))")
            }

            
            if(title2 != "1"){
                DispatchQueue.main.async(execute: {
                    self.showAlert(title: "ชื่อผู้ใช้ หรือรหัสผ่านไม่ถูกต้อง",message: message)
                });
            }else{
                DispatchQueue.main.async(execute: {
                self.loding.stopAnimating()
                teacherID = self.id
                self.navigationController!.show(self.storyboard!.instantiateViewController(withIdentifier: "mainmenu") as UIViewController, sender: self)
                });
            }
            
        }
        task.resume()

        
    }
    
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "Close", style: .cancel , handler: nil)
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
        self.loding.stopAnimating()
        
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */



}

