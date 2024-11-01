//
//  SingleActivityView.swift
//  E.run
//
//  Created by Madina Jumaly on 26.10.2024.
//

import SwiftUI
import MapKit

struct ActivityItemView: View {
    var run: RunPayload
    var body: some View {
        VStack (alignment: .leading){
            Text(run.createdAt.timeOfDayString())
                .font(.title3)
                .bold()
            
            Text(run.createdAt.formatDate())
                .font(.caption)
            
            HStack (spacing: 24){
                VStack(alignment: .leading){
                    Text("Distance")
                        .font(.caption)
                    
                    Text("\(run.distance / 1000, specifier: "%.2f") km")
                        .font(.headline)
                        .bold()
                }
                
                VStack{
                    Text("Pace")
                        .font(.caption)
                    
                    Text("\(Int(run.pace)) min")
                        .font(.headline)
                        .bold()
                }
                
                VStack{
                    Text("Time")
                        .font(.caption)
                    
                    Text("\(run.time .convertDurationToString())")
                        .font(.headline)
                        .bold()
                }
            }
            .padding(.vertical)
            
            Map{
                MapPolygon(coordinates: convertRouteToCoordinates(geoJSON: run.route))
                    .foregroundStyle(.clear)
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
    }
    func convertRouteToCoordinates(geoJSON:[GeoJSONCoordinate]) -> [CLLocationCoordinate2D] {
        return geoJSON.map{CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longtitude)}
    }
}

#Preview {
    ActivityItemView(run: RunPayload(createdAt: .now, userId: .init(), distance: 124124, pace: 12, time: 1241, route: [GeoJSONCoordinate(longtitude: -41.144, latitude: 14.1412)]))
        .environmentObject(RunTracker())
}
