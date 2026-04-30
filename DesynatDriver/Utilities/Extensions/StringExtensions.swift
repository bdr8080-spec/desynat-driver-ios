//
//  StringExtensions.swift
//  DemoProject
//
//  Created by Rakhi Kumari on 22/09/25.
//

import Foundation

extension String {
    
    func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
