//
//  OFH_Table_TableViewController.swift
//  TCOH
//
//  Created by student on 12/14/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class OFH_Table_TableViewController: UITableViewController {
    
    var indexRow:Int!
    
    var myData:NSArray = []
    func getJSONFromUrl(){
        RequestOFH = "\(ip)/~comsci/comsci_tcoh/selectOH.php?teacherId=\(teacherID)"
        if let url = NSURL(string:RequestOFH)
        {
            if let data = NSData(contentsOf:url as URL)
            {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)  as? NSArray
                {
                    self.myData = jsonObj!
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONFromUrl()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let backgroundImage = UIImage(named: backgroundName)
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OFHTableCell", for: indexPath) as! OFH_TableViewCell

        if let data:[String:Any] = myData[indexPath.row] as? [String:Any]
        {
            cell.dayOFH.text = data["date"] as? String
            cell.timeOFH.text = (data["beginTime"] as? String)!+" น."+" - "+(data["endTime"] as? String)!+" น."
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveSegue(segue : UIStoryboardSegue)
    {
        let vc = segue.source as! OFH_ViewController
        
        let myUrl = NSURL(string: RequestaddOH);
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        request.setValue("multipart/form-data; boundary=\(boundary)",forHTTPHeaderField:"Content-Type")
        request.httpBody = Data()
        
        let param = [
            "beginTime" : vc.beginOFH.text!,
            "endTime" : vc.endOFH.text!,
            "date" : vc.dayOFH.text!,
            "teacherId" : teacherID
        ]
        
        print(RequestaddOH)
        print(vc.beginOFH.text!)
        print(vc.endOFH.text!)
        print(vc.dayOFH.text!)
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
                    self.showAlert(title: "ไม่สามารถเพิ่มเวลา",message: message)
                });
            }else{
                DispatchQueue.main.async(execute: {
                    //self.showAlert(title: title,message: message)
                    //self.tableView.reloadData()
                    self.getJSONFromUrl()
                    self.tableView.reloadData()
                });
            }
        }
        getJSONFromUrl()
        task.resume()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getJSONFromUrl()
        self.tableView.reloadData()
    }
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let btn = UIAlertAction(title: "OKEY", style: .cancel , handler: nil)
        alert.addAction(btn)
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
