//
//  MenuOption.swift
//  Side Menu Bar prog
//
//  Created by Admin on 26/11/22.
//
import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Home
    case Language
    case Download
    case Setting
    
    var description: String{
        switch self{
            
        case .Home: return "Profile"
        case .Language: return "Inbox"
        case .Download: return "Notification"
        case .Setting: return "Setting"
        }
    }
    var image: UIImage{
        switch self{
            
        case .Home: return UIImage(named: "home") ?? UIImage()
        case .Language: return UIImage(named: "language") ?? UIImage()
        case .Download: return UIImage(named: "download") ?? UIImage()
        case .Setting: return UIImage(named: "setting") ?? UIImage()
        }
    }
}
