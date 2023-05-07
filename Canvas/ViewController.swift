//
//  ViewController.swift
//  Canvas
//
//  Created by Muhammed Shatara on 05/05/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// First Test
        
        let firstTest: [GaugeMeterData] = [GaugeMeterData(image: "cloud.drizzle.fill", score: 0.3), GaugeMeterData(image: "thermometer.sun.circle.fill", score: 0.6), GaugeMeterData(image: "airplane", score: 0.15) , GaugeMeterData(image: "car.fill", score: 0.8), GaugeMeterData(image: "figure.strengthtraining.traditional", score: 0.4), GaugeMeterData(image: "figure.tennis", score: 0.58), GaugeMeterData(image: "heart.fill", score: 1), GaugeMeterData(image: "figure.stair.stepper", score: 0.7)]
        
        let customView = MyCustomView(frame: view.bounds, levels: 8, sectors: 8,  levelsColor: [.brown,.purple,.red,.orange,.green,.magenta, .systemTeal, .yellow], items: firstTest, label: "First Test")
        
        /// -----------------------------------------------------
        /// Second Test
        
        /// let secTest: [GaugeMeterData] = [GaugeMeterData(image: "cloud.drizzle.fill", score: 0.1), GaugeMeterData(image: "thermometer.sun.circle.fill", score: 0.4), GaugeMeterData(image: "airplane", score: 0.74)]
        
        /// let customView = MyCustomView(frame: view.bounds,  levels: 6, sectors: 3,  levelsColor: [.brown,.purple,.red,.orange,.green, .cyan],items: secTest,label: "Second Test")
        
        /// -------------------------------------------------------------
        
        
        /**
         A Boolean value that indicates whether to use custom colors for the view.
         
         If this property is set to true, the view will use the colors provided in the `levelsColor` array to draw its elements.
         
         If this property is set to false, the view will always use its default color scheme.
         **/
        
        customView.manualColor = true
        
        customView.startAngle = -210
        customView.endAngle = 30
        customView.offColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 0.5)
        
        ///        customView.maxRed = 23
        ///        customView.maxBlue = 153
        ///        customView.maxGreen = 90
        
        
        view.addSubview(customView)
    }
    
    
}

