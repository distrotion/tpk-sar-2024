import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

void showPDF(String pdf64, BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return AlertDialog(
          //title: Text('HISTORY DATA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: width - 100,
                height: height - 200,
                child: PdfPreview(
                  build: (format) {
                    return base64.decode(pdf64);
                  },
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(child: Text('CLOSE')),
            )
          ],
        );
      });
}
