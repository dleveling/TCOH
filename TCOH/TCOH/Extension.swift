//
//  Extension.swift
//  TCOH
//
//  Created by student on 11/28/2560 BE.
//  Copyright © 2560 student. All rights reserved.
//
import UIKit
import Foundation
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
var myDataSJ:NSArray = []
let maxLengthSubjectID = 6
var teacherName = ""
var teacherImg = ""
var teacherID = ""
var CourseDetail = ""
var CourseID = ""
var backgroundName = "22.jpg"


let boundary = "Boundary-\(NSUUID().uuidString)"

let ip = "http://iot.spu.ac.th"
var RequestLogin = "\(ip)/~comsci/comsci_tcoh/checkUser.php"
var RequestImage = "\(ip)/~comsci/comsci_tcoh/images/"
var RequestStuFromTeacher = "\(ip)/~comsci/comsci_tcoh/tc_select_st.php?teacherId=\(teacherID)"
var RequestaddCourse = "\(ip)/~comsci/comsci_tcoh/addCourse.php"
var RequestTCCourse = "\(ip)/~comsci/comsci_tcoh/tc_course.php?teacherId=\(teacherID)"
var RequestCourseDetail = "\(ip)/~comsci/comsci_tcoh/course.php?courseId=\(CourseID)"
var RequestOFH = "\(ip)/~comsci/comsci_tcoh/selectOH.php?teacherId=\(teacherID)"
var RequestaddOH = "\(ip)/~comsci/comsci_tcoh/addOH.php"
var Request_SJ_News = "\(ip)/~comsci/comsci_tcoh/selectCourse.php?teacherId=\(teacherID)"
var Request_AddNews = "\(ip)/~comsci/comsci_tcoh/addAnnounce.php"
var Request_Pmlist = "\(ip)/~comsci/comsci_tcoh/pmlist.php?teacherId=\(teacherID)"


func createBodyWithParameters(parameters: [String: String]?) -> Data{
    let body = NSMutableData()
    if parameters != nil{
        for (key,value) in parameters!{
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
        body.appendString(string: "--\(boundary)--\r\n")
    }
    return body as Data
}

func createBodyWithParameters(filePathKey: String, filename: String,imageDataKey:Data)-> Data{
    let body = NSMutableData()
    let mimetype = "image/jpg"
    
    body.appendString(string: "--\(boundary)\r\n")
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey)\";filename=\"\(filename)\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey)
    body.appendString(string: "\r\n")
    body.appendString(string: "--\(boundary)--\r\n")
    
    return body as Data
}

func get_image(_ url_str:String, _ imageView:UIImageView)
{
    
    let url:URL = URL(string: url_str)!
    let session = URLSession.shared
    
    let task = session.dataTask(with: url, completionHandler: {
        (
        data, response, error) in
        
        
        if data != nil
        {
            let image = UIImage(data: data!)
            
            if(image != nil)
            {
                
                DispatchQueue.main.async(execute: {
                    
                    imageView.image = image
                    imageView.alpha = 0
                    
                    UIView.animate(withDuration: 2.5, animations: {
                        imageView.alpha = 1.0
                    })
                    
                })
                
            }
            
        }
        
        
    })
    
    task.resume()
}

func getJSONFromUrlSubject(){
    
    RequestCourseDetail = "\(ip)/~comsci/comsci_tcoh/course.php?courseId=\(CourseID)"
    print(RequestCourseDetail)
    
    if let url = NSURL(string:RequestCourseDetail)
    {
        if let data = NSData(contentsOf:url as URL)
        {
            if let jsonObj = try? JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)  as? NSArray
            {
                
                print(RequestCourseDetail)
                myDataSJ = jsonObj!
                
                if let data:[String:Any] = myDataSJ[0] as? [String:Any]
                {
                    CourseDetail = (data["courseName"] as? String)!
                    CourseID = ""
                }
                
            }
        }
    }
}


