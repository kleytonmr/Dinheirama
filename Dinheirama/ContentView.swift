import SwiftUI

// Interface
struct Item: Identifiable {
    let id = UUID()
    let name: String
    let value: Double
}

struct ItemView: View {
    var item: Item

    var body: some View {
        HStack {
            Text(item.name)
                .fontWeight(.bold)
                .frame(width: 150, alignment: .leading)
            Spacer()
            Text(String(format: "R$ %.2f", item.value))
                .fontWeight(.bold)
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct ButtonlView: View {
    var body: some View {
        HStack {
            Button("Adicionar Item") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }  
            .fontWeight(.bold)
            .frame(width: 150)
            
            Spacer()
            Text("R$ 100,00")
                .fontWeight(.bold)
                .frame(width: 150)
        }
        .padding()
    }
}

struct LabelView: View {
    var body: some View {
        HStack {
            Text("Nome")
                .fontWeight(.bold)
                .frame(width: 150)
            Spacer()
            Text("Valor")
                .fontWeight(.bold)
                .frame(width: 150)
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var items = [
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
        Item(name: "Name of Item 2", value: 10.0),
    ]

    var body: some View {
        VStack {
            LabelView()
                .padding(.horizontal)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(items) { item in
                        ItemView(item: item)
                            .listRowInsets(EdgeInsets())
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            ButtonlView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

