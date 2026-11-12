//
//  ContentView.swift
//  PM & DST Watch App
//
//  Created by Senalbert Rodriguez on 4/20/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // This creates a live ticking clock that updates every second
                TimelineView(.periodic(from: .now, by: 1.0)) { context in
                    let isDST = TimeZone.autoupdatingCurrent.isDaylightSavingTime(for: context.date)

                    VStack(spacing: 30) {

                        // 1. The Time and AM/PM
                        Text(context.date.formatted(date: .omitted, time: .shortened))
                            .font(.system(size: 36, design: .monospaced).weight(.medium))
                            .foregroundColor(.green)

                        // 2. The DST Status (two separate Texts so each one gets translated)
                        (isDST ? Text("Daylight Saving: ON") : Text("Daylight Saving: OFF"))
                            .font(.system(size: 14, design: .monospaced).weight(.regular))
                            .foregroundColor(isDST ? .green : .gray)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .padding(.top, 20)
                }

                // 3. Short how-to: kept to three steps so it's easy to read on the watch
                VStack(alignment: .leading, spacing: 6) {
                    Text("ADD TO WATCH FACE")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(.green)
                    Text("1. Touch and hold your watch face.\n2. Tap Edit.\n3. Choose PM & DST.")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 4)
            }
        }
    }
}

#Preview {
    ContentView()
}
