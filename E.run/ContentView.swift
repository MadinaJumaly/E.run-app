//
//  ContentView.swift
//  E.run
//
//  Created by Madina Jumaly on 11.10.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if let session = AuthService.shared.currentSession{
            E_runTabView()
                .task{
                    do {
                        try await HealthManager.shared.requestAuthorization()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        } else {
            LoginView()
        }
        
    }
    
}

#Preview {
    ContentView()
}
