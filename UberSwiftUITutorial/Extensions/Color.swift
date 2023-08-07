//
//  Color.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 07.08.2023.
//

import SwiftUI
extension Color{
    static let theme=colorTheme()
}
struct colorTheme{
    let backgroundColor=Color("BackgroundColor")
    let secondaryBackgroundColor=Color("SecondaryBackgroundColor")
    let primaryTextColor=Color("PrimaryTextColor")
}
