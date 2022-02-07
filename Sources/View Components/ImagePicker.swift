//
//  ImagePicker.swift
//  Meditation
//

import Foundation

import PhotosUI
import SwiftUI
import UIKit
import PromiseKit

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
          firstly {
            self.generateImageName(safeImage, provider: provider)
          }.done { result in
            self.parent.imageName = result
          }.catch { error in
            log?.error(error)
            self.parent.imageName = UUID().uuidString
          }.finally {
            self.parent.image = safeImage
          }
        }
      }
    }
    
    private func generateImageName(_ image: UIImage, provider: NSItemProvider) -> Promise<String> {
      Promise<String> { seal in
        provider.loadFileRepresentation(forTypeIdentifier: "public.item") { url, error in
          if let url = url {
            seal.fulfill(url.lastPathComponent)
          } else {
            log?.error(error ?? StorageError.couldNotDecodeFile)
            seal.reject(error ?? StorageError.couldNotDecodeFile)
          }
        }
      }
    }
    
  }
  
}
