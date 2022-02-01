//
//  ContentImageView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI
import RealmSwift

struct ContentImageView: View {
  
  @State private var isScaled = false
  
  @Binding var isPresentingPhoto: Bool
  
  var filename: String
  
  var isNavigationBarHidden = true
  
  var image: Image
  
  var documentsUrl: URL {
      return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  func delete() {
    do {
      let realm = try Realm()
      try realm.write {
        let objects = realm.objects(ImageStorage.self)
        let filtered = objects.filter { $0.imagePath == filename }
        print(filtered.count)
        
        realm.delete(filtered)
      }
      
      try FileManager.default.removeItem(at: documentsUrl.appendingPathComponent(filename))
    } catch {
      fatalError()
    }

    
    withAnimation {
      isPresentingPhoto = false
    }
  }
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          
          VStack {
            Spacer()
            
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
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                                    .onEnded({ value in
                                        if value.translation.width < 0 {
                                            delete()
                                        }

                                        if value.translation.width > 0 {
                                          withAnimation {
                                            isPresentingPhoto = false
                                          }
                                        }
                                        if value.translation.height < 0 {
                                            // up
                                        }

                                        if value.translation.height > 0 {
                                            // down
                                        }
                                    }))
              
            }
            
            Spacer()
            HStack {
              Spacer()
              Button("удалить") {
                delete()
                
              }
              Spacer()
              Button("закрыть") {
                withAnimation {
                  isPresentingPhoto = false
                }
              }
              Spacer()
            }.padding(.bottom, 40)
              .font(.custom("Alegreya-Medium", size: 20))
              .foregroundColor(.white)
          }
        }
        
        
      }
      .navigationBarHidden(true)
      
    }
  }
}

struct ContentImageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentImageView(isPresentingPhoto: .constant(false), filename: "", image: Image("Content1"))
  }
}

