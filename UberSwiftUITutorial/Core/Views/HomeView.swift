//
//  HomeView.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 01.08.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
