//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by Nitin on 22/03/25.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState : MapViewState
    @Binding var showSideMenu : Bool
    @EnvironmentObject var locationSearchViewModel : HomeViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName:imageNameForState(mapState))
                .font(.system(size: 24))
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state : MapViewState){
        switch state {
            case .noInput:
                showSideMenu.toggle()
            case .searchingForLocation:
                mapState = .noInput
        case .locationSelected,.polylineAdded:
                mapState = .noInput
                locationSearchViewModel.selectedUberLocation = nil
                
        }
    }
    
    func imageNameForState(_ state : MapViewState) -> String {
        switch state {
            case .noInput:
                return "line.3.horizontal"
            case .searchingForLocation:
                return "arrow.left"
            case .locationSelected,.polylineAdded:
                return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.noInput), showSideMenu: .constant(false))
}
