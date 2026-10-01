//
//  WatchWidgets.swift
//  WatchWidgets
//
//  Created by Senalbert Rodriguez on 4/20/26.
//

import WidgetKit
import SwiftUI

// MARK: - 1. Timeline Logic
// This tells the Apple Watch how often to refresh your complications.
struct SimpleProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
            var entries: [SimpleEntry] = []
            let currentDate = Date()
            
            // 1. Give the widget an entry for right this second
            entries.append(SimpleEntry(date: currentDate))
            
            // 2. Find the exact start of the next hour (e.g., exactly 1:00 AM)
            let nextHour = Calendar.autoupdatingCurrent.nextDate(after: currentDate, matching: DateComponents(minute: 0), matchingPolicy: .nextTime) ?? currentDate
            
            // 3. Schedule the widget to wake up exactly on the hour, every hour, for the next 3 days
            for hourOffset in 0...72 {
                if let scheduledTime = Calendar.autoupdatingCurrent.date(byAdding: .hour, value: hourOffset, to: nextHour) {
                    entries.append(SimpleEntry(date: scheduledTime))
                }
            }
            
            // 4. When it runs out of schedule in 3 days, ask Xcode for a new batch (.atEnd)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: - 2. AM / PM Complication
private enum WidgetFormatters {
    static let amPmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a" // "a" is Apple's secret code for AM/PM
        formatter.locale = Locale(identifier: "en_US_POSIX") // Forces vintage uppercase English AM/PM
        formatter.timeZone = .autoupdatingCurrent // Live timezone tracking
        return formatter
    }()
}

struct AMPMWidgetEntryView : View {
    var entry: SimpleProvider.Entry

    // Figures out if it's AM or PM based on exact local geography using cached formatter
    var amOrPm: String {
        WidgetFormatters.amPmFormatter.string(from: entry.date)
    }

    var body: some View {
            Text(amOrPm)
                // The Casio-style styling: bold and monospaced
                .font(.system(.title2, design: .monospaced).weight(.medium))
                // Keeps it perfectly centered
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                // Shrinks the text slightly if the watch face slot is small
                .minimumScaleFactor(0.5)
                .unredacted()
        }
    }
struct AMPMWidget: Widget {
    let kind: String = "AMPMWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SimpleProvider()) { entry in
            if #available(watchOS 10.0, *) {
                AMPMWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                AMPMWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("AM / PM")
        .description("Displays AM or PM in a retro font.")
        // Supports circles, rectangles, and in-line text slots
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
    }
}

// MARK: - 3. DST Complication
struct DSTWidgetEntryView : View {
    var entry: SimpleProvider.Entry

    // Checks the time zone to see if DST is currently active
    var dstText: String {
        let isDST = TimeZone.autoupdatingCurrent.isDaylightSavingTime(for: entry.date)
        return isDST ? "DST" : "" // Leaves it blank if it's standard time
    }

    var body: some View {
            Text(dstText)
                .font(.system(.title2, design: .monospaced).weight(.medium))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .minimumScaleFactor(0.5)
                .unredacted()
        }
    }

struct DSTWidget: Widget {
    let kind: String = "DSTWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SimpleProvider()) { entry in
            if #available(watchOS 10.0, *) {
                DSTWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DSTWidgetEntryView(entry: entry)
            }
        }
        .configurationDisplayName("DST Status")
        .description("Displays DST when Daylight Saving Time is active.")
        .supportedFamilies([.accessoryCircular, .accessoryRectangular, .accessoryInline])
    }
}

// MARK: - 4. The App Bundle
// This packages both complications together into your single free app!
@main
struct DigitalWatchWidgetsBundle: WidgetBundle {
    var body: some Widget {
        AMPMWidget()
        DSTWidget()
    }
}
