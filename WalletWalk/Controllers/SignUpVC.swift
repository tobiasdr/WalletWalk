//
//  SignUpVC.swift
//  WalletWalk
//
//  Created by Sarika scc on 20/01/22.
//

import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var lbl_terms: UILabel!
    @IBOutlet weak var btn_terms: UIButton!
    @IBOutlet weak var btn_signup: UIButton!
    @IBOutlet var txts: [UITextField]!
    @IBOutlet var TViews: [UIView]!
    @IBOutlet weak var lbl_info: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_terms.setImage(UIImage(named: "ic_unchecked")?.withRenderingMode(.alwaysOriginal), for: .normal)

        TViews.forEach({$0.cornerRadius = 6
            $0.setShadoCell()
        })
        
        txts.forEach({$0.delegate = self})
        btn_terms.setTitle("", for: .normal)
        
        btn_signup.cornerRadius = 8
        btn_signup.setImage(UIImage(named: "ic_next"), for: .normal)
        btn_signup.setRightImage()
        btn_signup.setAttributedTitle(setCustomFonToButton(mainString: "Sign up   ", fontfamily: Font_Roboto.bold, size: 16), for: .normal)
        
        btn_login.setAttributedTitle(ChangeSubStringcolorAndFont(mainString: "Already have an account? Login", colorString: "Login", color: .red), for: .normal)
        btn_login.titleLabel?.font = UIFont(name: Font_Roboto.bold, size: 17)
        
        lbl_terms.attributedText =  ChangeSubStringcolor(mainString: "I have read and agree to the terms and conditions", colorString: "terms and conditions", color: .red)
        
        lbl_info.addImage(imageName: "ic_ninja",afterLabel: true)
       
       
    }
    
    @IBAction func click_onTermsBtn(_ sender: UIButton) {
        
        let checked = UIImage(named: "ic_checked")?.withRenderingMode(.alwaysOriginal)
        let unhecked = UIImage(named: "ic_unchecked")?.withRenderingMode(.alwaysOriginal)
        
        if sender.image(for: .normal) == checked {
            
            sender.setImage(unhecked, for: .normal)
        }
        else
        {
            sender.setImage(checked, for: .normal)
        }
    }
    
    @IBAction func click_onSignupBtn(_ sender: Any) {
        
        defaults.setValue(1, forKey: VHkey.login)
        setVCRoot(vcName: "MainTab", type: .tab)
    }
    
    @IBAction func click_onLoginBtn(_ sender: Any) {
        
        self.goBack()
    }
    
}
