//
//  Constants.swift
//  AccountLuckyNumber
//
//  Created by Piyada Suwansa-ard on 1/10/2562 BE.
//  Copyright © 2562 bobo. All rights reserved.
//

import Foundation
import UIKit

enum Key: String {
    case accountNumber = "accountNumber"
    case accountType = "accountType"
    case firstname = "firstname"
    case lastname = "lastname"
    case accountLuckyNumber = "accountLuckyNumber"
}

enum Response: String {
    case connectSuccess = "connect success"
    case createSuccess = "create success"
    case writeSuccess = "write success"
    case readSuccess = "read success"
    case updateSuccess = "update success"
    case deleteSuccess = "delete success"
    
    
    case connectionError = "connect failed"
    case createError = "create failed"
    case writeError = "write failed"
    case readError = "read failed"
    case updateError = "update failed"
    case deleteError = "delete failed"
}

enum StringResource: String {
    case luckyCategoryTitle = "เลขบัญชีมงคล"
    case chooseLuckyCategoryTitle = "เลือกประเภทเลขบัญชีมงคล"
    case luckyLoveCategory = "ความรัก"
    case luckyWorkCategory = "การงาน"
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func imageWithGradient(img:UIImage!) -> UIImage {
    
    UIGraphicsBeginImageContext(img.size)
    let context = UIGraphicsGetCurrentContext()
    
    img.draw(at: CGPoint(x: 0, y: 0))
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let locations:[CGFloat] = [0.0, 1.0]
    
    let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
    
    let colors = [top, bottom] as CFArray
    
    let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
    
    let startPoint = CGPoint(x: img.size.width/2, y: 0)
    let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
    
    context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image!
}

func convertToGrayScale(image: UIImage) -> UIImage {
    let imageRect:CGRect = CGRect(x:0, y:0, width:image.size.width, height: image.size.height)
    let colorSpace = CGColorSpaceCreateDeviceGray()
    let width = image.size.width
    let height = image.size.height
    
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
    let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
    //have to draw before create image
    
    context?.draw(image.cgImage!, in: imageRect)
    let imageRef = context!.makeImage()
    let newImage = UIImage(cgImage: imageRef!)
    
    return newImage
}
