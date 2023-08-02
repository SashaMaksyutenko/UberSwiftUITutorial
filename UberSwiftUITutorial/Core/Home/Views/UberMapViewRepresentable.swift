//
//  UberMapViewRepresentable.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 01.08.2023.
//

import SwiftUI
import MapKit
struct UberMapViewRepresentable:UIViewRepresentable{
    @EnvironmentObject var locationViewModel:LocationSearchViewModel
    let locationManager=LocationManager()
    let mapView=MKMapView()
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate=context.coordinator
        mapView.isRotateEnabled=false
        mapView.showsUserLocation=true
        mapView.userTrackingMode = .follow
        return mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate=locationViewModel.selectedLocationCoordinate{
            context.coordinator.addAndSeelectAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyLine(withDestinationCoordinate: coordinate)
        }
    }
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}
extension UberMapViewRepresentable{
    class MapCoordinator:NSObject,MKMapViewDelegate{
        //MARK: - Properties
        let parent:UberMapViewRepresentable
        var userLocationCoordinate:CLLocationCoordinate2D?
        //MARK: LifeCycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        //MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate=userLocation.coordinate
            let region=MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline=MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth=6
            return polyline
        }
        //MARK: - Helpers
        func addAndSeelectAnnotation(withCoordinate coordinate:CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno=MKPointAnnotation()
            anno.coordinate=coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        func configurePolyLine(withDestinationCoordinate coordinate:CLLocationCoordinate2D){
            guard let userLocationCoordinate=self.userLocationCoordinate else{return}
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        func getDestinationRoute(from userLocation:CLLocationCoordinate2D, to destination:CLLocationCoordinate2D,completion:@escaping(MKRoute)->Void){
            let userPlaceMark=MKPlacemark(coordinate: userLocation)
            let destPlaceMark=MKPlacemark(coordinate: destination)
            let request=MKDirections.Request()
            request.source=MKMapItem(placemark: userPlaceMark)
            request.destination=MKMapItem(placemark:destPlaceMark)
            let directions=MKDirections(request: request)
            directions.calculate { response, error in
                if let error=error{
                    print("failed to get directions with error \(error.localizedDescription)")
                    return
                }
                guard let route=response?.routes.first else {return}
                completion(route)
            }
        }
    }
}
