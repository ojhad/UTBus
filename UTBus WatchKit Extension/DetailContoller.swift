import Foundation
import WatchKit

class DetailController: WKInterfaceController{

    @IBOutlet weak var toLabel: WKInterfaceLabel!
    
    @IBOutlet weak var timesTable: WKInterfaceTable!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let location = context as? String{
            toLabel.setText("To " + location)
            
            WKInterfaceController.openParentApplication(["request": location], reply: { (replyInfo, error) -> Void in
                if let timesData = replyInfo[location] as? NSData {
                    if let times = NSKeyedUnarchiver.unarchiveObjectWithData(timesData) as? [AnyObject] {
                        self.populate(times as! [String])
                    }
                }
            })
        }
    }
    
    func populate(times:[String]){
        timesTable.setNumberOfRows(times.count, withRowType: "DetailRow")
        
        for(index, value) in enumerate(times){
            let row = timesTable.rowControllerAtIndex(index) as! DetailRowController
            row.time?.setText(value)
        }
    }
}