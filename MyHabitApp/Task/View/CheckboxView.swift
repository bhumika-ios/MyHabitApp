//
//  CheckboxView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 28/01/23.
//

import SwiftUI

struct CheckboxView: View {
    var label: String?
    var onToggle: (() -> Void)?
    
    @State private var checked = false
    
    init (label: String? = nil, defaultChecked: Bool? = false, onToggle: (() -> Void)? = {}) {
        self.label = label
        self.onToggle = onToggle
        _checked = .init(initialValue: defaultChecked ?? false)
    }
    
    var body: some View {
        HStack {
            if checked {
                Image(systemName: "checkmark.square")
                    .foregroundColor(Color("Pink"))
            } else {
                Image(systemName: "square")
            }
            
            if label != nil {
                Text(label!)
            }
        }.onTapGesture {
            withAnimation {
                checked.toggle()
                
                if onToggle != nil {
                    (onToggle!)()
                }
            }
        }
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxView()
            .previewLayout(.sizeThatFits)
        
        CheckboxView(label: "Some Label")
            .previewLayout(.sizeThatFits)
    }
}
