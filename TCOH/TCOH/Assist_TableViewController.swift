//
//  Assist_TableViewController.swift
//  TCOH
//
//  Created by student on 11/28/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class Assist_TableViewController: UITableViewController {
    
    var idimg = ""
    
    var indexRow:Int!
    
    var myData:NSArray = []
    func getJSONFromUrl(){
        RequestStuFromTeacher = "\(ip)/~comsci/comsci_tcoh/tc_select_st.php?teacherId=\(teacherID)"
        if let url = NSURL(string:RequestStuFromTeacher)
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
        print(RequestStuFromTeacher)
        getJSONFromUrl()
        let backgroundImage = UIImage(named: backgroundName)
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StuNCell", for: indexPath) as! Assist_TableViewCell

        if let data:[String:Any] = myData[indexPath.row] as? [String:Any]
        {
            let str = data["studentId"] as! String
            cell.stuName.text = data["studentName"] as? String
            cell.stuID.text = str
            cell.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
            //idimg =
            if let url = NSURL(string: "\(RequestImage)\(str).jpg"){
                if let data = NSData(contentsOf:url as URL){
                    if let image = UIImage(data: data as Data){
                        cell.img.image = image
                        
                    }
                }
            }
            
            cell.img.layer.borderWidth = 1.0
            cell.img.layer.masksToBounds = false
            cell.img.layer.borderColor = UIColor.black.cgColor
            cell.img.layer.cornerRadius = cell.img.frame.height/2
            cell.img.clipsToBounds = true
            
            //cell.agela.text = data["sOld"] as? String
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

}
