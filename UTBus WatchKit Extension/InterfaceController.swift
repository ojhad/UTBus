import WatchKit

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var locationsTable: WKInterfaceTable!
    
    let locations=["UTSG", "UTM", "Sheridan"]

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        populate()
        
        
    }
    
    func populate(){
        locationsTable.setNumberOfRows(3, withRowType: "LocationsRow")
        
        for(index, value) in enumerate(locations){
            let row = locationsTable.rowControllerAtIndex(index) as! TableController
            row.location?.setText(value)
            
            switch index {
                case 0:
                    row.picture.setImage(UIImage(named: "stgeorge"))
                case 1:
                    row.picture.setImage(UIImage(named: "utm"))
                case 2:
                    row.picture.setImage(UIImage(named: "sheridan"))
                
                default:
                    break;
            }
        }
    }
     
//    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
//        
//        if segueIdentifier == "LocationsSegue" {
//            let location = locations[rowIndex]
//            println(location)
//            return location
//        }
//        
//        return nil
//    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

}
