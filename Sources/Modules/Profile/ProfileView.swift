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
  @ObservedResults(ImageDescription.self) var imagePaths
  
  func onAppear() {
    nickname = dependencies.userDataStorageService.nickname ?? ""
    avatarURL = dependencies.userDataStorageService.avatarURL ?? ""
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
  
  func saveImage(_ image: UIImage, imageName: String) {
    if imagePaths.contains(where: { $0.name == imageName }) {
      saveImage(image, imageName: imageName + "(copy)")
      return // recursion until imageName is unique
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
    let date = Date()

    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"

    let time = formatter.string(from: date)
    return time
  }
  
}

struct ProfileView: View {
  @Binding var isLoggedIn: Bool
  @State private var inputImage: UIImage?
  @State var imageToShow = Image(.people)
  @State var imageToShowName = ""
  
  @State private var isPresentingPhoto = false
  @State private var isShowingImagePicker = false
  
  @ObservedObject var viewModel: ProfileViewModel
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  var body: some View {
    if isPresentingPhoto {
      ContentImageView(isPresentingPhoto: $isPresentingPhoto,
                       imageName: imageToShowName,
                       image: imageToShow,
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
        ImagePicker(image: $inputImage, imageName: $imageToShowName)
      }
      .onChange(of: inputImage) { newValue in
        if let newValue = newValue {
          viewModel.saveImage(newValue, imageName: imageToShowName)
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
      ForEach(viewModel.imagePaths) { imagePathContainer in
        let image = viewModel.getImage(with: imagePathContainer.name)
        ImageCellView(viewModel: ImageCellModel(date: imagePathContainer.time,
                                                image: image))
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
    ProfileView(isLoggedIn: .constant(false),
                viewModel: ProfileViewModel())
  }
}
