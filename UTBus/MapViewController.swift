import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var Map: MKMapView!
    
    override func viewDidLoad() {
        self.Map.delegate = self;
        
        Map.showsUserLocation = true
        
        let userLocation = Map.userLocation
        
        let locations = [
            CLLocation(latitude: 43.662138, longitude: -79.394073),
            CLLocation(latitude: 43.55147, longitude: -79.663718),
            CLLocation(latitude: 43.656418, longitude: -79.740349)]
        
        let locationsGeorge = [
            CLLocation(latitude: 43.662138, longitude: -79.394073),
            CLLocation(latitude: 43.55147, longitude: -79.663718)]
        
        let locationsSheridan = [
            CLLocation(latitude: 43.55147, longitude: -79.663718),
            CLLocation(latitude: 43.656418, longitude: -79.740349)]
        
        centerMapOnLocation(CLLocation(latitude: 43.55147, longitude: -79.663718))
        makePins(locations)
        makeRoutes(locationsGeorge)
        makeRoutes(locationsSheridan)
    }
    
    func makePins(locations: [CLLocation!]) {
        for var i=0; i<3; ++i {
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
    
    func makeRoutes(locations: [CLLocation!]){
        var coordinates = locations.map({ (location: CLLocation!) -> CLLocationCoordinate2D in
            return location.coordinate
        })
        
        var polyline = MKPolyline(coordinates: &coordinates, count: locations.count)
        self.Map.addOverlay(polyline)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        
        Map.setRegion(coordinateRegion, animated: true)
    }
    
    var count=0
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!{
        
        if (overlay is MKPolyline) {
            var pr = MKPolylineRenderer(overlay: overlay);
            
            if count==0 {
                pr.strokeColor = UIColor.redColor()
            }
            else{
                pr.strokeColor = UIColor.greenColor()
            }
            
            ++count;
            
            return pr;
        }
        
        return nil
    }
}