//
//  CustomMultiLineTextField.swift
//  chat
//
//  Created by Imran Abdullah on 27/08/23.
//

import SwiftUI

struct CustomMultiLineTextField: UIViewRepresentable {
    var placeHolder: String
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.text = placeHolder
        textView.textColor = UIColor.lightGray
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if text != "" {
            uiView.text = text
            uiView.textColor = UIColor.black
        } else {
            uiView.text = placeHolder
            uiView.textColor = UIColor.lightGray
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomMultiLineTextField

        init(_ parent: CustomMultiLineTextField) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeHolder
                textView.textColor = UIColor.lightGray
            }
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

