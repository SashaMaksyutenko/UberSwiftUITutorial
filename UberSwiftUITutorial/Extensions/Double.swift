//
//  Double.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 07.08.2023.
//

import Foundation
extension Double{
    private var currencyFormatter:NumberFormatter{
        let formatter=NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits=2
        formatter.maximumFractionDigits=2
        return formatter
    }
    func ToCurrency()->String{
        return currencyFormatter.string(for: self) ?? ""
    }
}
