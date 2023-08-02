//
//  HomeView.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 01.08.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView=false
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            if showLocationSearchView{
                LocationSearchView()
            }else{
                LocationSearchActivationView()
                    .padding(.top,72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top,4)
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}