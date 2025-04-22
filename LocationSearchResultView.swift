//
//  LocationSearchResultView.swift
//  UberSwiftUI
//
//  Created by Nitin on 23/04/25.
//


struct LocationSearchResultView : View {
    @StateObject var viewModel : LocationSearchViewModel
    let config : locationResultsViewConfig
    
    var body : some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.results , id: \.self) { result in
                    LocationSearchResultCell(
                        location: result.title,
                        address: result.subtitle
                    )
                    .onTapGesture {
                        withAnimation (.spring){
                            viewModel.selectLocation(result, config: config)
//                            mapState = .locationSelected
                        }
                    }
                }
            }
        }
    }
}