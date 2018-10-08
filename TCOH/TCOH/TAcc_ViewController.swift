//
//  TAcc_ViewController.swift
//  TCOH
//
//  Created by student on 11/15/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class TAcc_ViewController: UIViewController {
    
    

    @IBOutlet weak var T_img: UIImageView!
    @IBOutlet weak var T_Name: UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: backgroundName)
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        T_img.layer.borderWidth = 1.0
        T_img.layer.masksToBounds = false
        T_img.layer.borderColor = UIColor.white.cgColor
        T_img.layer.cornerRadius = T_img.frame.height/2
        T_img.clipsToBounds = true
        
    
        T_Name.text = teacherName
        get_image("http://iot.spu.ac.th/~comsci/comsci_tcoh/images/\(teacherImg)", T_img)
        // Do any additional setup after loading the view.

    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }*/
    
    @IBAction func saveSegue(segue : UIStoryboardSegue)
    {
        let vc = segue.source as! News_ViewController
        
        let myUrl = NSURL(string: Request_AddNews);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.setValue("multipart/form-data; boundary=\(boundary)",forHTTPHeaderField:"Content-Type")
        request.httpBody = Data()
        
        let param = [
            "courseId" : vc.sjpicker.text!,
            "antext" : vc.textview.text!,
            "teacherId" : teacherID
        ]
        
        print(RequestaddOH)
        print(vc.sjpicker.text!)
        print(vc.textview.text!)
        print(teacherID)
        
        if param.count > 0 {
            request.httpBody?.append(createBodyWithParameters(parameters: param))
        }
        
        var title = ""
        var message=""
        
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
                
                title = (jsonObj?["Alert"] as? String)!
                //message = (jsonObj?["Message"] as? String)!
                
                print(jsonObj?["Alert"] as! String)
                //print(jsonObj?["Message"] as! String)
            }catch{
                print("error=\(String(describing: error))")
            }
            
            if(title != "1"){
                DispatchQueue.main.async(execute: {
                    self.showAlert(title: "ไม่สามารถเพิ่มประกาศได้",message: message)
                });
            }else{
                DispatchQueue.main.async(execute: {
                    //self.showAlert(title: title,message: message)
                    //self.tableView.reloadData()
                    self.showAlert(title: "ประกาศเรียบร้อย",message: message)
                });
            }
        }
        task.resume()
    }

    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OKEY", style: .cancel , handler: nil)
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
