//
//  Home.swift
//  MaternalFoster
//
//  Created by Jason Lopez on 5/1/26.
//

import SwiftUI

struct Home: View {
    @State private var showSidebar = false
    @EnvironmentObject var auth: Authentication
    @EnvironmentObject var navigation: AppNavigation

    var body: some View {
        ZStack(alignment: .leading) {
            Background()
            
            // main content
            ZStack(alignment: .top) {
                Image("mother")
                    .resizable()
                    .ignoresSafeArea()
                    .offset(y: 80)
                    .frame(maxHeight: 260)
                
                VStack(spacing: 0) {
                    NavBar(
                        isSignedIn: auth.user != nil,
                        onMenuTap: {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showSidebar = true
                            }
                        },
                        onSignInTap: {
                            Task {
                                await auth.signInWithGoogle()
                            }
                        },
                        onSignOutTap: {
                            auth.signOut()
                        },
                        onHomeTap: {}
                    )
                    
                    VStack(spacing: 20) {
                        HStack {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Support for Every Step of Pregnancy")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text("Track your pregnancy, learn what matters, and prepare for every stage.")
                                    .font(.body)
                                    .foregroundStyle(.black.opacity(0.6))
                                
                                if auth.user == nil {
                                    Button {
                                        Task {
                                            await auth.signInWithGoogle()
                                        }
                                    } label: {
                                        Text("Sign in to get started")
                                            .fontWeight(.semibold)
                                            .padding(.horizontal, 38)
                                            .padding(.vertical, 12)
                                    }
                                    .background(Color(hex: "#f8aaa6"))
                                    .foregroundStyle(Color.white)
                                    .clipShape(Capsule())
                                } else {
                                    NavigationLink(value: AppRoute.dueDate) {
                                        Text("Calculate Due Date")
                                            .fontWeight(.semibold)
                                            .padding(.horizontal, 38)
                                            .padding(.vertical, 12)
                                    }
                                    .background(Color(hex: "#f8aaa6"))
                                    .foregroundStyle(Color.white)
                                    .clipShape(Capsule())
                                }
                                 
                                if let error = auth.authError {
                                    Text(error)
                                        .font(.caption)
                                        .foregroundStyle(.red)
                                }
                            }
                            .frame(width: 270, alignment: .leading)
                            .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 30)
                        FeatureGrid(isSignedIn: auth.user != nil)
                    }
                    Spacer()
                }
            }
            
            // sidebar only for signed in users
            if auth.user != nil {
                Color.black.opacity(showSidebar ? 0.35 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            showSidebar = false
                        }
                    }
                    .allowsHitTesting(showSidebar)
                
                Sidebar {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        showSidebar = false
                    }
                }
                .offset(x: showSidebar ? 0 : -220)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showSidebar)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    Home()
        .environmentObject(Authentication())
}
