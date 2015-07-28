//
//  ViewController.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 27/7/15.
//
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var animationType: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showDidTap(sender: AnyObject) {

        let options = BusyNavigationBarOptions()

        switch animationType.selectedSegmentIndex {
        case 0:
            options.animationType = .Stripes
        case 1:
            options.animationType = .Bars
        case 2:
            options.animationType = .CustomLayer(CALayer())
        default:
            println("stripes")
        }

        self.navigationController?.navigationBar.start(options)

        // alpha
        // color
        // animation speed
        // give your animation layer
        // give your pattern image so I move it around
        // changing title with an animation
        // provide a static function, which finds the navigation bar in the viewcontroller.

        // 2. bar animation
        // 3. wave animation
        // 4. swift bird animation
    }

    @IBAction func stopDidTap(sender: AnyObject) {
        self.navigationController?.navigationBar.stop()
    }
}

