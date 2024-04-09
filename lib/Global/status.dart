import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget statusItem(String status, double size) {
  TextStyle fontStyle = TextStyle(
      fontSize: size, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  return Container(
    width: 65,
    height: 40,
    decoration: BoxDecoration(
      color: ((() {
        if (status == "WAIT SAMPLE" ||
            status == "SEND SAMPLE" ||
            status == "RECEIVE SAMPLE" ||
            status == "RECHECK" ||
            status == "RECONFIRM") {
          return Color(0xFFCAD5F0);
        } else if (status == "LIST NORMAL" ||
            status == "LIST RECHECK" ||
            status == "LIST RECONFIRM") {
          List<String> buff = status.split(' ');
          status = buff[1];
          return Color(0xFFFC9330);
        } else if (status == "FINISH NORMAL" ||
            status == "FINISH RECHECK" ||
            status == "FINISH RECONFIRM") {
          List<String> buff = status.split(' ');
          status = buff[1];
          return Color(0xFFCFFC30);
        } else if (status == "APPROVE" ||
            status == "COMPLETE" ||
            status == "COMPLETE NO LAB") {
          return Color(0xFF5CFC30);
        } else if (status == "REJECT SAMPLE" ||
            status == "CANCEL SAMPLE" ||
            status == "REQUEST RECONFIRM") {
          return Color(0xFFF28176);
        } else {
          return Color(0xFFF28176);
        }
      }())),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: fontStyle,
      ),
    ),
  );
}

Widget statusItemInstrumentInput(String status, double size) {
  TextStyle fontStyle = TextStyle(
      fontSize: size, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  return Container(
    width: 65,
    height: 40,
    decoration: BoxDecoration(
      color: ((() {
        if (status == "LIST NORMAL" ||
            status == "LIST RECHECK" ||
            status == "LIST RECONFIRM") {
          List<String> buff = status.split(' ');
          status = buff[1];
          if (status == "NORMAL") {
            status = "NRM";
          } else if (status == "RECHECK") {
            status = "RCH";
          } else if (status == "RECONFIRM") {
            status = "RCF";
          }

          return Color(0xFFFC9330);
        } else if (status == "FINISH NORMAL" ||
            status == "FINISH RECHECK" ||
            status == "FINISH RECONFIRM") {
          List<String> buff = status.split(' ');
          status = buff[1];
          if (status == "NORMAL") {
            status = "NRM";
          } else if (status == "RECHECK") {
            status = "RCH";
          } else if (status == "RECONFIRM") {
            status = "RCF";
          }
          return Color(0xFFCFFC30);
        } else if (status == "APPROVE" || status == "COMPLETE") {
          return Color(0xFF5CFC30);
        } else if (status == "REJECT SAMPLE" || status == "CANCEL SAMPLE") {
          return Color(0xFFF28176);
        } else {
          return Color(0xFFF28176);
        }
      }())),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: fontStyle,
      ),
    ),
  );
}

Widget statusSample(String status) {
  TextStyle fontStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.bold,
      fontFamily: 'Mitr',
      color: Colors.black);
  return Container(
    width: 100,
    height: 40,
    decoration: BoxDecoration(
      color: ((() {
        if (status == "WAIT SAMPLE") {
          return Color(0xFFCAD5F0);
        } else if (status == "SEND SAMPLE") {
          return Color(0xFFFC9330);
        } else if (status == "RECEIVE SAMPLE") {
          return Color(0xFFCFFC30);
        } else if (status == "WAIT APPROVE") {
          return Color(0xFFCFFC30);
        } else if (status == "APPROVE" ||
            status == "COMPLETE" ||
            status == "COMPLETE NO LAB") {
          return Color(0xFF5CFC30);
        } else if (status == "REJECT SAMPLE" || status == "CANCEL") {
          return Color(0xFFF28176);
        } else {
          return Color(0xFFF28176);
        }
      }())),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        status,
        style: fontStyle,
      ),
    ),
  );
}

Widget statusRequest(String status) {
  TextStyle fontStyle =
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'Mitr');
  return Container(
    width: 110,
    height: 20,
    decoration: BoxDecoration(
      color: ((() {
        if (status == "WAIT SAMPLE") {
          return Color(0xFFCAD5F0);
        } else if (status == "SEND SAMPLE") {
          return Color(0xFFFC9330);
        } else if (status == "RECEIVE SAMPLE") {
          return Color(0xFFCFFC30);
        } else if (status == "APPROVE" ||
            status == "COMPLETE" ||
            status == "COMPLETE NO LAB") {
          return Color(0xFF5CFC30);
        } else if (status == "REJECT SAMPLE" || status == "CANCEL") {
          return Color(0xFFF28176);
        } else {
          return Color(0xFFF28176);
        }
      }())),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Center(
      child: Text(
        status,
        style: fontStyle,
      ),
    ),
  );
}

Tooltip statusSampleLamp(String name, String status) {
  return Tooltip(
      message: '$name - $status',
      child: Container(
        width: 10,
        height: 10,
        decoration: new BoxDecoration(
          color: (() {
            if (status == "WAIT SAMPLE") {
              return Colors.grey;
            } else if (status == "WAIT SAMPLE") {
              return Colors.yellow;
            } else if (status == "REJECT SAMPLE") {
              return Colors.red;
            } else if (status == "RECEIVE SAMPLE") {
              return Colors.green;
            } else {
              return Colors.green;
            }
          }()),
          shape: BoxShape.circle,
        ),
      ));
}
