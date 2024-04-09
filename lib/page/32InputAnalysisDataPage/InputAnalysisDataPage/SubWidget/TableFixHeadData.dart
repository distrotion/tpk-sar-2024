import 'package:flutter/material.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021


class TableFixHeadData extends StatefulWidget {
  const TableFixHeadData({Key? key}) : super(key: key);

  @override
  _TableFixHeadDataState createState() => _TableFixHeadDataState();
}

class _TableFixHeadDataState extends State<TableFixHeadData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
/*     _letters.dispose();
    _numbers.dispose(); */
    super.dispose();
  }

  int columnHeight = 20;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //Header
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                headerName("NO", 30),
                headerName("CUSTOMER NAME", 100),
                headerName("REQUEST TYPE", 100),
                headerName("SAMPLING DATE", 100),
                headerName("RECEIVE DATE", 100),
                headerName("SAMPLE TYPE # SAMPLE NAME", 100),
                headerName("CHEMICAL NAME", 100),
                headerName("ITEM NAME", 100),

            ],
            ),
          ),
        ],
      ),
    );
  }
}


Container headerName(String name, double width) {
  TextStyle stylesection =
      TextStyle(fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

  return Container(
    height: 50,
    width: width,
    decoration:
        BoxDecoration(border: Border.all(width: 0.5, color: Colors.black)),
    child: Center(
      child: Text(
        name,
        style: stylesection,
        textAlign: TextAlign.center,
      ),
    ),
  );
}
