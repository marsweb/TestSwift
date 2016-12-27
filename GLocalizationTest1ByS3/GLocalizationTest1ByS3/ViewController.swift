//
//  ViewController.swift
//  GLocalizationTest1ByS3
//
//  Created by 花生 on 27/12/2016.
//  Copyright © 2016年 ihuasheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var manImage: UIImageView!
    @IBOutlet weak var manText: UILabel!
    @IBOutlet weak var locationText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // LocationText
        let locale = NSLocale.current
        let currentLangID = Locale.preferredLanguages[0]
        let displayName = locale.localizedString(forLanguageCode: currentLangID)
        locationText.text = displayName?.capitalized(with: locale)
        
        // ManText
        manText.text = NSLocalizedString("DREAM_GUY", comment: "Dream guy")
        
        // ManImage
        manImage.image = UIImage(named: NSLocalizedString("DREAM_GUY_IMAGE", comment: "Name of Dream guy pic"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

