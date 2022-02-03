//
//  ProfileView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI
import Kingfisher
import RealmSwift

class ProfileViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Published var nickname = ""
  @Published var avatarURL = ""
  @Published var images: [Image] = []
  
  func onAppear() {
    nickname = dependencies.userDataStorageService.nickname ?? ""
    avatarURL = dependencies.userDataStorageService.avatarURL ?? ""
    guard let uiImages = try? dependencies.uiImagesStorage.getUIImages() else {
      return
    }
    images = uiImages.map { Image(uiImage: $0) }
  }
  
  func logOut(isLoggedIn: Binding<Bool>) {
    dependencies.userDataStorageService.clearData()
    isLoggedIn.wrappedValue = false
  }
  
  func getImage(with name: String) -> Image {
    do {
      let uiImage: UIImage
      uiImage = try dependencies.uiImagesStorage.getUIImage(withKey: name)
      return Image(uiImage: uiImage)
    } catch let error {
      log?.error(error)
    }
    return Image(.people)
  }
  
  func saveImage(_ image: UIImage, name: String) {
    do {
      try dependencies.uiImagesStorage.store(uiImage: image, name: name)
    } catch let error {
      log?.error(error)
    }
  }
  
}

struct ProfileView: View {
  var documentsUrl: URL {
    return FileManager.default.urls(for: .documentDirectory,
                                       in: .userDomainMask).first!
  }
  
  @Binding var isLoggedIn: Bool
  
  @ObservedResults(ImageStorage.self) var imagePaths
  
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
            Color.backgroundColor
              .ignoresSafeArea()
            VStack {
              makeTopBar()
              ScrollView(.vertical, showsIndicators: false) {
                makeImageView(parentHeight: screen.size.height)
                Text(viewModel.nickname)
                  .foregroundColor(.white)
                  .font(.mediumLargeTitle1)
                makeImageCells()
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
  
  @ViewBuilder
  private func makeTopBar() -> some View {
    HStack(alignment: .center) {
      Image(.hamburger)
        .resizable()
        .scaledToFit()
        .frame(width: 30, height: 30)
      
      Spacer()
      Image(.logo)
        .resizable()
        .scaledToFit()
        .frame(width: 50, height: 50)
      Spacer()
      
      Button("exit".unlocalized) {
        withAnimation {
          isLoggedIn = false
        }
        
      }
      .font(.regularTitle3)
      .foregroundColor(.white)
      
    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  @ViewBuilder
  private func makeImageView(parentHeight: CGFloat) -> some View {
    if let url = URL(string: viewModel.avatarURL) {
      KFImage(url)
        .resizable()
        .scaledToFit()
        .frame(height: parentHeight / 4)
        .cornerRadius(parentHeight / 8)
    } else {
      Image(.koala)
        .resizable()
        .scaledToFit()
        .frame(height: parentHeight / 4)
        .cornerRadius(parentHeight / 8)
    }
  }
  
  @ViewBuilder
  private func makeImageCells() -> some View {
    LazyVGrid(columns: columns) {
      ForEach(imagePaths) { imagePathContainer in
        let image = viewModel.getImage(with: imagePathContainer.imagePath)
        ImageCellView(viewModel: ImageCellModel(date: imagePathContainer.time,
                                                image: image))
          .onTapGesture {
            withAnimation {
              isPresentingPhoto = true
              imageToShow = image
              filename = imagePathContainer.imagePath
            }
          }
      }
      ImageCellAddView()
        .onTapGesture {
          isShowingImagePicker = true
        }
    }
    .padding(.leading, 10).padding(.trailing, 10)
  }
  
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView(isLoggedIn: .constant(false))
  }
}
