//
//  ProfileView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI
import Kingfisher
import RealmSwift

class ContentImagesData: ObservableObject {
  private init() {}
  
  static let shared = ContentImagesData()
  
}

class ProfileViewModel: ObservableObject {
  
  @Environment(\.appDependencies) private var dependencies
  
  @Published var name = "Daniel"
  
  func logOut(isLoggedIn: Binding<Bool>) {
    dependencies.userDataStorageService.clearData()
    isLoggedIn.wrappedValue = false
  }
  
}

struct ProfileView: View {
  var documentsUrl: URL {
      return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  @Binding var isLoggedIn: Bool
  
  @ObservedResults(ImageStorage.self) var imagePaths
  
  @AppStorage("isAuthorized") var isAuthorized: Bool?
  @AppStorage("wasLoggedOut") var wasLoggedOut: Bool?
  
  @AppStorage("avatar") var avatarLink: String = ""
  @AppStorage("nickName") var nickname: String?
  
  @StateObject var contentImagesContainer = ContentImagesData.shared
  
  var isNavigationBarHidden = true
  
  @State private var inputImage: UIImage?
  
  @State var imageToShow = Image("Koala")
  
  @State var filename = ""
  
  @State private var isPresentingPhoto = false
  @State private var isShowingImagePicker = false
  
  @StateObject var viewModel = ProfileViewModel()
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
//  func loadImage() {
//      guard let inputImage = inputImage else { return }
//      let image = Image(uiImage: inputImage)
//    $imagePaths.append()
//    contentImagesContainer.contentImagesViewModels.append(ImageViewModel(date: "11:00", image: image))
//  }
  
  var body: some View {
    if isPresentingPhoto {
      ContentImageView(isPresentingPhoto: $isPresentingPhoto, filename: filename, image: imageToShow)
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
                  withAnimation {
                    isLoggedIn = false
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
                  ForEach(imagePaths) { imagePathContainer in
                    let data = try? Data(contentsOf: documentsUrl.appendingPathComponent(imagePathContainer.imagePath))
                    let image = UIImage(data: data!)!
                    ImageView(viewModel: ImageViewModel(date: imagePathContainer.time, image: Image(uiImage: image)))
                      .onTapGesture {
                        withAnimation {
                          isPresentingPhoto = true
                          imageToShow = Image(uiImage: image)
                          filename = imagePathContainer.imagePath
                        }
                      }
                    
                  }
                  ImageAddView()
                    .onTapGesture {
                      isShowingImagePicker = true
                    }
                }
                .padding(.leading, 10).padding(.trailing, 10)
                // Spacer()
              }
              
            }
          }
        }.navigationBarHidden(isNavigationBarHidden)
          .sheet(isPresented: $isShowingImagePicker) {
            ImagePicker(image: $inputImage, filename: $filename)
          }
          .onChange(of: inputImage) { _ in
            // loadImage()
          }
        
      }
      
    }
    
  }
  
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(isLoggedIn: .constant(false))
  }
}
