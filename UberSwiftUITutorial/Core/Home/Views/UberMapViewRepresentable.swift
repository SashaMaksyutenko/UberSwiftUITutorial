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
        //MARK: LifeCycle
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        //MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region=MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
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
    }
}
