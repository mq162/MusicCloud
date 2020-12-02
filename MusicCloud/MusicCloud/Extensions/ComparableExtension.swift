//
//  ComparableExtension.swift
//  MusicCloud
//
//  Created by Quang Pham on 02/12/2020.
//

import Foundation

extension Comparable {
    func clamp(to limits: ClosedRange<Self>) -> Self {
        return min(max(limits.lowerBound, self), limits.upperBound)
    }
}
