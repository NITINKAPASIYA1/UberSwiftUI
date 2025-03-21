//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/03/25.
//

import SwiftUI

struct LocationSearchView: View {
    @State var startLocationText : String = ""
    @State var destinationLocationText : String = ""
    
    var body: some View {
        VStack{
            //headerview
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 30)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("Current location", text: $startLocationText)
                        .frame(height: 50)
                        .background(
                            Color(.systemGroupedBackground)
                        )
                        .cornerRadius(10)
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $destinationLocationText)
                        .frame(height: 50)
                        .background(
                            Color(.systemGroupedBackground)
                        )
                        .cornerRadius(10)
                        .padding(.trailing)
                    
                }
                
            }.padding(.horizontal)
                .padding(.top,64)
            
            Divider()
                .padding(.vertical)

            //listview
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(0..<20){_ in
                        LocationSearchResultCell()
                    }
                }
            }
            
        }
    }
}

#Preview {
    LocationSearchView()
}
