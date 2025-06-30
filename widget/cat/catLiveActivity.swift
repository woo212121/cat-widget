//
//  catLiveActivity.swift
//  cat
//
//  Created by woo on 30/06/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct catAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct catLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: catAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension catAttributes {
    fileprivate static var preview: catAttributes {
        catAttributes(name: "World")
    }
}

extension catAttributes.ContentState {
    fileprivate static var smiley: catAttributes.ContentState {
        catAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: catAttributes.ContentState {
         catAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: catAttributes.preview) {
   catLiveActivity()
} contentStates: {
    catAttributes.ContentState.smiley
    catAttributes.ContentState.starEyes
}
