import SwiftUI

struct LocationSearchView: View {
    @State var startLocationText: String = ""
    @Binding var showLocationSearchView : Bool
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    
    var body: some View {
        VStack {
            // Header view
            HStack {
                VStack {
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
                
                VStack {
                    TextField("", text: $startLocationText)
                        .padding(.horizontal,10)
                        .placeholder(when: startLocationText.isEmpty) {
                            Text("Current location")
                                .padding(.leading, 10)// Padding for placeholder
                                .foregroundStyle(Color(.systemGray))
                        }
                        .frame(height: 50)
                        .background(
                            Color(.systemGroupedBackground)
                        )
                        .cornerRadius(10)
                        .padding(.trailing)
                    
                    TextField("", text: $viewModel.queryFragment)
                        .padding(.horizontal,10)
                        .placeholder(when: viewModel.queryFragment.isEmpty) {
                            Text("Where to?")
                                .padding(.leading, 10)
                               .foregroundStyle(Color(.systemGray))
                        }
                        .frame(height: 50)
                        .background(
                            Color(.systemGroupedBackground)
                        )
                        .cornerRadius(10)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top, 70)
            
            Divider()
                .padding(.vertical)
            
            // List view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.results , id: \.self) { result in
                        LocationSearchResultCell(
                            location: result.title,
                            address: result.subtitle
                        )
                        .onTapGesture {
                            viewModel.selectLocation(result)
                            showLocationSearchView.toggle()
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

extension View {
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                if shouldShow {
                    placeholder()
                }
                self
            }
        }
}


#Preview {
    LocationSearchView(showLocationSearchView: .constant(false))
}
