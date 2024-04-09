import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/HistoryDataExcel/Data/HistoryDataExcelData.dart';
import 'dart:typed_data';
import 'dart:html' as html;

void saveExcelFile(Uint8List buffer) {
  // Convert the buffer to a base64 string
  String base64String = base64Encode(buffer);

  // Create an anchor element
  html.AnchorElement? downloadLink =
      html.document.createElement('a') as html.AnchorElement?;

  // Set the href and download attributes of the anchor element
  downloadLink?.href =
      'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,$base64String';
  downloadLink?.download = 'example.xlsx';

  // Click the anchor element to trigger a download of the Excel file
  downloadLink?.click();
}

class ButtonSaveHistoryExcel extends StatefulWidget {
  String custFull = "";
  ButtonSaveHistoryExcel({Key? key, required this.custFull}) : super(key: key);

  @override
  State<ButtonSaveHistoryExcel> createState() => _ButtonSaveHistoryExcelState();
}

/* 
void saveExcelFile(String bufferExcel, String fileName) {
  // final bytes = base64.decode(base64String);
  final blob = html.Blob([bufferExcel], 'xlsx');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..download = fileName;
  html.document.body?.append(anchor);
  anchor.click();
  html.Url.revokeObjectUrl(url);
  print("in2");
  /* final blob = js.JsObject(
    js.context['Blob'],
    [bufferExcel],
  );
  final url = js.context['URL'].callMethod('createObjectURL', [blob]);
  final link = js.JsObject(js.context['a'], []);
  link['href'] = url;
  link['download'] = fileName;
  link.callMethod('click', []);
  js.context['URL'].callMethod('revokeObjectURL', [url]); */
}
 */
class _ButtonSaveHistoryExcelState extends State<ButtonSaveHistoryExcel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.save),
        onPressed: () async {
          if (await getHistoryDataExcel(widget.custFull) == 1) {
            print("in");
            Uint8List uint8List = Uint8List.fromList(utf8.encode(bufferExcel));
            print(uint8List);
            saveExcelFile(uint8List);
          }
        },
      ),
    );
  }
}
