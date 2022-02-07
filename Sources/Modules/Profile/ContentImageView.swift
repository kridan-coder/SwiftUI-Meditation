//
//  ContentImageView.swift
//  Meditation
//

import SwiftUI
import RealmSwift

final class ContentImageViewModel: ObservableObject {
  @Environment(\.appDependencies) private var dependencies
  
  func deleteImage(withName name: String) {
    do {
      try dependencies.uiImagesStorage.deleteImage(withName: name)
      let imageDescription = dependencies.realmService.getAllObjects(ofType: ImageDescription.self).first { $0.name == name }
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
  
  let imageName: String
  let image: Image
  
  @ObservedObject private(set) var viewModel: ContentImageViewModel
  
  private func delete() {
    withAnimation {
      isPresentingPhoto = false
    }
    viewModel.deleteImage(withName: imageName)
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
    ContentImageView(isPresentingPhoto: .constant(true), imageName: "h", image: Image(.people), viewModel: ContentImageViewModel())
  }
}
