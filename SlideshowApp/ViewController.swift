//
//  ViewController.swift
//  SlideshowApp
//
//  Created by yxx3tch on 2018/02/10.
//  Copyright © 2018年 yxx3tch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var slideshowButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var imageNumber:Int = 3
    var imageName:[String] = ["1.jpg", "2.jpg", "3.jpg"]
    var selector:Int = 0
    var isPaused:Bool = false
    var image:UIImage!
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setImage(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if timer != nil {
            self.timer.invalidate()
            self.timer = nil
            isPaused = true
        }
        let imageViewController:ImageViewController = segue.destination as! ImageViewController
        imageViewController.image = UIImage(named: imageName[selector])
    }
    
    @IBAction func unwind (_ segue: UIStoryboardSegue) {
        if isPaused {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            isPaused = false
        }
    }
    
    @IBAction func sildeshow(_ sender: Any) {
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
            slideshowButton.setTitle("停止", for: UIControlState())
            backButton.isEnabled = false
            forwardButton.isEnabled = false
        } else {
            self.timer.invalidate()
            self.timer = nil
            slideshowButton.setTitle("再生", for: UIControlState())
            backButton.isEnabled = true
            forwardButton.isEnabled = true
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.selector = (self.selector != 0) ? self.selector - 1 : imageNumber - 1
        setImage(self.selector)
    }

    @IBAction func forward(_ sender: Any) {
        self.selector = (self.selector != imageNumber - 1) ? self.selector + 1 : 0
        setImage(self.selector)
    }
    
    @objc func changeImage() {
        self.selector = (self.selector != imageNumber - 1) ? self.selector + 1 : 0
        setImage(self.selector)
    }
    
    func setImage(_ selector:Int) {
        image = UIImage(named: imageName[selector])
        buttonImage.setImage(image, for: UIControlState())
    }
    
}

