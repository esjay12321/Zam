//
//  StatisticsViewController.swift
//  prototype1
//
//  Created by Esjay Hong on 22/04/2018.
//  Copyright © 2018 Minkyung Kim. All rights reserved.
//

import UIKit
import SwiftCharts

class StatisticsViewController: UIViewController, UISplitViewControllerDelegate {
    fileprivate var chart: Chart? // arc

    @IBOutlet var lineChartView: UIView!
//    var chart:LineChart?
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    func setup() {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let chartPoints = [(2, 2), (4, 4), (7, 1), (8, 11), (12, 3)].map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
//        let chartPoints2 = [(2, 3), (3, 1), (5, 6), (7, 2), (8, 14), (12, 6)].map{ChartPoint(x: ChartAxisValueDouble($0.0, labelSettings: labelSettings), y: ChartAxisValueDouble($0.1))}
        
        let xValues = chartPoints.map{$0.x}
        
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Speed", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(lineChartView.bounds)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor(red:0.07, green:0.38, blue:0.62, alpha:1.0), animDuration: 1, animDelay: 0)
//        let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor.blue, animDuration: 1, animDelay: 0)
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel], useView: false)
        
        let thumbSettings = ChartPointsLineTrackerLayerThumbSettings(thumbSize: 10, thumbBorderWidth: 2)
        let trackerLayerSettings = ChartPointsLineTrackerLayerSettings(thumbSettings: thumbSettings)
        
        var currentPositionLabels: [UILabel] = []
        
        let chartPointsTrackerLayer = ChartPointsLineTrackerLayer<ChartPoint, Any>(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lines: [chartPoints], lineColor: UIColor.red, animDuration: 1, animDelay: 2, settings: trackerLayerSettings) {chartPointsWithScreenLoc in
            
            currentPositionLabels.forEach{$0.removeFromSuperview()}
            
            for (index, chartPointWithScreenLoc) in chartPointsWithScreenLoc.enumerated() {
                
                let label = UILabel()
                label.text = chartPointWithScreenLoc.chartPoint.description
                label.sizeToFit()
                label.center = CGPoint(x: chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2, y: chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2)
//                var time = chartPointWithScreenLoc.screenLoc.x + label.frame.width / 2
//                var speed = chartPointWithScreenLoc.screenLoc.y + chartFrame.minY - label.frame.height / 2
                var labels = chartPointWithScreenLoc.chartPoint.description.split(separator: ",")
                self.timeLabel.text = "\(labels[0])"
                self.speedLabel.text = "\(labels[1])KM/H"
                label.backgroundColor = index == 0 ? UIColor(red:0.07, green:0.38, blue:0.62, alpha:1.0) : UIColor.blue
                label.textColor = UIColor.white
                
                currentPositionLabels.append(label)
                self.view.addSubview(label)
            }
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.red, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        let chart = Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartPointsLineLayer,
                chartPointsTrackerLayer
            ]
        )
        
        self.view.addSubview(chart.view)
        self.chart = chart
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timeLabel.text = "00:00:00"
        self.speedLabel.text = "0KM/H"
        self.title = "Statistics"
//        setSplitSwipeEnabled(false)
//        let chartConfig = ChartConfigXY(
//            xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
//            yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
//        )
//
//        let frame = lineChartView.frame
//
//        chart = LineChart(
//            frame: frame,
//            chartConfig: chartConfig,
//            xTitle: "Time",
//            yTitle: "Velocity",
//            lines: [
//                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
//                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
//            ]
//        )
//        if let chartView = chart?.view {
//            lineChartView.addSubview(chartView)
//        }
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func setSplitSwipeEnabled(_ enabled: Bool) {
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            let splitViewController = UIApplication.shared.delegate?.window!!.rootViewController as! UISplitViewController
            splitViewController.presentsWithGesture = enabled
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
