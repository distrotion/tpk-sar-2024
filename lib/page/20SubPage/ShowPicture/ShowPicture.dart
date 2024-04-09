import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/page/20SubPage/ShowPicture/Data/ShowPictureData.dart';
import 'dart:html' as html;

void showPicture(String _path, BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          //title: Text('HISTORY DATA'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: ShowPicture(path: _path),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        );
      });
}

// ignore: must_be_immutable
class ShowPicture extends StatefulWidget {
  String path = "";
  ShowPicture({
    required this.path,
  });

  @override
  State<StatefulWidget> createState() => ShowPictureState();
}

class ShowPictureState extends State<ShowPicture> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
  }

  void saveImageToBrowser(String base64String, String fileName) {
    final bytes = base64.decode(base64String);
    final blob = html.Blob([bytes], 'image/png');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..download = fileName;
    html.document.body?.append(anchor);
    anchor.click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPicture(widget.path),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != 0) {
              var outputAsUint8List;
              outputAsUint8List = base64.decode(picture);
              return Column(
                children: [
                  Container(
                    width: 600,
                    child: outputAsUint8List != null
                        ? Image.memory(outputAsUint8List!,
                            //width: 250, height: 250,
                            fit: BoxFit.cover)
                        : Container(),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.save),
                    onPressed: () {
                      saveImageToBrowser(picture, "fileName");
                    },
                  ),
                ],
              );
            } else {
              return Text("NO HISTORY DATA");
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
