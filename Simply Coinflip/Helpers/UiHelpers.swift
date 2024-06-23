import UIKit

enum DeviceType {
    case iPhone, iPad, AppleWatch, unknown
}

public func currentDeviceType() -> String? {
    #if os(iOS)
    if UIDevice.current.userInterfaceIdiom == .phone {
        return "iPhone"
    } else if UIDevice.current.userInterfaceIdiom == .pad {
        return "iPad"
    }
    #elseif os(watchOS)
    return "Apple Watch"
    #endif
    return nil
}

public func isPhoneSideways() -> Bool {
    guard let currentDevice = currentDeviceType() else {
        return false
    }
    
    if currentDevice == "Apple Watch" {
        return false  // Apple Watch does not have landscape orientation
    } else if currentDevice == "iPhone" {
        return true
    }
    
    return false
}
