//
//  WebView.swift
//  COVID-Tracker
//
//  Created by Jeremy Yarley on 11/19/20.
//


import SwiftUI
import SafariServices


struct WebView: UIViewControllerRepresentable {
    
    @Binding var urlString: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        return SFSafariViewController(url: URL(string: urlString)!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlString: .constant("https://www.google.com/"))
    }
}
