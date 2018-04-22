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
    
    func convertToTimeString(time:Float)->String {
        let t:Int = Int(time)
        let hour:Int = t/3600
        let minutes:Int = (t - hour * 3600)/60
        let seconds:Float = time - Float(hour * 3600 + minutes * 60)
        let secondsString = String(format: "%.1f", seconds)
        return String("\(hour):\(minutes):\(secondsString)")
    }
    
    func setup() {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        let chartPoints = [(40232, 3.53), (40233, 17.21), (40234, 24.59), (40235, 28.74), (40236, 31.05), (40237, 33.08),  (40238, 33.77),(40239, 33.82), (40240, 45.67), (40241, 40.88), (40242, 32.33), (40243, 10.32), (40244, 38.54), (40245, 34.24),(40246, 32.25), (40247, 30.67), (40248, 10.47), (40249, 39.57), (40250, 29.89), (40251, 50.78), (40252, 60.79),(40253, 70.80), (40254, 68.23), (40255, 69.12), (40256, 73.49), (40258, 80.32), (40259, 81.23), (40260, 80.32),(40261, 80.54), (40262, 80.56), (40263, 60.34), (40264, 70.42), (40265, 73.66), (40266, 78.34), (40267, 79.23),(40268, 67.12), (40269, 68.23), (40270, 69.30), (40271, 40.45), (40272, 23.52), (40273, 20.34), (40274, 23.33),(40275, 30.44), (40276, 50.63), (40277, 50.45), (40278, 49.54), (40279, 50.23), (40280, 62.78), (40281, 67.45), (40282, 68.34), (40283, 70.89), (40284, 78.54), (40285, 80.32), (40286, 80.34), (40287, 81.23), (40288, 86.78),(40289, 83.45)].map{ChartPoint(x: ChartAxisValueDouble($0.0), y: ChartAxisValueDouble($0.1))}
        
        let chartPoints2 = [(40232, 30), (40233, 30), (40234, 30), (40235, 30), (40236, 30), (40237, 30),  (40238, 30),(40239, 30), (40240, 30), (40241, 30), (40242, 30), (40243, 30), (40244, 30), (40245, 30),(40246, 30), (40247, 30), (40248, 30), (40249, 30), (40250, 60), (40251, 60), (40252, 60),(40253, 60), (40254, 60), (40255, 60), (40256, 60), (40258, 100), (40259, 100), (40260, 100),(40261, 100), (40262, 100), (40263, 100), (40264, 100), (40265, 100), (40266, 100), (40267, 100),(40268, 100), (40269, 100), (40270, 80), (40271, 80), (40272, 80), (40273, 80), (40274, 80),(40275, 80), (40276, 80), (40277, 80), (40278, 80), (40279, 80), (40280, 80), (40281, 80), (40282, 80), (40283, 80), (40284, 80), (40285, 80), (40286, 80), (40287, 80), (40288, 80),(40289, 80)].map{ChartPoint(x: ChartAxisValueDouble($0.0), y: ChartAxisValueDouble($0.1))}

        let xValues = chartPoints.map{$0.x}
        
        let yValues = ChartAxisValuesStaticGenerator.generateYAxisValuesWithChartPoints(chartPoints, minSegmentCount: 10, maxSegmentCount: 20, multiple: 2, axisValueGenerator: {ChartAxisValueDouble($0, labelSettings: labelSettings)}, addPaddingSegmentIfEdge: false)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "Time", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "Speed", settings: labelSettings.defaultVertical()))
        let chartFrame = ExamplesDefaults.chartFrame(lineChartView.bounds)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom
        
        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let lineModel = ChartLineModel(chartPoints: chartPoints, lineColor: UIColor.orange, animDuration: 1, animDelay: 0)
        let lineModel2 = ChartLineModel(chartPoints: chartPoints2, lineColor: UIColor.blue, animDuration: 1, animDelay: 0)
        
        let chartPointsLineLayer = ChartPointsLineLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, lineModels: [lineModel, lineModel2], useView: false)
        
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
                guard let floatTime = Float(labels[0]) else {
                    continue
                }
                let time = self.convertToTimeString(time:floatTime)
                self.timeLabel.text = "\(time)"
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
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
