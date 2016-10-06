//
//  ViewController.swift
//  BusyNavigationBar
//
//  Created by Gunay Mert Karadogan on 27/7/15.
//
//


import UIKit
//import BusyNavigationBar

class ViewController: UIViewController {

    @IBOutlet weak var animationType: UISegmentedControl!
    var options = BusyNavigationBarOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentChanged(_ sender: AnyObject) {
        self.options = BusyNavigationBarOptions()

        switch animationType.selectedSegmentIndex {
        case 0:
            options.animationType = .stripes
        case 1:
            options.animationType = .bars
        case 2:
            options.animationType = .customLayer(birdLayer)
            options.transparentMaskEnabled = false
        default:
            options.animationType = .stripes
        }

        self.navigationController?.navigationBar.start(options)

    }

    @IBAction func startDidTap(_ sender: AnyObject) {
        self.navigationController?.navigationBar.start(options)
    }

    @IBAction func stopDidTap(_ sender: AnyObject) {
        self.navigationController?.navigationBar.stop()
    }

    // A sample layer with sliding birds
    func birdLayer() -> CALayer {
        let bounds = self.navigationController?.navigationBar.bounds
        let gap: CGFloat = 100
        let numberOfBirds = Int(bounds!.width / gap)
        let image = UIImage(named: "swift-bird")?.cgImage

        let container = CALayer()
        container.bounds = bounds!
        container.position = CGPoint(x: 0, y:0)

        for i in 0..<numberOfBirds {
            let swiftBird = CALayer()
            swiftBird.contents = image
            swiftBird.frame = CGRect(x: 0, y: 0, width: image!.width/2, height: image!.height/2)
            container.addSublayer(swiftBird)

            let path = UIBezierPath()
            let x = i * Int(gap) - 50
            let y = i % 2 == 0 ? -100 : -80
            path.move(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: x + 200, y: y + 200))

            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = path.cgPath
            animation.duration = 1
            animation.repeatCount = Float.infinity
            swiftBird.add(animation, forKey: nil)
        }

        return container
    }

    func changeNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.24, green:0.59, blue:0.88, alpha:1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
}

