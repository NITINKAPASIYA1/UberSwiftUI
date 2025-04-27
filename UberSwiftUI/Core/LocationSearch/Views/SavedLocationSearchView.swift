//
//  SavedLocationSearchView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//

import SwiftUI

struct SavedLocationSearchView: View {
    @State var searchText: String = ""
    @StateObject var viewModel =  HomeViewModel()
    let config : SavedLocationViewModel
    
    var body: some View {
        VStack{
                TextField("Search For a location... ", text: $viewModel.queryFragment)
                    .frame(height: 40)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding()
            
            
            Spacer()
            
            LocationSearchResultView(viewModel: viewModel, config: .saveLocation(config))
            
        }
        .navigationTitle(config.subTitle)
        .navigationBarTitleDisplayMode(.inline)
            
    }
}

#Preview {
    NavigationStack{
        SavedLocationSearchView(config: .home)
    }
}
