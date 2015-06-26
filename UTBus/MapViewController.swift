import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        self.Map.delegate = self
        
        Map.showsUserLocation = true
        
        let locations = initRoute()
        
        let locationsGeorge = [locations[0], locations[1]]
        let locationsSheridan = [locations[1], locations[2]]
        
        makePins(locations)
        
        //true = St. George route --- false = Sheridan route
        makeRoutes(locationsGeorge, route: true)
        makeRoutes(locationsSheridan, route: false)
    }
    
    func initRoute()->[CLLocation!]{
        let path = NSBundle.mainBundle().pathForResource("locations", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        let locations = [
            CLLocation(latitude: dict!.objectForKey("UTSG")![0] as! Double,
                longitude: dict!.objectForKey("UTSG")![1] as! Double),//UTSG
            CLLocation(latitude: dict!.objectForKey("UTM")![0] as! Double,
                longitude: dict!.objectForKey("UTM")![1] as! Double),//UTM
            CLLocation(latitude: dict!.objectForKey("Sheridan")![0] as! Double,
                longitude: dict!.objectForKey("Sheridan")![1] as! Double),//Sheridan
        ]
        
        centerMapOnLocation(CLLocation(latitude: dict!.objectForKey("Center")![0] as! Double,
            longitude: dict!.objectForKey("Center")![1] as! Double))
        
        return locations
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