//
//  ViewController.swift
//  GIAI_PHUONG_TRINH_BA2
//
//  Created by Hoaithuong on 2/27/1397 AP.
//  Copyright © 1397 AP hoaithuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var txta: UITextField!
    @IBOutlet weak var txtb: UITextField!
    @IBOutlet weak var txtc: UITextField!
    @IBOutlet weak var btnGiai: UIButton!
    @IBOutlet weak var lb_kq: UILabel!
    @IBOutlet weak var lb_x2: UILabel!
    
    @IBAction func btnDat(_ sender: Any) {
        txta.text=""
        txtb.text=""
        txtc.text=""
        lb_kq.text=""
        lb_x2.text=""
    }
    var a:Double = 0
    var b:Double = 0
    var c:Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //txta.isHidden=true
        //txtb.isHidden=true
        //txtc.isHidden=true
        txta.delegate=self
        txtb.delegate=self
        txtc.delegate=self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789-").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    //Kiem tra dau -
    func checkCharacter(character: String) -> Bool{
        let charIndex = character[character.index(character.startIndex, offsetBy: 0)]
        if (charIndex == "-"){
            var count: Int = 0;
            for charac in character.characters{
                if (charac == "-"){
                    count+=1;
                }
            }
            if (count > 1){
                return false;
            }
            else{
                return true;
            }
        }
        else{
            var count: Int = 0;
            for charac in character.characters{
                if (charac == "-"){
                    count+=1;
                }
            }
            if (count > 0){
                return false;
            }
            else{
                return true;
            }
        }
    }
    //Thuc hien tinh toan
    func solveEquation(){
        if (txta.text! == "" || txtb.text == "" || txtc.text == ""){
            //tao alert
            let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập 3 số!!!", preferredStyle: UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            lb_kq.isHidden = true
        }
        else if(txta.text! == "." || txtb.text == "." || txtc.text == "."){
            let alert = UIAlertController(title: "Thông báo", message: "Không đúng định dạng!!!", preferredStyle: UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            //show alert
            self.present(alert, animated: true, completion: nil);
            lb_kq.isHidden = true
        }
        else if(txta.text! == "-" || txtb.text == "-" || txtc.text == "-"){
            let alert = UIAlertController(title: "Thông báo", message: "Không đúng định dạng!!!", preferredStyle: UIAlertControllerStyle.alert);
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
            
            self.present(alert, animated: true, completion: nil);
            lb_kq.isHidden = true
        }
        else{
            if (!checkCharacter(character: txta.text!) || !checkCharacter(character: txtb.text!) || !checkCharacter(character: txtc.text!)){
                
                let alert = UIAlertController(title: "Thông báo", message: "Không đúng định dạng!!!", preferredStyle: UIAlertControllerStyle.alert);
               
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
               
                self.present(alert, animated: true, completion: nil);
                lb_kq.isHidden = true
            }
            else{
                a = Double(txta.text!)!;
                b = Double(txtb.text!)!;
                c = Double(txtc.text!)!;
                
                if a == 0{
                    if b == 0{
                        if c == 0 {
                            
                            lb_kq.text="Phương trình có vô số nghiệm"
                            
                        }
                        else{
                            
                            lb_kq.text="Phương trình vô nghiệm"
                            
                        }
                    }
                    else{
                        
                        lb_kq.text=String(format: "Phương trình có 1 nghiệm: x = %.1f", (-c/b))
                        
                    }
                }
                else{
                    let delta: Double = b*b - 4*a*c;
                    if (delta  < 0){
                        
                        
                        lb_kq.text = "Phương trình vô nghiệm"
                    }
                    else if (delta == 0){
                        lb_kq.text = String(format: "Phương có nghiệm kép: x = %.1f", (-b/(2*a)))
                        
                    }
                    else{
                        let sqrtDelta: Double = sqrt(Double(delta))
                        let x1: Double = (-b+sqrtDelta)/(2*a);
                        let x2: Double = (-b-sqrtDelta)/(2*a);
                        
                        lb_kq.text=String(format: "Phương trình có 2 nghiệm phân biệt:")
                        
                        
                        lb_kq.text = String (format: "x1 = %.1f",x1)
                        lb_x2.text = String (format: "x2 = %.1f",x2)
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func btnGiai(_ sender: Any) {
        lb_kq.isHidden = false
        solveEquation()
    }
    
    
}

