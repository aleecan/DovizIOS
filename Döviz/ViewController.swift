//
//  ViewController.swift
//  Döviz
//
//  Created by Lee on 3.06.2018.
//  Copyright © 2018 Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var euroLabel: UILabel!
    
    @IBOutlet weak var gbpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh(true)
    
    }
    @IBAction func refresh(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=bedd182e281dcd88be2a54045574bffd")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else {
                if data != nil {
                    do{
                        let jSONResult = try
                        JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        DispatchQueue.main.async{
                            let rates  = jSONResult["rates"] as!
                                [String:AnyObject]
                            print(rates)
                            let gbp = String(describing: rates["GBP"]!)
                            self.gbpLabel.text = gbp
                            let usd = String(describing: rates["USD"]!)
                            self.usdLabel.text = usd
                            let euro = String(describing: rates["EUR"]!)
                            self.euroLabel.text = euro
                        }
                    } catch{
                        
                    }
                }
            }
        }
        
        task.resume()
        
        
    }
    
}

