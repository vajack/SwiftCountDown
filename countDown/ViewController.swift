//
//  ViewController.swift
//  countDown
//
//  Created by IkegamiYuki on 8/18/15.
//  Copyright (c) 2015 IkegamiYuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var restTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTime()
        var timer = NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: "targetTime", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func targetTime(){
        let tyear = 2015
        let tmonth = 12
        let tday = 28
        getTime()
        restLabel.text = restTime(tyear,tmonth: tmonth,tday: tday)
        
        var str = "\(tyear)年"
        str += "\(tmonth)月"
        str += "\(tday)日まであと"
        
        restTitle.text = str
    }
    
    func restTime(tyear:Int,tmonth:Int,tday:Int) -> String{
        
        let nowDate:NSDate = NSDate()
        
        let nowCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let nowComponents = nowCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday], fromDate: nowDate)
        
        var restYear:Int,restMonth:Int,restDay:Int,restHour:Int,restMin:Int,restSec:Int
       
        //change this
        if((tyear <= nowComponents.year) && (tmonth <= nowComponents.month) && (tday <= nowComponents.day)){
            restYear = 0
            restMonth = 0
            restDay = 0
            restHour = 0
            restMin = 0
            restSec = 0
        }else{
            
            if(((tyear - nowComponents.year) == 1) && (tmonth <= nowComponents.month) && (tday < nowComponents.day)){
                restYear = 0
            }else{
                restYear = tyear - Int(nowComponents.year)
            }
            restMonth = tmonth - Int(nowComponents.month)
            restDay = tday - Int(nowComponents.day) - 1
            restHour = 23 - Int(nowComponents.hour)
            restMin = 59 - Int(nowComponents.minute)
            restSec = 59 - Int(nowComponents.second)
        }
        
        var rstr = "\(restYear)年"
        rstr += "\(monthToDate(tyear, tmonth: tmonth, tday: tday))日"
        rstr += "\(restHour)時間"
        rstr += "\(restMin)分"
        rstr += "\(restSec)秒です"
        
        return rstr
    }

    
    func getTime(){
        let nowDate:NSDate = NSDate()
        
        let nowCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        
        let nowComponents = nowCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday], fromDate: nowDate)
        
        let weekdayStr: Array = ["","月","火","水","木","金","土","日"]
        
        var myStr:String = "\(nowComponents.year)年"
        myStr += "\(nowComponents.month)月"
        myStr += "\(nowComponents.day)日["
        myStr += "\(weekdayStr[nowComponents.weekday])]"
        myStr += "\(nowComponents.hour)時"
        myStr += "\(nowComponents.minute)分"
        myStr += "\(nowComponents.second)秒"
        
        myLabel.text = myStr
    }
    
    func monthToDate(tyear:Int,tmonth:Int,tday:Int)->Int{

        var dateNum = tday
        var countYear = tyear
        var countMonth = tmonth
        
        
        //get future time
        var dateStr = "\(countYear)-\(countMonth)-\(tday)"
        let date_fomatter:NSDateFormatter = NSDateFormatter()
        date_fomatter.locale = NSLocale(localeIdentifier: "ja")
        date_fomatter.dateFormat = "yyyy/MM/dd"
        let fuDate:NSDate = date_fomatter.dateFromString(dateStr)!
        
        date_fomatter.stringFromDate(fuDate)
        
        let fuCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let fuComponents = fuCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: fuDate)
        
        //get now time
        let nowDate:NSDate = NSDate()
        let nowCalendar:NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let nowComponents = nowCalendar.components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day] , fromDate: nowDate)
        let nowDays = nowCalendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: nowDate)
        
        while(!((countYear == nowComponents.year) && (countMonth-1 == nowComponents.month))){
            dateStr = "\(countYear)-\(countMonth)-\(tday)"
            date_fomatter.dateFromString(dateStr)
            date_fomatter.stringFromDate(fuDate)

            let days = fuCalendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: fuDate)
            
            dateNum += days.length
            
            if (countMonth == 1){
                countMonth = 12
                countYear--
            }else{
                countMonth--
            }
            
        }
        
        var restDays = 0
        restDays = nowDays.length - nowComponents.day - 1
        dateNum += restDays
        
        return dateNum
    }

}

