//
//  DisplayHabitView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 02/02/23.
//

import SwiftUI

struct DisplayHabitView: View {
    @FetchRequest(entity: Habit.entity(), sortDescriptors: []) private var habits: FetchedResults<Habit>
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(habits){ habit in
                        HabitCardView(habit: habit)
                    }
                }
               
            }
            .navigationTitle("Habits")
        }
        
    }
    @ViewBuilder
    func HabitCardView(habit: Habit)-> some View{
        VStack(spacing: 6){
            HStack{
                Text(habit.title ?? "")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Image(systemName: "bell.badge.fill")
                    .font(.callout)
                    .scaleEffect(0.9)
                    .opacity(habit.isRemainderOn ? 1 : 0)
                Spacer()
                
                let count = (habit.weekDays?.count ?? 0)
                Text(count == 7 ? "EveryDay" : "\(count) time a week")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal,10)
            
            let calendar = Calendar.current
            let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: Date())
            let symbols = calendar.weekdaySymbols
            let startDate = currentWeek?.start ?? Date()
           // let activeWeekDays = habit.weekDays ?? ["Monday"]
            let activePlot = symbols.indices.compactMap{ index -> (String,Date) in
                let currentDate = calendar.date(byAdding: .day, value: index, to: startDate)
                    return (symbols[index], currentDate!)
            }
            HStack(spacing: 0){
                ForEach(activePlot.indices,id: \.self){ index in
                    let item = activePlot[index]
                    
                    VStack(spacing: 6){
                        Text(item.0.prefix(3))
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        let status = (habit.weekDays ?? ["Monday"]).contains{ day in
                            return day == item.0
                        }
                        
                        Text(getDate(date: item.1))
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .padding(8)
                            .background{
                                Circle()
                                    .fill( Color("Pink") )
                                // current display week in red circle
                                    .opacity(status ? 1 : 0)
                            }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.top,15)
        }
        .padding(.vertical,5)
        .padding(.horizontal,6)
        .background{
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.gray.opacity(0.5))
        }
        .padding()
        .padding(.vertical,-10)
    }
    //formating date
    func getDate(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: date)
    }
}

struct DisplayHabitView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayHabitView()
    }
}
