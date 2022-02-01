//
//  ImagePicker.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import Foundation

import PhotosUI
import SwiftUI
import UIKit
import RealmSwift

class ImageStorage: Object, ObjectKeyIdentifiable {
  @objc dynamic var imagePath: String = ""
  @objc dynamic var time: String = ""
  
}

struct ImagePicker: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  
  @Binding var image: UIImage?
  @Binding var filename: String
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    return picker
  }
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: ImagePicker
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      picker.dismiss(animated: true)
      
      var filename = ""
      
      guard let provider = results.first?.itemProvider else { return }
      provider.loadFileRepresentation(forTypeIdentifier: "public.item") { url, error in
        if error != nil {
          print(error)
        } else {
          if let url = url {
            
            filename = url.lastPathComponent
            
          }
        }
      }
      
      if filename.isEmpty {
        filename = UUID().uuidString
      }
      
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, _ in
          guard let safeImage = image as? UIImage else {
            return
          }
          
          let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
          let writePath = documentsPath.appendingPathComponent(filename)
          
          guard let imageData = safeImage.pngData() else { return }
          do {
            try imageData.write(to: writePath, options: .atomic)

          }
          catch let error {
            print(error)
          }
          let realm: Realm
          do {
            
            realm = try Realm()
          } catch {
            fatalError()
          }
          
          
          
          let date = Date()
          
          let formatter = DateFormatter()
          formatter.dateFormat = "HH:mm"
          
          let time = formatter.string(from: date)
          
          let storage = ImageStorage()
          storage.imagePath = filename
          storage.time = time
          do {
            try realm.write {
              realm.add(storage)
            }
          } catch {
            fatalError()
          }
         
          self.parent.filename = filename
          self.parent.image = safeImage
          
        }
      }
    }
    
  }
  
}
