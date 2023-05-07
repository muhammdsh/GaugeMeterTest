//
//  MyCustomView.swift
//  Canvas
//
//  Created by Muhammed Shatara on 05/05/2023.
//

import UIKit


@IBDesignable
class MyCustomView: UIView {
    
    var rows: Int
    var columns: Int
    var startAngle: CGFloat = -210
    var endAngle: CGFloat = 30
    var rowGapArc: CGFloat = 4
    var columnGap: CGFloat = 15
    var maxRed: CGFloat = 115
    var maxGreen: CGFloat = 70
    var maxBlue: CGFloat = 180
    var levelsColor: [UIColor]
    var offColor = UIColor(red: 40/255, green: 0/255, blue: 30/255, alpha: 0.5)
    var lineWidth: CGFloat = 8
    var sectionImage: [String]
    var score: [Int]
    var manualColor: Bool = false
    var label: String
    
    init(frame: CGRect, levels rows: Int, sectors columns: Int, levelsColor: [UIColor], items: [GaugeMeterData], label: String) {
        
        self.score = items.map({ item in
            return Int((item.score * CGFloat(rows)).rounded(.up))
        })
        
        self.sectionImage = items.map({ item in
            return item.image
        })
        
        self.levelsColor = levelsColor
        self.columns = columns
        self.rows = rows
        self.label = label
        
        assert(score.count == columns, "The length of the score array must be equal to the number of sectors.")
        assert(sectionImage.count == columns, "The length of the sectionImage array must be equal to the number of sectors.")
        assert(levelsColor.count == rows, "The length of the levelsColor array must be equal to the number of levels.")
        for s in score {
            assert(s > 0 && s <= rows, "The score value must be between 0 and \(rows - 1).")
        }
        
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rows = aDecoder.decodeInteger(forKey: "rows")
        self.columns = aDecoder.decodeInteger(forKey: "columns")
        self.label = aDecoder.decodeObject(forKey: "label") as? String ?? ""
        self.score = aDecoder.decodeObject(forKey: "score") as? [Int] ?? []
        self.sectionImage = aDecoder.decodeObject(forKey: "sectionImage") as? [String] ?? []
        self.levelsColor = aDecoder.decodeObject(forKey: "levelsColor") as? [UIColor] ?? []
        
        super.init(coder: aDecoder)
        backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        let viewWidth = rect.width
        let viewHeight = rect.height
        let centerX = viewWidth / 2
        let centerY = viewHeight / 2
        let center = CGPoint(x: centerX, y: centerY)
        let radius = min(viewWidth / 10, viewWidth / 10)
        let angle = startAngle
        
        let rowGapArcTotal = rowGapArc * CGFloat(columns - 1)
        let cellArc = (abs(startAngle - endAngle) / CGFloat(columns)) - (rowGapArcTotal / CGFloat(columns))
        
        let colors =  setColors(columns: columns, scores: score)
        
        for i in 0..<rows {
            for j in 0..<columns {
                let startAngle = angle.degreesToRadians + CGFloat(j) * (cellArc + rowGapArc) * .pi / 180
                let endAngle = startAngle + cellArc * .pi / 180
                let path = UIBezierPath(arcCenter: center, radius: radius + CGFloat(i) * columnGap, startAngle: startAngle, endAngle: endAngle, clockwise: true)
                var color: UIColor
                if i + 1 <= score[j] {
                    color = colors[j]
                }
                else {
                    color = offColor
                }
                
                color.setStroke()
                path.lineWidth = lineWidth
                path.stroke()
            }
        }
        
        let imageGap = (rows + 1) * (Int(rowGapArc) + Int(lineWidth) + 2)
        
        for j in 0..<columns {
            let startAngle = angle.degreesToRadians + CGFloat(j) * (cellArc + rowGapArc) * .pi / 180
            _ = startAngle + cellArc * .pi / 180
            let imageAngle = startAngle + cellArc / 2 * .pi / 180
            
            let x = centerX + (radius + CGFloat(imageGap)) * cos(imageAngle)
            let y = centerY + (radius + CGFloat(imageGap)) * sin(imageAngle)
            let imagePoint = CGPoint(x:x, y:y)
            
            
            let image = UIImage(systemName: sectionImage[j])?.withRenderingMode(.alwaysTemplate)
            
            let coloredImage = image?.withTintColor(colors[j])
            coloredImage?.draw(at: CGPoint(x: imagePoint.x - 8, y: imagePoint.y - 8))
        }
        
        
        let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let size = (label as NSString).boundingRect(with: CGSize(width: rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size
        let origin = CGPoint(x: rect.origin.x + (rect.width - size.width) / 2, y: centerY + CGFloat(imageGap))
        (label as NSString).draw(at: origin, withAttributes: attributes)
        
    }
}

extension MyCustomView {
    func makeScore(_ n: Int, rows: Int) -> [Int] {
        return (0..<n).map { _ in  .random(in: 0...rows) }
    }
    
    func setColors(columns: Int, scores: [Int]) -> [UIColor] {
        return (0..<columns).map({i in
            if !manualColor {
                let red = maxRed * (CGFloat(scores[i]) / (CGFloat(rows) / 2))
                let blue = maxBlue * (CGFloat(scores[i]) / (CGFloat(rows) / 2))
                let green = maxGreen * (CGFloat(scores[i]) / (CGFloat(rows) / 2))
                return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
            } else {
                return levelsColor[scores[i] - 1]
            }
            
        })
        
        
    }
}


extension CGFloat {
    var degreesToRadians: CGFloat { self * .pi / 180 }
}
