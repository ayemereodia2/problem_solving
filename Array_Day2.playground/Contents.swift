import SwiftUI
import PlaygroundSupport
// Fixed Frames.

//PlaygroundPage.current.setLiveView(
//    Text("Happy WWDC 21!")
//        .foregroundColor(Color.white)
//        .frame(width: 50, height: 50)
//        .border(Color.red)
//        .frame(width: 300, height: 300)
//        .border(Color.white)
//        .background(Color.black)
//)

//PlaygroundPage.current.setLiveView(
//    Rectangle()
//        .fill(Color.green)
//        .frame(width: 100, height: 100)
//        .frame(width: 50, height: 50)
//        .border(Color.yellow)
//        .frame(width: 300, height: 300)
//        .background(Color.black)
//)

//PlaygroundPage.current.setLiveView(
//    Text("Happy WWDC 21!")
//        .foregroundColor(Color.white)
//        .border(Color.green)
//        .frame(minWidth: 20)
//        .border(Color.red)
//        .frame(width: 300, height: 300)
//        .background(Color.black)
//)


//PlaygroundPage.current.setLiveView(
//    Text("Happy WWDC 21!")
//        .foregroundColor(Color.white)
//        .border(Color.green)
//        .frame(maxWidth: 100)
//        .border(Color.red)
//        .frame(width: 300, height: 300)
//        .background(Color.black)
//)


struct ContentView: View {
  var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 10) {
        Text("GeometryReader")
          .font(.title)
        Text("Buttons example")
          .font(.subheadline)
        
        HStack() {
          Button("Button 1") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.orange)
          Button("Button 2") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.yellow)
          Button("Button 3") {}
            .frame(width: geometry.size.width/3, height: 50)
            .background(.green)
        }
      }
    }
  }
}

let contentView = ContentView()

PlaygroundPage.current.setLiveView(contentView)
