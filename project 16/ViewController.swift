//
//  ViewController.swift
//  project 16
//
//  Created by Denys Denysenko on 03.01.2022.
//
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "https://ru.wikipedia.org/wiki/%D0%9B%D0%BE%D0%BD%D0%B4%D0%BE%D0%BD")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "https://ru.wikipedia.org/wiki/%D0%9E%D1%81%D0%BB%D0%BE")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "https://ru.wikipedia.org/wiki/%D0%9F%D0%B0%D1%80%D0%B8%D0%B6")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "https://ru.wikipedia.org/wiki/%D0%A0%D0%B8%D0%BC")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "https://ru.wikipedia.org/wiki/%D0%92%D0%B0%D1%88%D0%B8%D0%BD%D0%B3%D1%82%D0%BE%D0%BD")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Type", style: .plain, target: self, action: #selector(chooseType))
    }
    
    @objc func chooseType () {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Satelite", style: .default, handler: {[weak self, weak ac] action in
            self?.mapView.mapType = .satellite
            }))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: {[weak self, weak ac] action in
            self?.mapView.mapType = .hybrid
            }))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: {[weak self, weak ac] action in
            self?.mapView.mapType = .standard
            }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        
        ac.popoverPresentationController?.sourceView = mapView
        present(ac, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Capital else {return nil}
        let identifier = "Capital"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.pinTintColor = .blue
            annotationView?.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        }else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
//        let placeName = capital.title
//        let placeInfo = capital.info
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
       if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        
        print("It works")
        vc.link = capital.info
        navigationController?.present(vc, animated: true)
        
       }
       
        
    }
}

