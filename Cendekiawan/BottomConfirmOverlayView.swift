//
//  BottomConfirmOverlayView.swift
//  Cendekiawan
//
//  Created by Nathanael Juan Gauthama on 24/06/24.
//

import SwiftUI

struct BottomConfirmOverlayView: View {
    var isCorrect: Bool
    var description: String
    var button: Button3D
    var action: () -> Void
    var body: some View {
        ZStack{
            Rectangle()
                .frame(height: 105)
                .foregroundStyle(Color.yellowMuda)
            HStack{
                if button.text != "Periksa" {
                    VStack(alignment: .leading){
                        Text("Sedikit lagi sudah benar!")
                            .foregroundStyle(Color.black)
                            .font(.headline)
                        HStack{
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .foregroundStyle(Color.red)
                            Text("Jawaban yang benar adalah amanat!")
                        }
                        
                    }
                }
                Spacer()
                Button3D(text: "Periksa", color: Color.orange)
            }.padding([.horizontal], 28)
            
        }
    }
}

#Preview {
    BottomConfirmOverlayView(isCorrect: false, description: "", button: Button3D(text: "Periksa", color: Color.orange), action: {})
}
