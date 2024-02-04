import SwiftUI
import AVFoundation
import Vision

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
    @State private var isImagePickerPresented: Bool = false
    @State private var scannedTexts: [String] = []
    @State private var isCameraActive: Bool = true
    
    var body: some View {
        VStack {
            Button(action: {
                isImagePickerPresented.toggle()
                isCameraActive = true
            }) {
                HStack {
                    Image(systemName: "camera")
                    Text("Adicionar Item")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0.818, green: 0.652, blue: 0.218))
                .cornerRadius(10)
                .fontWeight(.bold)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(scannedTexts: $scannedTexts, isCameraActive: $isCameraActive)
            }
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

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var scannedTexts: [String]
    @Binding var isCameraActive: Bool

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                processImage(uiImage)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        func processImage(_ image: UIImage) {
            guard let cgImage = image.cgImage else { return }

            let requestHandler = VNImageRequestHandler(cgImage: cgImage)

            do {
                let request = VNRecognizeTextRequest(completionHandler: { request, error in
                    if let error = error {
                        print("Error in recognizing text: \(error.localizedDescription)")
                        return
                    }

                    if let results = request.results as? [VNRecognizedTextObservation] {
                        let recognizedTexts = results.compactMap { observation in
                            observation.topCandidates(1).first?.string
                        }.filter { $0.count >= 5 }

                        DispatchQueue.main.async {
                            self.parent.scannedTexts.append(contentsOf: recognizedTexts)
                        }
                    }
                })

                try requestHandler.perform([request])
            } catch {
                print("Error in processing image: \(error.localizedDescription)")
            }
        }
    }

    @Environment(\.presentationMode) var presentationMode

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator

        if isCameraActive {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
        }

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePickerView>) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

