import UIKit

class Updates: UIViewController{

    @IBOutlet weak var service: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://m.utm.utoronto.ca/shuttle.php")
        var error: NSError?
        let html = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
        
        if (error != nil) {
            service.text =  "Something went wrong..."
        } else {
            let start=html!.rangeOfString("<div class='notice'>").location
                + html!.rangeOfString("<div class='notice'>").length
            
            let substring: NSString = html!.substringFromIndex(start)
            let end=substring.rangeOfString("</div>").location
            
            var serviceUpdates=substring.substringToIndex(end)
            
            serviceUpdates=serviceUpdates.stringByReplacingOccurrencesOfString("// ", withString: "\n\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            service.text = serviceUpdates
        }
    }
}
