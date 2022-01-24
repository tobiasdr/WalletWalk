//
//  LoginVC.swift
//  WalletWalk
//
//  Created by Sarika scc on 18/01/22.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btn_signup: UIButton!
    @IBOutlet weak var btn_start: UIButton!
    @IBOutlet weak var btn_forgot: UIButton!
    @IBOutlet var txts: [UITextField]!
    @IBOutlet var TFViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TFViews.forEach({$0.cornerRadius = 6
            $0.setShadoCell()
        })
        
        btn_start.cornerRadius = 8
        btn_start.setImage(UIImage(named: "ic_next"), for: .normal)
        btn_start.setRightImage()
        btn_start.setAttributedTitle(setCustomFonToButton(mainString: "Start   ", fontfamily: Font_Roboto.bold, size: 16), for: .normal)
        
        btn_signup.titleLabel?.font = UIFont(name: Font_Roboto.bold, size: 17)
      
        btn_signup.setAttributedTitle(ChangeSubStringcolorAndFont(mainString: "Don’t have an account yet? Get on board!", colorString: "Get on board!", color: .red), for: .normal)
      
    }
 
    
    //MARK: textfiled delegate  method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func click_onSignupBtn(_ sender: Any) { // get on board
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpVC")as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func click_onStartBtn(_ sender: Any) {
        
        defaults.setValue(1, forKey: VHkey.login)
        setVCRoot(vcName: "MainTab", type: .tab)
    }
    

}
