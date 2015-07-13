import MapKit
import UIKit
import CoreLocation
import AddressBook
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Map.delegate = self
        Map.showsUserLocation = true
        
        let locations = initRoute();
        let locationsGeorge = [locations[0], locations[1]]
        let locationsSheridan = [locations[2], locations[1]]
        
        makePins(locations)
        // true = St. George route --- false = Sheridan route
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
            
            if i==0{
                let pin = Pin(title: "Hart House",
                    locationName: "UTSG",
                    coordinate:
                    CLLocationCoordinate2D(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude))
                self.Map.addAnnotation(pin)
            }
            else if i==1{
                let pin = Pin(title: "Instructional Centre",
                    locationName: "UTM",
                    coordinate:
                    CLLocationCoordinate2D(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude))
                self.Map.addAnnotation(pin)
            }
            else{
                let pin = Pin(title: "Sheridan College",
                    locationName: "Sheridan",
                    coordinate:
                    CLLocationCoordinate2D(latitude: coordinates[i].latitude, longitude: coordinates[i].longitude))
                self.Map.addAnnotation(pin)
            }
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
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Pin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                
                let directions = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                directions.frame.size.width = 45
                directions.frame.size.height = 45
                directions.setImage(UIImage(named: "GPS Device-25"), forState: .Normal)
                
                view.rightCalloutAccessoryView = directions
            }
            
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            let location = view.annotation as! Pin
            
            var locations = initRoute();
            var coordinates = locations.map({ (location: CLLocation!) -> CLLocationCoordinate2D in
                return location.coordinate
            })
            
            var coords = CLLocationCoordinate2DMake(coordinates[0].latitude, coordinates[0].longitude)
            var address = [kABPersonAddressStreetKey as String: "Hart House"]
            
            if view.annotation.title == "Instructional Centre"{
                coords = CLLocationCoordinate2DMake(coordinates[1].latitude, coordinates[1].longitude)
                address = [kABPersonAddressStreetKey as String: "Instructional Centre"]
                
            }
            else if view.annotation.title == "Sheridan College"{
                coords = CLLocationCoordinate2DMake(coordinates[2].latitude, coordinates[2].longitude)
                address = [kABPersonAddressStreetKey as String: "Sheridan College"]
            }
            
            let place = MKPlacemark(coordinate: coords, addressDictionary: address)
            let mapItem = MKMapItem(placemark: place)
            let options = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeWalking]
            
            mapItem.openInMapsWithLaunchOptions(options)
    }
}