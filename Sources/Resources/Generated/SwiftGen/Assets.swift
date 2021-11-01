// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let background = ImageAsset(name: "background")
    internal static let icAvatar = ImageAsset(name: "ic_avatar")
    internal static let icAvatarBg = ImageAsset(name: "ic_avatar_bg")
    internal static let icBack = ImageAsset(name: "ic_back")
    internal static let icDetail = ImageAsset(name: "ic_detail")
    internal static let icFasterpayLogo = ImageAsset(name: "ic_fasterpay_logo")
    internal static let icHelp = ImageAsset(name: "ic_help")
    internal static let icInfo = ImageAsset(name: "ic_info")
    internal static let icLogout = ImageAsset(name: "ic_logout")
    internal static let icPassportLogo = ImageAsset(name: "ic_passport_logo")
    internal static let icPayment = ImageAsset(name: "ic_payment")
    internal static let icProfile = ImageAsset(name: "ic_profile")
    internal static let icScan = ImageAsset(name: "ic_scan")
    internal static let icSecurity = ImageAsset(name: "ic_security")
    internal static let icSuccess = ImageAsset(name: "ic_success")
    internal static let icSuccessBg = ImageAsset(name: "ic_success_bg")
    internal static let icTerm = ImageAsset(name: "ic_term")
    internal static let icTopup = ImageAsset(name: "ic_topup")
    internal static let icTouch = ImageAsset(name: "ic_touch")
    internal static let icVault = ImageAsset(name: "ic_vault")
    internal static let icWallet = ImageAsset(name: "ic_wallet")
    internal static let logo = ImageAsset(name: "logo")
  }
  internal enum Colors {
    internal static let accent = ColorAsset(name: "accent")
    internal static let gray = ColorAsset(name: "gray")
    internal static let main2 = ColorAsset(name: "main-2")
    internal static let main = ColorAsset(name: "main")
    internal static let mainBG = ColorAsset(name: "mainBG")
    internal static let text = ColorAsset(name: "text")
    internal static let textfieldBG = ColorAsset(name: "textfieldBG")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
