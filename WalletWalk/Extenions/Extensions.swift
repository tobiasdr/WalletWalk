//
//  Extensions.swift
//  WalletWalk
//
//  Created by Sarika scc on 18/01/22.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

var appTxtColor = UIColor(named: "appTxtColor") //

struct VHkey {
    
    static let login : String = "login"
    static let startDate : String = "startDate"
}

struct Font_Roboto {
    
    static let regular : String = "Roboto-Regular"
    static let black : String = "Roboto-Black"
    static let medium : String = "Roboto-Medium"
    static let bold : String = "Roboto-Bold"
    static let light : String = "Roboto-Light"
    static let thin : String = "Roboto-Thin"
    static let italic : String = "Roboto-Italic"
}



extension UIButton {
    
    func setRightImage(){
        
        self.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }
}


// - - - - - - - - - - - - - - - -
// MARK: 📍 Extension - UIView 📌
// - - - - - - - - - - - - - - - -

extension UIView {
   
  
    var vHeight : CGFloat {
        
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    
    var vWidth : CGFloat {
        
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
    
    var XPOINT : CGFloat {
        
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    
    var YPOINT : CGFloat {
        
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    
    var cornerRadius : CGFloat {
        
        get { return  self.layer.cornerRadius }
        set {  self.layer.cornerRadius = newValue }
    }
    
    func setBorderAndCorner(_ BS:CGFloat,color:UIColor,CS:CGFloat) {
        
        self.layer.cornerRadius = CS
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = BS
        self.clipsToBounds = true
    }
   
    func setShadoCell() {
        
        let layer = self.layer
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        layer.shadowOpacity = 0.35
        layer.shadowRadius = 3
        layer.masksToBounds = false
    }
       

}



// - - - - - - - - - - - - - - - - - -
// MARK: 📍 Extension - UIViewController 📌
// - - - - - - - - - - - - - - - - - -

extension UIViewController {
    
    
    func goBack() {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
   
    
    func LogoutPopUp() {
        
        let alert = UIAlertController(title: "Logout", message: "Are your sure you want to logout from this app?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "No", style: .default)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            
            DispatchQueue.main.async {
                
                timer.invalidate()
                defaults.removeObject(forKey: VHkey.login)
                defaults.removeObject(forKey: VHkey.startDate)
                setVCRoot(vcName: "LoginNavi", type: .navi)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // set statusbar color
    
}

extension UILabel{
    
    func addImage(imageName: String, afterLabel bolAfterLabel: Bool = false)
    {
        let attachment: NSTextAttachment = NSTextAttachment()
        let img = UIImage(named: imageName)
        attachment.image = img
        
        let lFontSize = round(self.font.pointSize * 1.32)
        let lRatio = img!.size.width / img!.size.height
        
        attachment.bounds = CGRect(x: 0, y: ((self.font.capHeight - lFontSize) / 2).rounded(), width: (lRatio * lFontSize) - 2, height: 18)
        
        
        let attachmentString: NSAttributedString = NSAttributedString(attachment: attachment)
        
        if (bolAfterLabel)
        {
           
            let strLabelText: NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        }
        else
        {
           
            let mutableAttachmentString = NSMutableAttributedString(string: "")
            mutableAttachmentString.append(attachmentString)
            mutableAttachmentString.append(NSAttributedString(string: "  \(self.text!)"))
            self.attributedText = mutableAttachmentString
        }
    }

}


enum RootType {
 
    case navi
    case tab
}

func setVCRoot(vcName:String, type: RootType){
    
    DispatchQueue.main.async {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if type == .navi {
            
            let vc = storyboard.instantiateViewController(withIdentifier: vcName) as! UINavigationController
            appDelegate.window?.rootViewController = vc
        }
        else if type == .tab {
            
            let vc = storyboard.instantiateViewController(withIdentifier: vcName) as! UITabBarController
            vc.selectedIndex = 0
            appDelegate.window?.rootViewController = vc
        }
        
        appDelegate.window?.makeKeyAndVisible()
        
    }
}

func ChangeSubStringcolorAndFont(mainString:String,colorString:String,color:UIColor) -> NSAttributedString {
    
    let range = (mainString as NSString).range(of: colorString)
    let subrange = (mainString as NSString).range(of: mainString)
    
    let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    
    mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: Font_Roboto.medium, size: 17)!, range: subrange)

    return mutableAttributedString
    
}

func ChangeSubStringcolor(mainString:String,colorString:String,color:UIColor) -> NSAttributedString {
    
    let range = (mainString as NSString).range(of: colorString)
    let subrange = (mainString as NSString).range(of: mainString)
    
    let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    
    mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)

    return mutableAttributedString
    
}

func setCustomFonToButton(mainString:String,fontfamily:String,size:CGFloat) -> NSAttributedString {
    
    let range = (mainString as NSString).range(of: mainString)
    _ = (mainString as NSString).range(of: mainString)
    
    let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    
    mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontfamily, size: size)!, range: range)
    
    return mutableAttributedString
    
}

func setCustomFontToLabel(mainString:String,subString:String,fontfamily:String,size:CGFloat) -> NSAttributedString {
    
    let range = (mainString as NSString).range(of: subString)
   _ = (mainString as NSString).range(of: mainString)
    
    let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
    mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: fontfamily, size: size)!, range: range)

    return mutableAttributedString
}

func hexStringToUIColor (hex:String) -> UIColor {
    
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func isImageDark(image:UIImage) -> Bool {
    
    guard let cgImage = image.cgImage else {
        
        print("no cgImage created")
        return false
    }
    
    guard let imageData = cgImage.dataProvider?.data else { return false }
    guard let ptr = CFDataGetBytePtr(imageData) else { return false }
    
    let length = CFDataGetLength(imageData)
    
    let threshold = Int(Double(cgImage.width * cgImage.height) * 0.45)
    
    var darkPixels = 0
    
    for i in stride(from: 0, to: length, by: 4) {
        let r = ptr[i]
        let g = ptr[i + 1]
        let b = ptr[i + 2]
        let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
        if luminance < 150 {
            darkPixels += 1
            if darkPixels > threshold {
                return true
            }
        }
    }
   
    return false
}
