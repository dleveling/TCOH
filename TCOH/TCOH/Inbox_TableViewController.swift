//
//  Inbox_TableViewController.swift
//  TCOH
//
//  Created by student on 11/28/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//

import UIKit

class Inbox_TableViewController: UITableViewController {
    
    var indexRow:Int!
    
    var myData:NSArray = []
    func getJSONFromUrl(){
        Request_Pmlist = "\(ip)/~comsci/comsci_tcoh/pmlist.php?teacherId=\(teacherID)"
        if let url = NSURL(string:Request_Pmlist)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MycELL", for: indexPath) as! Inbox_TableViewCell

        if let data:[String:Any] = myData[indexPath.row] as? [String:Any]
        {
            cell.id.text = data["studentId"] as? String
            cell.name.text = data["studentName"] as? String
            cell.message.text = data["message"] as? String
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

}
