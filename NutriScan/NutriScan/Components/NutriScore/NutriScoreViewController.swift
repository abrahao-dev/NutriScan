//
//  NutriScoreViewController.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 25/09/25.
//

import Foundation
import SwiftUI

// MARK: - View
struct NutriScoreView: View {
    let selectedScore: NumberScore
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("NUTRI-SCORE")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.gray)
            HStack(spacing: 0) {
                ForEach(NumberScore.allCases, id: \.self) { score in
                    scoreSegment(for: score)
                }
            }
            .frame(height: 50)
            .frame(width: 170)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    @ViewBuilder
    private func scoreSegment(for score: NumberScore) -> some View {
        ZStack {
            // muda a cor de fundo
            color(for: score)
            Text(score.label) // pega o valor do score
                .if(score == selectedScore) { view in
                    view
                        .font(.system(size: 40, weight: .heavy))
                        .foregroundColor(.white)
                } else: { view in
                    view
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white.opacity(0.6))
                }
            
                .frame(maxWidth: .infinity)
                .frame(minWidth: 34)
        }
    }

    // MARK: - Cores Dinamicas
    private func color(for score: NumberScore) -> Color {
        switch score {
        case .scoreA:
            return Color(red: 0.12, green: 0.49, blue: 0.22)
        case .scoreB:
            return Color(red: 0.53, green: 0.73, blue: 0.24)
        case .scoreC:
            return Color(red: 0.99, green: 0.80, blue: 0.25)
        case .scoreD:
            return Color(red: 0.95, green: 0.51, blue: 0.21)
        case .scoreE:
            return Color(red: 0.91, green: 0.29, blue: 0.22)
        }
    }
}

// MARK: - Extensão para facilitar o 'if' em modificadores
extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content, else elseTransform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            elseTransform(self)
        }
    }
}


// MARK: - Preview
#Preview {
    NutriScoreView(selectedScore: .scoreA)
        .padding()
    NutriScoreView(selectedScore: .scoreB)
        .padding()
    NutriScoreView(selectedScore: .scoreC)
        .padding()
    NutriScoreView(selectedScore: .scoreD)
        .padding()
    NutriScoreView(selectedScore: .scoreE)
        .padding()
}
