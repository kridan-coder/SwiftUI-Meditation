//
//  ProfileView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//


import SwiftUI
import Kingfisher

struct ContentImagesData {
  static var contentImages = [
    ImageView(viewModel: ImageViewModel(date: "11:00", image: Image("Content3"))),
    ImageView(viewModel: ImageViewModel(date: "15:55 ", image: Image("Content2"))),
    ImageView(viewModel: ImageViewModel(date: "19:11", image: Image("Content4"))),
    ImageView(viewModel: ImageViewModel(date: "11:11", image: Image("Content1")))
  ]
}

class ProfileViewModel: ObservableObject {
  @Published var name = "Daniel"
}

struct ProfileView: View {
  @AppStorage("isAuthorized") var isAuthorized: Bool?
  @AppStorage("wasLoggedOut") var wasLoggedOut: Bool?
  
  @AppStorage("avatar") var avatarLink: String = ""
  @AppStorage("nickName") var nickname: String?
  
  var isNavigationBarHidden = true
  
  @State var imageToShow = Image("Koala")
  
  @State private var isPresentingPhoto = false
  
  @StateObject var viewModel = ProfileViewModel()
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    if isPresentingPhoto {
      ContentImageView(isPresentingPhoto: $isPresentingPhoto, image: imageToShow)
    } else {
      
      
      NavigationView {
        GeometryReader { screen in
          ZStack(alignment: .top) {
            Color("BackgroundColor")
              .ignoresSafeArea()
            
            VStack {
              HStack(alignment: .center) {
                Image("Hamburger")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 30, height: 30)
                
                Spacer()
                Image("Logo")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 50, height: 50)
                Spacer()
                
                Button("exit") {
                  isAuthorized = false
                  withAnimation {
                    wasLoggedOut = true
                  }
                  
                }
                .font(.custom("Alegreya-Regular", size: 23))
                .foregroundColor(.white)
                
              }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
              ScrollView(.vertical, showsIndicators: false) {
                
                if let url = URL(string: avatarLink) {
                  KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screen.size.height / 4)
                    .cornerRadius(screen.size.height / 8)
                } else {
                  Image("Koala")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screen.size.height / 4)
                    .cornerRadius(screen.size.height / 8)
                }
                
                Text(nickname ?? "Эмиль")
                  .foregroundColor(.white)
                  .font(.custom("Alegreya-Medium", size: 35))
                
                
                LazyVGrid(columns: columns) {
                  ForEach(0..<ContentImagesData.contentImages.count, id: \.self) { i in
                    let imageView = ContentImagesData.contentImages[i]
                    imageView
                      .onTapGesture {
                        withAnimation {
                          isPresentingPhoto = true
                          imageToShow = imageView.viewModel.image
                        }
                      }
                    
                  }
                  ImageAddView()
                }
                .padding(.leading, 10).padding(.trailing, 10)
                //Spacer()
              }
              
            }
          }
        }.navigationBarHidden(isNavigationBarHidden)
      }
      
    }
    
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

