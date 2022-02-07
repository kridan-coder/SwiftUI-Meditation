//
//  ProfileView.swift
//  Meditation
//

import SwiftUI
import Kingfisher
import RealmSwift

class ProfileViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  @Binding var isLoggedIn: Bool
  
  @Published var nickname = ""
  @Published var avatarURL = ""
  @ObservedResults(ImageDescription.self) var imagePaths
  
  init(isLoggedIn: Binding<Bool>) {
    _isLoggedIn = isLoggedIn
  }
  
  func onAppear() {
    nickname = dependencies.userDataStorageService.nickname
    avatarURL = dependencies.userDataStorageService.avatarURL
  }
  
  func logOut() {
    dependencies.userDataStorageService.clearData()
    withAnimation {
      isLoggedIn = false
    }
  }
  
  func getImage(with name: String) -> UIImage {
    do {
      let image = try dependencies.uiImagesStorage.getUIImage(withKey: name)
      return image
    } catch let error {
      log?.error(error)
    }
    return UIImage()
  }
  
  func saveImage(_ image: UIImage, imageName: String) {
    if imagePaths.contains(where: { $0.name == imageName }) {
      saveImage(image, imageName: imageName + "(copy)")
      return // recursion until imageName becomes unique
    }
    let description = ImageDescription()
    description.name = imageName
    description.time = generateCurrentTime()
    do {
      try dependencies.realmService.add(description)
      try dependencies.uiImagesStorage.store(uiImage: image, name: description.name)
    } catch let error {
      log?.error(error)
    }
  }
  
  private func generateCurrentTime() -> String {
    return DateFormatter.hoursMinutes.string(from: Date())
  }
  
}

struct ProfileView: View {
  @State private var isPresentingPhoto = false
  @State private var isShowingImagePicker = false
  
  @State private var imageToShow = UIImage()
  @State private var imageToShowName = ""
  
  @ObservedObject private(set) var viewModel: ProfileViewModel
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    if isPresentingPhoto {
      ContentImageView(isPresentingPhoto: $isPresentingPhoto,
                       imageName: imageToShowName,
                       image: Image(uiImage: imageToShow),
                       viewModel: ContentImageViewModel())
    } else {
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
      }
      .sheet(isPresented: $isShowingImagePicker) {
        ImagePicker(image: $imageToShow, imageName: $imageToShowName)
      }
      .onChange(of: imageToShow) { newValue in
        viewModel.saveImage(newValue, imageName: imageToShowName)
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
        viewModel.logOut()
      }
      .font(.regularTitle3)
      .foregroundColor(.white)
      
    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
  }
  
  @ViewBuilder
  private func makeImageView(parentHeight: CGFloat) -> some View {
    ImageWithOptionalURL(url: viewModel.avatarURL, defaultImage: Image(.koala))
      .scaledToFit()
      .frame(height: parentHeight / 4)
      .cornerRadius(parentHeight / 8)
  }
  
  @ViewBuilder
  private func makeImageCells() -> some View {
    LazyVGrid(columns: columns) {
      ForEach(viewModel.imagePaths) { imagePathContainer in
        let image = viewModel.getImage(with: imagePathContainer.name)
        ImageCellView(model: ImageCellModel(date: imagePathContainer.time,
                                            image: Image(uiImage: image)))
          .onTapGesture {
            withAnimation {
              isPresentingPhoto = true
              imageToShow = image
              imageToShowName = imagePathContainer.name
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
    ProfileView(viewModel: ProfileViewModel(isLoggedIn: .constant(false)))
  }
}
