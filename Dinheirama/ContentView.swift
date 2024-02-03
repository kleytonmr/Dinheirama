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
        VStack {
            Button("Adicionar Item") {
                // Código para adicionar um novo item
            }
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 0.818, green: 0.652, blue: 0.218))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1) // Adiciona uma borda curva preta de 1 ponto
            )
        }
        .frame(width: 200)
    }
}

struct LabelView: View {
    var body: some View {
        HStack {
            Text("Nome")
                .fontWeight(.bold)
                .frame(width: 120)
            Spacer()
            Text("Valor")
                .fontWeight(.bold)
                .frame(width: 120)
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var items = [
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
        Item(name: "Name of Item 1", value: 10.0),
    ]

    var body: some View {
        NavigationView {
            List {
                Section(header: LabelView()) {
                    ForEach(items) { item in
                        ItemView(item: item)
                            .listRowInsets(EdgeInsets())
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .onDelete(perform: deleteItem)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Dinheirama 💸", displayMode: .inline)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        ButtonlView()
                        Spacer()
                        Text(String(format: "R$ %.2f", items.reduce(0, { $0 + $1.value })))
                            .fontWeight(.bold)
                            .frame(width: 140)
                    }
                    .padding()
                    .background(Color.gray)
                }
            )
        }
    }

    private func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

