//
//  ContentView.swift
//  PM & DST Watch App
//
//  Created by Senalbert Rodriguez on 4/20/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // This creates a live ticking clock that updates every second
        TimelineView(.periodic(from: .now, by: 1.0)) { context in
            VStack(spacing: 30) {
                
                // 1. The Time and AM/PM
                Text(context.date.formatted(date: .omitted, time: .shortened))
                    .font(.system(size: 36, design: .monospaced).weight(.medium))
                    .foregroundColor(.green)
                
                // 2. The DST Status
                Text(TimeZone.autoupdatingCurrent.isDaylightSavingTime(for: context.date) ? "Daylight Saving: ON" : "Daylight Saving: OFF")
                    .font(.system(size: 14, design: .monospaced).weight(.regular))
                    .foregroundColor(TimeZone.autoupdatingCurrent.isDaylightSavingTime(for: context.date) ? .green : .gray)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
