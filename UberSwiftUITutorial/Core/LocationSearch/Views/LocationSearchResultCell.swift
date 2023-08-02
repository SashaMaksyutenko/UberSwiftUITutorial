//
//  LocationSearchResultCell.swift
//  UberSwiftUITutorial
//
//  Created by Sasha Maksyutenko on 02.08.2023.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title:String
    let subTitle:String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading,spacing: 4){
                Text(title)
                    .font(.body)
                Text(subTitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading,8)
            .padding(.leading,8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell(title: "Starbuck coffee", subTitle: "123 Main st")
    }
}
