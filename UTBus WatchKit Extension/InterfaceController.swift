import WatchKit

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var locationsTable: WKInterfaceTable!
    
    
    func reloadTable() {
        // 1
        locationsTable.setNumberOfRows(3, withRowType: "TableContoller")
        
        //if let row = locationsTable.rowControllerAtIndex(index) as? TableController {}
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

}
