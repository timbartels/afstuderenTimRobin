//
//  Popup.swift
//  codeKlojo
//
//  Created by Robin Woudstra on 28-02-17.
//  Copyright © 2017 Tim Bartels. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Popup: NSObject {
    let knop:UIButton = UIButton()
    let popupbox = UIView()
    
    func showPopupForMission(mission: String, view: UIView){
        
        missie = mission
        
        self.popupbox.frame = CGRect(x: 0, y: Int(Responsive.getHeightScreen()), width:Int(Responsive.getWidthScreen()), height: 250)
        self.popupbox.backgroundColor = UIColor.white
        self.popupbox.layer.borderWidth = 5
        self.popupbox.isUserInteractionEnabled = true
        
        view.addSubview(popupbox)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.popupbox.frame = self.popupbox.frame.offsetBy(dx: 0.0, dy: -self.popupbox.bounds.height)
        }, completion: { finished in
            
        })
        
        // Add text to popup
        let text = UILabel(frame: CGRect(x: 50, y: 0, width: 400, height: 100))
        text.textAlignment = NSTextAlignment.center
        text.text = "Uitleg voor programmeeropdracht: \(mission)"
        
        self.popupbox.addSubview(text)
        
        self.knop.frame = CGRect(x: 700, y: 100, width: 100, height: 80)
        self.knop.backgroundColor = .red
        self.knop.setTitle("Button", for: .normal)
        self.knop.isUserInteractionEnabled = true
        
        // Cannot select method from Popup class for some wierd reason
        //self.knop.addTarget(self, action:#selector(GameViewController().goToMission(sender:)), for: .touchUpInside)
        knop.addTarget(self, action: #selector(self.functie), for: .touchDown)
        popupbox.addSubview(knop)
        
    }
    
    func functie(){
        print("doe iets")
    }
    
    @objc func closePopupForMission(){
        print("remove popup")
        
        // Cannot fetch self.popupbox when function is called from gameviewcontroller class for some wierd reason
        popupbox.removeFromSuperview()
    }

}


