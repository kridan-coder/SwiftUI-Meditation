//
//  ImagePicker.swift
//  Meditation
//

import Foundation

import PhotosUI
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
  
  @Binding var image: UIImage
  @Binding var imageName: String
  
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
      guard let provider = results.first?.itemProvider else { return }
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, error in
          if let safeError = error {
            log?.error(safeError)
          }
          guard let safeImage = image as? UIImage else {
            return
          }
          self.generateImageName(safeImage, provider: provider) { result in
            switch result {
            case .success(let name):
              self.parent.imageName = name
            case .failure(let error):
              log?.error(error)
              self.parent.imageName = UUID().uuidString
            }
            self.parent.image = safeImage
          }
        }
      }
    }
    
    private func generateImageName(_ image: UIImage,
                                   provider: NSItemProvider,
                                   completionHandler: @escaping (Result<String, Error>) -> Void) {
      provider.loadFileRepresentation(forTypeIdentifier: "public.item") { url, error in
        if let url = url {
          completionHandler(.success(url.lastPathComponent))
        } else {
          log?.error(error ?? StorageError.couldNotDecodeFile)
          completionHandler(.failure(error ?? StorageError.couldNotDecodeFile))
        }
      }
    }
    
  }
  
}
