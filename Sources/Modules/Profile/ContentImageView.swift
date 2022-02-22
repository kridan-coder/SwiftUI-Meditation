//
//  ContentImageView.swift
//  Meditation
//

import SwiftUI
import CoreData

final class ContentImageViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  func deleteImage(withInfo imageInfo: ImageInfo) {
    guard let imageName = imageInfo.name else { return }
    dependencies.coreDataService.viewContext.delete(imageInfo)
    do {
      try dependencies.coreDataService.viewContext.save()
      try dependencies.uiImagesStorage.deleteImage(withName: imageName)
      let imageDescription = dependencies.realmService.getAllObjects(ofType: ImageDescription.self).first { $0.name == imageName }
      guard let safeImageDescription = imageDescription else { return }
      try dependencies.realmService.delete(safeImageDescription)
    } catch let error {
      log?.error(error)
    }
  }
}

struct ContentImageView: View {
  @State private var isScaled = false
  @Binding var isPresentingPhoto: Bool
  
  let imageInfo: ImageInfo
  let image: Image
  
  @ObservedObject private(set) var viewModel: ContentImageViewModel
  
  private func delete() {
    withAnimation {
      isPresentingPhoto = false
    }
    viewModel.deleteImage(withInfo: imageInfo)
  }
  
  var body: some View {
    ZStack {
      Color.backgroundColor
        .ignoresSafeArea()
      VStack {
        Spacer()
        makeImage()
        Spacer()
        makeButtons()
      }
    }
  }
  
  @ViewBuilder
  private func makeImage() -> some View {
    if isScaled {
      image
        .resizable()
        .scaledToFit()
        .onTapGesture(count: 2) {
          isScaled.toggle()
        }
        .scaleEffect(2)
    } else {
      image
        .resizable()
        .scaledToFit()
        .onTapGesture(count: 2) {
          isScaled.toggle()
        }
        .gesture(DragGesture(minimumDistance: 15, coordinateSpace: .local)
                  .onEnded { value in
          if value.translation.width < 0 {
            delete()
          }
          
          if value.translation.width > 0 {
            withAnimation {
              isPresentingPhoto = false
            }
          }
        })
      
    }
  }
  
  @ViewBuilder
  private func makeButtons() -> some View {
    HStack {
      Spacer()
      Button("удалить".unlocalized) {
        delete()
        
      }
      Spacer()
      Button("закрыть".unlocalized) {
        withAnimation {
          isPresentingPhoto = false
        }
      }
      Spacer()
    }.padding(.bottom, 40)
      .font(.mediumBody)
      .foregroundColor(.white)
  }
  
}

struct ContentImageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentImageView(isPresentingPhoto: .constant(true),
                     imageInfo: ImageInfo(),
                     image: Image(.people),
                     viewModel: ContentImageViewModel())
  }
}
