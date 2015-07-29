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
    var options = BusyNavigationBarOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentChanged(sender: AnyObject) {
        self.options = BusyNavigationBarOptions()

        switch animationType.selectedSegmentIndex {
        case 0:
            options.animationType = .Stripes
        case 1:
            options.animationType = .Bars
        case 2:
            options.animationType = .CustomLayer(birdLayer)
            options.transparentMaskEnabled = false
        default:
            options.animationType = .Stripes
        }

        self.navigationController?.navigationBar.start(options)

    }

    @IBAction func startDidTap(sender: AnyObject) {
        self.navigationController?.navigationBar.start(options)
    }

    @IBAction func stopDidTap(sender: AnyObject) {
        self.navigationController?.navigationBar.stop()
    }

    // A sample layer with sliding birds
    func birdLayer() -> CALayer {
        let bounds = self.navigationController?.navigationBar.bounds
        let gap: CGFloat = 100
        let numberOfBirds = Int(bounds!.width / gap)
        let image = UIImage(named: "swift-bird")?.CGImage

        let container = CALayer()
        container.bounds = bounds!
        container.position = CGPoint(x: 0, y:0)

        for i in 0..<numberOfBirds {
            let swiftBird = CALayer()
            swiftBird.contents = image
            swiftBird.frame = CGRect(x: 0, y: 0, width: CGImageGetWidth(image)/2, height: CGImageGetHeight(image)/2)
            container.addSublayer(swiftBird)

            let path = UIBezierPath()
            let x = i * Int(gap) - 50
            let y = i % 2 == 0 ? -100 : -80
            path.moveToPoint(CGPoint(x: x, y: y))
            path.addLineToPoint(CGPoint(x: x + 200, y: y + 200))

            let animation = CAKeyframeAnimation(keyPath: "position")
            animation.path = path.CGPath
            animation.duration = 1
            animation.repeatCount = Float.infinity
            swiftBird.addAnimation(animation, forKey: nil)
        }

        return container
    }
}

