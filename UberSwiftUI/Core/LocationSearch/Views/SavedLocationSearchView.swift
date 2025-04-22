//
//  SavedLocationSearchView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SavedLocationSearchView: View {
    @State var searchText: String = ""
    @StateObject var viewModel =  LocationSearchViewModel()
    
    var body: some View {
        VStack{
            HStack(spacing: 16){
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading)
                
                TextField("Search For a location... ", text: $viewModel.queryFragment)
                    .frame(height: 40)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.trailing)
            }
            
            Spacer()
            
            LocationSearchResultView(viewModel: viewModel, config: .saveLocation)
            
        }.navigationTitle("Add Home")
    }
}

#Preview {
    NavigationStack{
        SavedLocationSearchView()
    }
}
