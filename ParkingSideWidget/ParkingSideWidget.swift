//
//  ParkingSideWidget.swift
//  ParkingSideWidget
//
//  Created by Алексей Хорошавин on 31.03.2023.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct ParkingSideWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
       getSign()
    }
}


struct OddSign: View {
    var body: some View {
        Image("odd")
    }
}

struct EvenSign: View {
    var body: some View {
        Image("even")
    }
}

struct BothSign: View {
    var body: some View {
        HStack {
            Image("odd")
            Image("even")
        }
    }
}

func getSign() -> some View {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let dateNumber = calendar.component(.day, from: date)
    
    
    if(hour < 19) {
        if(dateNumber % 2 == 0) {
            return AnyView(OddSign())
        } else {
            return AnyView(EvenSign())
        }
    } else if (hour > 21) {
        if(dateNumber % 2 == 0) {
            return AnyView(EvenSign())
        } else {
            return AnyView(OddSign())
        }
    }
    return AnyView(BothSign())
}


@main
struct ParkingSideWidget: Widget {
    let kind: String = "ParkingSideWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ParkingSideWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct ParkingSideWidget_Previews: PreviewProvider {
    static var previews: some View {
        ParkingSideWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
