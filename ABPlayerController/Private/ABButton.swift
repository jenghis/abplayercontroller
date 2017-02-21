// Copyright 2017 Jenghis
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Cocoa

class ABButton: NSButton, ABTintable {
    @IBInspectable var lightTint: NSImage?
    @IBInspectable var darkTint: NSImage?

    var isDarkMode: Bool {
        return effectiveAppearance.name == NSAppearanceNameVibrantDark
    }

    func updateTint() {
        image = isDarkMode ? darkTint : lightTint
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Track cursor events to perform custom button highlighting
        let options: NSTrackingAreaOptions = [
            .mouseEnteredAndExited,
            .activeInActiveApp,
            .enabledDuringMouseDrag
        ]
        let trackingArea = NSTrackingArea(rect: bounds,
                                          options: options,
                                          owner: self,
                                          userInfo: nil)
        addTrackingArea(trackingArea)
    }

    override func mouseDown(with theEvent: NSEvent) {
        if isEnabled { alphaValue = 0.8 }
    }

    override func mouseUp(with theEvent: NSEvent) {
        if isEnabled && alphaValue == 0.8 {
            let _ = target?.perform(action, with: self)
            alphaValue = 1
        }
    }

    override open func mouseExited(with theEvent: NSEvent) {
        if isEnabled && alphaValue == 0.8 { alphaValue = 1 }
    }
}
