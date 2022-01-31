//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try font.validate()
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 5 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")
    /// Color `AddColor`.
    static let addColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AddColor")
    /// Color `BackgroundColor`.
    static let backgroundColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "BackgroundColor")
    /// Color `ButtonColor`.
    static let buttonColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "ButtonColor")
    /// Color `SecondaryColor`.
    static let secondaryColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "SecondaryColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AddColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func addColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.addColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "BackgroundColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func backgroundColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.backgroundColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "ButtonColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func buttonColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.buttonColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "SecondaryColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func secondaryColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.secondaryColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AddColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func addColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.addColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "BackgroundColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func backgroundColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.backgroundColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "ButtonColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func buttonColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.buttonColor.name)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "SecondaryColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func secondaryColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.secondaryColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.file` struct is generated, and contains static references to 10 files.
  struct file {
    /// Resource file `Alegreya-Black.ttf`.
    static let alegreyaBlackTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-Black", pathExtension: "ttf")
    /// Resource file `Alegreya-BlackItalic.ttf`.
    static let alegreyaBlackItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-BlackItalic", pathExtension: "ttf")
    /// Resource file `Alegreya-Bold.ttf`.
    static let alegreyaBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-Bold", pathExtension: "ttf")
    /// Resource file `Alegreya-BoldItalic.ttf`.
    static let alegreyaBoldItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-BoldItalic", pathExtension: "ttf")
    /// Resource file `Alegreya-ExtraBold.ttf`.
    static let alegreyaExtraBoldTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-ExtraBold", pathExtension: "ttf")
    /// Resource file `Alegreya-ExtraBoldItalic.ttf`.
    static let alegreyaExtraBoldItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-ExtraBoldItalic", pathExtension: "ttf")
    /// Resource file `Alegreya-Italic.ttf`.
    static let alegreyaItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-Italic", pathExtension: "ttf")
    /// Resource file `Alegreya-Medium.ttf`.
    static let alegreyaMediumTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-Medium", pathExtension: "ttf")
    /// Resource file `Alegreya-MediumItalic.ttf`.
    static let alegreyaMediumItalicTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-MediumItalic", pathExtension: "ttf")
    /// Resource file `Alegreya-Regular.ttf`.
    static let alegreyaRegularTtf = Rswift.FileResource(bundle: R.hostingBundle, name: "Alegreya-Regular", pathExtension: "ttf")

    /// `bundle.url(forResource: "Alegreya-Black", withExtension: "ttf")`
    static func alegreyaBlackTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaBlackTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-BlackItalic", withExtension: "ttf")`
    static func alegreyaBlackItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaBlackItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-Bold", withExtension: "ttf")`
    static func alegreyaBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-BoldItalic", withExtension: "ttf")`
    static func alegreyaBoldItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaBoldItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-ExtraBold", withExtension: "ttf")`
    static func alegreyaExtraBoldTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaExtraBoldTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-ExtraBoldItalic", withExtension: "ttf")`
    static func alegreyaExtraBoldItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaExtraBoldItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-Italic", withExtension: "ttf")`
    static func alegreyaItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-Medium", withExtension: "ttf")`
    static func alegreyaMediumTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaMediumTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-MediumItalic", withExtension: "ttf")`
    static func alegreyaMediumItalicTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaMediumItalicTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    /// `bundle.url(forResource: "Alegreya-Regular", withExtension: "ttf")`
    static func alegreyaRegularTtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.alegreyaRegularTtf
      return fileResource.bundle.url(forResource: fileResource)
    }

    fileprivate init() {}
  }

  /// This `R.font` struct is generated, and contains static references to 10 fonts.
  struct font: Rswift.Validatable {
    /// Font `Alegreya-BlackItalic`.
    static let alegreyaBlackItalic = Rswift.FontResource(fontName: "Alegreya-BlackItalic")
    /// Font `Alegreya-Black`.
    static let alegreyaBlack = Rswift.FontResource(fontName: "Alegreya-Black")
    /// Font `Alegreya-BoldItalic`.
    static let alegreyaBoldItalic = Rswift.FontResource(fontName: "Alegreya-BoldItalic")
    /// Font `Alegreya-Bold`.
    static let alegreyaBold = Rswift.FontResource(fontName: "Alegreya-Bold")
    /// Font `Alegreya-ExtraBoldItalic`.
    static let alegreyaExtraBoldItalic = Rswift.FontResource(fontName: "Alegreya-ExtraBoldItalic")
    /// Font `Alegreya-ExtraBold`.
    static let alegreyaExtraBold = Rswift.FontResource(fontName: "Alegreya-ExtraBold")
    /// Font `Alegreya-Italic`.
    static let alegreyaItalic = Rswift.FontResource(fontName: "Alegreya-Italic")
    /// Font `Alegreya-MediumItalic`.
    static let alegreyaMediumItalic = Rswift.FontResource(fontName: "Alegreya-MediumItalic")
    /// Font `Alegreya-Medium`.
    static let alegreyaMedium = Rswift.FontResource(fontName: "Alegreya-Medium")
    /// Font `Alegreya-Regular`.
    static let alegreyaRegular = Rswift.FontResource(fontName: "Alegreya-Regular")

    /// `UIFont(name: "Alegreya-Black", size: ...)`
    static func alegreyaBlack(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaBlack, size: size)
    }

    /// `UIFont(name: "Alegreya-BlackItalic", size: ...)`
    static func alegreyaBlackItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaBlackItalic, size: size)
    }

    /// `UIFont(name: "Alegreya-Bold", size: ...)`
    static func alegreyaBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaBold, size: size)
    }

    /// `UIFont(name: "Alegreya-BoldItalic", size: ...)`
    static func alegreyaBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaBoldItalic, size: size)
    }

    /// `UIFont(name: "Alegreya-ExtraBold", size: ...)`
    static func alegreyaExtraBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaExtraBold, size: size)
    }

    /// `UIFont(name: "Alegreya-ExtraBoldItalic", size: ...)`
    static func alegreyaExtraBoldItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaExtraBoldItalic, size: size)
    }

    /// `UIFont(name: "Alegreya-Italic", size: ...)`
    static func alegreyaItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaItalic, size: size)
    }

    /// `UIFont(name: "Alegreya-Medium", size: ...)`
    static func alegreyaMedium(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaMedium, size: size)
    }

    /// `UIFont(name: "Alegreya-MediumItalic", size: ...)`
    static func alegreyaMediumItalic(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaMediumItalic, size: size)
    }

    /// `UIFont(name: "Alegreya-Regular", size: ...)`
    static func alegreyaRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: alegreyaRegular, size: size)
    }

    static func validate() throws {
      if R.font.alegreyaBlack(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-Black' could not be loaded, is 'Alegreya-Black.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaBlackItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-BlackItalic' could not be loaded, is 'Alegreya-BlackItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-Bold' could not be loaded, is 'Alegreya-Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-BoldItalic' could not be loaded, is 'Alegreya-BoldItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaExtraBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-ExtraBold' could not be loaded, is 'Alegreya-ExtraBold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaExtraBoldItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-ExtraBoldItalic' could not be loaded, is 'Alegreya-ExtraBoldItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-Italic' could not be loaded, is 'Alegreya-Italic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaMedium(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-Medium' could not be loaded, is 'Alegreya-Medium.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaMediumItalic(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-MediumItalic' could not be loaded, is 'Alegreya-MediumItalic.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.alegreyaRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'Alegreya-Regular' could not be loaded, is 'Alegreya-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 18 images.
  struct image {
    /// Image `Anxious`.
    static let anxious = Rswift.ImageResource(bundle: R.hostingBundle, name: "Anxious")
    /// Image `Background`.
    static let background = Rswift.ImageResource(bundle: R.hostingBundle, name: "Background")
    /// Image `Calm`.
    static let calm = Rswift.ImageResource(bundle: R.hostingBundle, name: "Calm")
    /// Image `Content1`.
    static let content1 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Content1")
    /// Image `Content2`.
    static let content2 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Content2")
    /// Image `Content3`.
    static let content3 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Content3")
    /// Image `Content4`.
    static let content4 = Rswift.ImageResource(bundle: R.hostingBundle, name: "Content4")
    /// Image `Focus`.
    static let focus = Rswift.ImageResource(bundle: R.hostingBundle, name: "Focus")
    /// Image `Hamburger`.
    static let hamburger = Rswift.ImageResource(bundle: R.hostingBundle, name: "Hamburger")
    /// Image `HomeChosen`.
    static let homeChosen = Rswift.ImageResource(bundle: R.hostingBundle, name: "HomeChosen")
    /// Image `Home`.
    static let home = Rswift.ImageResource(bundle: R.hostingBundle, name: "Home")
    /// Image `Koala`.
    static let koala = Rswift.ImageResource(bundle: R.hostingBundle, name: "Koala")
    /// Image `Leafs`.
    static let leafs = Rswift.ImageResource(bundle: R.hostingBundle, name: "Leafs")
    /// Image `Logo`.
    static let logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "Logo")
    /// Image `ProfileChosen`.
    static let profileChosen = Rswift.ImageResource(bundle: R.hostingBundle, name: "ProfileChosen")
    /// Image `Profile`.
    static let profile = Rswift.ImageResource(bundle: R.hostingBundle, name: "Profile")
    /// Image `Relax`.
    static let relax = Rswift.ImageResource(bundle: R.hostingBundle, name: "Relax")
    /// Image `Sound`.
    static let sound = Rswift.ImageResource(bundle: R.hostingBundle, name: "Sound")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Anxious", bundle: ..., traitCollection: ...)`
    static func anxious(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.anxious, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Background", bundle: ..., traitCollection: ...)`
    static func background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.background, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Calm", bundle: ..., traitCollection: ...)`
    static func calm(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calm, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Content1", bundle: ..., traitCollection: ...)`
    static func content1(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.content1, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Content2", bundle: ..., traitCollection: ...)`
    static func content2(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.content2, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Content3", bundle: ..., traitCollection: ...)`
    static func content3(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.content3, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Content4", bundle: ..., traitCollection: ...)`
    static func content4(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.content4, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Focus", bundle: ..., traitCollection: ...)`
    static func focus(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.focus, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Hamburger", bundle: ..., traitCollection: ...)`
    static func hamburger(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.hamburger, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Home", bundle: ..., traitCollection: ...)`
    static func home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HomeChosen", bundle: ..., traitCollection: ...)`
    static func homeChosen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.homeChosen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Koala", bundle: ..., traitCollection: ...)`
    static func koala(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.koala, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Leafs", bundle: ..., traitCollection: ...)`
    static func leafs(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.leafs, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Logo", bundle: ..., traitCollection: ...)`
    static func logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.logo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Profile", bundle: ..., traitCollection: ...)`
    static func profile(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.profile, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "ProfileChosen", bundle: ..., traitCollection: ...)`
    static func profileChosen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.profileChosen, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Relax", bundle: ..., traitCollection: ...)`
    static func relax(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.relax, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Sound", bundle: ..., traitCollection: ...)`
    static func sound(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sound, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.networkErrors` struct is generated, and contains static references to 4 localization keys.
    struct networkErrors {
      /// Value: Не удалось получить запрошенные данные с сервера
      static let errorNoDataReceivedText = Rswift.StringResource(key: "error.no.data.received.text", tableName: "NetworkErrors", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Неверный ответ сервера
      static let errorDecodingText = Rswift.StringResource(key: "error.decoding.text", tableName: "NetworkErrors", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Неизвестная серверная ошибка
      static let errorUnknownText = Rswift.StringResource(key: "error.unknown.text", tableName: "NetworkErrors", bundle: R.hostingBundle, locales: [], comment: nil)
      /// Value: Ссылка составлена некорректно
      static let errorInvalidUrlText = Rswift.StringResource(key: "error.invalid.url.text", tableName: "NetworkErrors", bundle: R.hostingBundle, locales: [], comment: nil)

      /// Value: Не удалось получить запрошенные данные с сервера
      static func errorNoDataReceivedText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error.no.data.received.text", tableName: "NetworkErrors", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "NetworkErrors", preferredLanguages: preferredLanguages) else {
          return "error.no.data.received.text"
        }

        return NSLocalizedString("error.no.data.received.text", tableName: "NetworkErrors", bundle: bundle, comment: "")
      }

      /// Value: Неверный ответ сервера
      static func errorDecodingText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error.decoding.text", tableName: "NetworkErrors", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "NetworkErrors", preferredLanguages: preferredLanguages) else {
          return "error.decoding.text"
        }

        return NSLocalizedString("error.decoding.text", tableName: "NetworkErrors", bundle: bundle, comment: "")
      }

      /// Value: Неизвестная серверная ошибка
      static func errorUnknownText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error.unknown.text", tableName: "NetworkErrors", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "NetworkErrors", preferredLanguages: preferredLanguages) else {
          return "error.unknown.text"
        }

        return NSLocalizedString("error.unknown.text", tableName: "NetworkErrors", bundle: bundle, comment: "")
      }

      /// Value: Ссылка составлена некорректно
      static func errorInvalidUrlText(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("error.invalid.url.text", tableName: "NetworkErrors", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "NetworkErrors", preferredLanguages: preferredLanguages) else {
          return "error.invalid.url.text"
        }

        return NSLocalizedString("error.invalid.url.text", tableName: "NetworkErrors", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if UIKit.UIImage(named: "Background", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Background' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Logo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
