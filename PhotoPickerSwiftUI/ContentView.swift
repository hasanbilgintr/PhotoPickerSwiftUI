//
//  ContentView.swift
//  PhotoPickerSwiftUI
//
//  Created by hasan bilgin on 10.11.2023.
//

import SwiftUI
//eklendi
import PhotosUI


struct ContentView: View {
    @State var selectedItem : [PhotosPickerItem] = []
    @State var data : Data?
    
    var body: some View {
        VStack {
            //nasılsa değişkenler değiştiğinde görünümde değiştiği için üstede yer alabilir
            if let data = data {
                if let selectedImage = UIImage(data: data){
                    Spacer()
                    Image(uiImage: selectedImage).resizable().frame(width: 300,height: 250,alignment: .center)
                }
            }
            Spacer()
            
            //selection seçtikten sonra hangi değişkene atayım
            //maxSelectionCount en fazla kaç tane fotoğraf seçebilsin kullanıcı
            //selectionBehavior seçme davramışı nasıl olmalı // kullanma zorunluluğu yok
            //matching görselmi videomu herşey olabilir,images,panaramas,screenRecordings,screenshots,livePhoto b aya detaylı seçim yapılabilir
            //image sayısı 2 ve fazlası olduğu anca okadar izin veriyo
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                Text("Select Image")
                //onChange yani item seçilince anlamında
            }.onChange(of: selectedItem) { newValue in
                //birden fazla for loopada sokulabilir 1 tane varsa öle yaptık
                guard let item = selectedItem.first else {
                    return
                }
                
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            self .data = data
                        }
                    case .failure(let error):
                        print(error)
                    }
                    
                }
            }
            

            
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
