//
//  BaseJsonObject.swift
//  YouTube
//
//  Created by Nguyen The Phuong on 12/5/17.
//  Copyright © 2017 Nguyen The Phuong. All rights reserved.
//

import UIKit

/**
 Mapping from dictionary to your model object even model missing some properties

 Ensure your property name and key of dictionary are the same

 From swift 4: you must to insert some anotation:
    - @objcMembers before your class
    - @objc before your class property
 */
class BaseJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        guard let firstCharacter = key.first else{
            return
        }
        let uppercasedFirstCharacter = String(describing: firstCharacter).uppercased()
        let range = NSRange(location: 0, length: 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        if !responds{
            return
        }
        super.setValue(value, forKey: key)
    }
}
