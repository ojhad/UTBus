import UIKit

class Updates: UIViewController{

    @IBOutlet weak var service: UITextView!

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loading.hidesWhenStopped=true
        self.loading.startAnimating()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            let url = NSURL(string: "https://m.utm.utoronto.ca/shuttle.php")
            var error: NSError?
            let html = NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding, error: &error)
            
            dispatch_async(dispatch_get_main_queue()) {
                // update some UI
                self.loading.stopAnimating()
                if (error != nil) {
                    self.service.text =  "Something went wrong..."
                } else {
                    let start=html!.rangeOfString("<div class='notice'>").location
                        + html!.rangeOfString("<div class='notice'>").length
                    
                    let substring: NSString = html!.substringFromIndex(start)
                    let end=substring.rangeOfString("</div>").location
                    
                    var serviceUpdates=substring.substringToIndex(end)
                    
                    serviceUpdates=serviceUpdates.stringByReplacingOccurrencesOfString("// ", withString: "\n\n", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    
                    self.service.text = serviceUpdates
                }
            }
        }
        
        
        
    }
}
