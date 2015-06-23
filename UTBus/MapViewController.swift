import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var Map: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        self.Map.delegate = self
        
        Map.showsUserLocation = true
        
        // Ask for Authorisation from the user
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        //parse data from plist file
        let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        let locsUTSG: AnyObject = dict!.objectForKey("UTSG")!
        let locsUTM: AnyObject = dict!.objectForKey("UTM")!
        let locsSheridan: AnyObject = dict!.objectForKey("Sheridan")!
        
        let locations = [
            CLLocation(latitude: locsUTSG[0] as! Double, longitude: locsUTSG[1] as! Double),//UTSG
            CLLocation(latitude: locsUTM[0] as! Double, longitude: locsUTM[1] as! Double),//UTM
            CLLocation(latitude: locsSheridan[0] as! Double, longitude: locsSheridan[1] as! Double)]//Sheridan
        
        let locationsGeorge = [locations[0], locations[1]]
        
        let locationsSheridan = [locations[1], locations[2]]
        
        centerMapOnLocation(locations[1])
        
        makePins(locations)
        
        //true = St. George route
        //false = Sheridan route
        makeRoutes(locationsGeorge, route: true)
        makeRoutes(locationsSheridan, route: false)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location.coordinate
        
        println("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func makePins(locations: [CLLocation!]) {
        for var i=0; i<locations.count; ++i {
            var coordinates = locations.map({ (location: CLLocation!) -> CLLocationCoordinate2D in
                return location.coordinate
            })
            
            let pinLocation = CLLocation(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude)
            var objectAnnotation = MKPointAnnotation()
            objectAnnotation.coordinate = pinLocation.coordinate
            
            if i==0{
                objectAnnotation.title = "Hart House (UTSG)"
            }
            else if i==1{
                objectAnnotation.title = "Instructional Centre (UTM)"
            }
            else{
                objectAnnotation.title = "Sheridan"
            }
            
            self.Map.addAnnotation(objectAnnotation)
        }
    }
    
    func makeRoutes(locations: [CLLocation!], route: Bool){
        var coordinates = locations.map({ (location: CLLocation!) -> CLLocationCoordinate2D in
            return location.coordinate
        })
        
        var polyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        if route==true{
            polyline.title="George"
        }
        else{
            polyline.title="Sheridan"
        }
        
        self.Map.addOverlay(polyline)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        
        Map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay);
            
            if overlay.title=="George" {
                pr.strokeColor = UIColor.redColor()
            }
            else{
                pr.strokeColor = UIColor.greenColor()
            }
            
            return pr;
        }
        
        return nil
    }
}