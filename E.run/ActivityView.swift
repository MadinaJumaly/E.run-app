//
//  ActivityView.swift
//  E.run
//
//  Created by Madina Jumaly on 21.10.2024.
//

import SwiftUI
import MapKit

struct ActivityView: View {
    @State var activities = [RunPayload]()
      
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities){ run in
                    NavigationLink {
                        ActivityItemView(run: run)
                    } label: {
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
                                    
                                    Text("\(run.pace, specifier: "%.2f") min")
                                        .font(.headline)
                                        .bold()
                                }
                                
                                VStack{
                                    Text("Time")
                                        .font(.caption)
                                    
                                    Text("\(run.time.convertDurationToString())")
                                        .font(.headline)
                                        .bold()
                                }
                            }
                            .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                }
            }
            .listStyle(.plain)
            .navigationTitle("Activity")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        Task {
                            do {
                                try await AuthService.shared.logout()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } label: {
                        Text("Logout")
                            .foregroundStyle(.red)
                    }

                }
            }
            .onAppear{
                Task {
                    do {
                        guard let userId = AuthService.shared.currentSession?.user.id else { return }
                        activities = try await DatabaseService.shared.fetchWorkouts(for: userId)
                        activities.sort(by: { $0.createdAt >= $1.createdAt})
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ActivityView()
}
