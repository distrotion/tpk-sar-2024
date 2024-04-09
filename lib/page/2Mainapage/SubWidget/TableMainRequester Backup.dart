import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocChagpage.dart';
import 'package:tpk_login_arsa_01/page/2Mainapage/Data/TableMainRequesterStructure.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class TableMainRequest extends StatefulWidget {
  const TableMainRequest();

  @override
  _TableMainRequestState createState() => _TableMainRequestState();
}

class _TableMainRequestState extends State<TableMainRequest>
    with RestorationMixin {
  //edit
  final RestorableDataSelections _dataSelections =
      RestorableDataSelections(); //
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage = RestorableInt(5);
  /* RestorableInt(PaginatedDataTable.defaultRowsPerPage); */
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  late TableMainRequesterDataSource _dataSource; //
  bool initialized = false;

  @override
  String get restorationId => 'paginated_data_table';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_dataSelections, 'selected_row_indices');
    registerForRestoration(_rowIndex, 'current_row_index');
    registerForRestoration(_rowsPerPage, 'rows_per_page');
    registerForRestoration(_sortAscending, 'sort_ascending');
    registerForRestoration(_sortColumnIndex, 'sort_column_index');

    if (!initialized) {
      _dataSource = TableMainRequesterDataSource(context);
      initialized = true;
    }
    switch (_sortColumnIndex.value) {
      case 0:
        _dataSource.sort<String>((d) => d.reqNo, _sortAscending.value);
        break;
      case 1:
        _dataSource.sort<String>((d) => d.jobType, _sortAscending.value);
        break;
      case 2:
        _dataSource.sort<String>((d) => d.reqDate, _sortAscending.value);
        break;
      case 3:
        _dataSource.sort<String>((d) => d.reqDate, _sortAscending.value);
        break;
      case 4:
        _dataSource.sort<String>((d) => d.custFull, _sortAscending.value);
        break;
      case 5:
        _dataSource.sort<String>((d) => d.requestStatus, _sortAscending.value);
        break;
      case 6:
        _dataSource.sort<String>((d) => d.requestStatus, _sortAscending.value);
        break;
      case 7:
        _dataSource.sort<String>((d) => d.sampleName1, _sortAscending.value);
        break;
      case 8:
        _dataSource.sort<String>(
            (d) => d.manualDataStatus, _sortAscending.value);
        break;
      case 9:
        _dataSource.sort<String>((d) => d.reportStatus, _sortAscending.value);
        break;
    }
    _dataSource.updateSelectedData(_dataSelections);
    _dataSource.addListener(_updateSelectedDataRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      _dataSource = TableMainRequesterDataSource(context);
      initialized = true;
    }
    _dataSource.addListener(_updateSelectedDataRowListener);
  }

  void _updateSelectedDataRowListener() {
    _dataSelections.setDataSelections(_dataSource.dataSource);
  }

  void sort<T>(
    Comparable<T> Function(ModelTableMainRequester d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _dataSource.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex.value = columnIndex;
      _sortAscending.value = ascending;
    });
  }

  @override
  void dispose() {
    _rowsPerPage.dispose();
    _sortColumnIndex.dispose();
    _sortAscending.dispose();
    _dataSource.removeListener(_updateSelectedDataRowListener);
    _dataSource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      restorationId: 'paginated_data_table_list_view',
      //padding: const EdgeInsets.all(16),
      children: [
        PaginatedDataTable(
          header: Center(
            child: Text(
              'USER REQUEST LIST',
              style: TextStyle(
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          //actions: [InkWell(child: Text("AAA"),onTap:()=> print("aaaaa"),)],
          headingRowHeight: 30,
          showCheckboxColumn: false,
          availableRowsPerPage: <int>[5, 10, 20, 50],
          columnSpacing: 12,
          horizontalMargin: 20,
          dataRowHeight: 30,
          rowsPerPage: _rowsPerPage.value,
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage.value = value!;
            });
          },
          initialFirstRowIndex: _rowIndex.value,
          onPageChanged: (rowIndex) {
            setState(() {
              _rowIndex.value = rowIndex;
            });
          },
          sortColumnIndex: _sortColumnIndex.value,
          sortAscending: _sortAscending.value,
          onSelectAll: _dataSource.selectAll,
          source: _dataSource,
          columns: [
            DataColumn(
              label: Text('REQUEST NO',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reqNo, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('JOB TYPE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'TYPE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.jobType, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('REQ. DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric:
                  false, // Deliberately set to false to avoid right alignment.
              tooltip: 'DATE REQUEST CREATE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reqDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMP. DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric:
                  false, // Deliberately set to false to avoid right alignment.
              tooltip: 'SAMPLING DATE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reqDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('CUSTOMER NAME',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'CUSTOMER NAME',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.custFull, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('REQ.STATUS',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.requestStatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMP.STATUS',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: "SAMPLE STATUS",
            ),
            DataColumn(
              label: Text('MAN.DATA',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: '',
              onSort: (columnIndex, ascending) => sort<String>(
                  (d) => d.manualDataStatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('REPO.STATUS',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'REPORT STATUS',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reportStatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('DUE REPORT',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'DUE DATE REPORT',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reportStatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('NEXT APPROVER',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'N.APPROVER',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reportStatus, columnIndex, ascending),
            ),
          ],
        ),
      ],
    );
  }
}

TextStyle styleDataRow = TextStyle(fontSize: 12, fontFamily: 'Mitr');
TextStyle styleDataColumn =
    TextStyle(fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'Mitr');

class TableMainRequesterDataSource extends DataTableSource {
  final BuildContext context;
  late List<ModelTableMainRequester> dataSource;

  TableMainRequesterDataSource.empty(this.context) {
    dataSource = [];
  }

  TableMainRequesterDataSource(this.context) {
    dataSource = mainRequesterData;
  }

  void sort<T>(Comparable<T> Function(ModelTableMainRequester d) getField,
      bool ascending) {
    dataSource.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;
  void updateSelectedData(RestorableDataSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < dataSource.length; i += 1) {
      var dataBuff = dataSource[i];
      if (selectedRows.isSelected(i)) {
        dataBuff.selected = true;
        _selectedCount += 1;
      } else {
        dataBuff.selected = false;
      }
    }
    notifyListeners();
  }

  void updateSelectedDataFromSet(Set<int> selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < dataSource.length; i += 1) {
      var dataBuff = dataSource[i];
      if (selectedRows.contains(i)) {
        dataBuff.selected = true;
        _selectedCount += 1;
      } else {
        dataBuff.selected = false;
      }
    }
    notifyListeners();
  }

  @override
  DataRow getRow(int index) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= dataSource.length) throw 'index > _desserts.length';
    final dataBuff = dataSource[index];
    String picSample1 = "";
    String picSample2 = "";
    String picSample3 = "";
    String picSample4 = "";
    String picSample5 = "";
    if (dataBuff.sampleStatus1 == "WAIT SAMPLE") {
      picSample1 = "assets/images/waitsample.png";
    } else if (dataBuff.sampleStatus1 == "SEND SAMPLE") {
      picSample1 = "assets/images/sendsample.png";
    } else if (dataBuff.sampleStatus1 == "RECEIVE SAMPLE") {
      picSample1 = "assets/images/receivedsample.png";
    } else if (dataBuff.sampleStatus1 == "REJECT SAMPLE") {
      picSample1 = "assets/images/rejectsample.png";
    } else if (dataBuff.sampleStatus1 == "NOT SEND SAMPLE") {
      picSample1 = "assets/images/notsendsample.png";
    } else {
      picSample1 = "assets/images/nosample.png";
    }
    if (dataBuff.sampleStatus2 == "WAIT SAMPLE") {
      picSample2 = "assets/images/waitsample.png";
    } else if (dataBuff.sampleStatus2 == "SEND SAMPLE") {
      picSample2 = "assets/images/sendsample.png";
    } else if (dataBuff.sampleStatus2 == "RECEIVE SAMPLE") {
      picSample2 = "assets/images/receivedsample.png";
    } else if (dataBuff.sampleStatus2 == "REJECT SAMPLE") {
      picSample2 = "assets/images/rejectsample.png";
    } else if (dataBuff.sampleStatus2 == "NOT SEND SAMPLE") {
      picSample2 = "assets/images/notsendsample.png";
    } else {
      picSample2 = "assets/images/nosample.png";
    }
    if (dataBuff.sampleStatus3 == "WAIT SAMPLE") {
      picSample3 = "assets/images/waitsample.png";
    } else if (dataBuff.sampleStatus3 == "SEND SAMPLE") {
      picSample3 = "assets/images/sendsample.png";
    } else if (dataBuff.sampleStatus3 == "RECEIVE SAMPLE") {
      picSample3 = "assets/images/receivedsample.png";
    } else if (dataBuff.sampleStatus3 == "REJECT SAMPLE") {
      picSample3 = "assets/images/rejectsample.png";
    } else if (dataBuff.sampleStatus3 == "NOT SEND SAMPLE") {
      picSample3 = "assets/images/notsendsample.png";
    } else {
      picSample3 = "assets/images/nosample.png";
    }
    if (dataBuff.sampleStatus4 == "WAIT SAMPLE") {
      picSample4 = "assets/images/waitsample.png";
    } else if (dataBuff.sampleStatus4 == "SEND SAMPLE") {
      picSample4 = "assets/images/sendsample.png";
    } else if (dataBuff.sampleStatus4 == "RECEIVE SAMPLE") {
      picSample4 = "assets/images/receivedsample.png";
    } else if (dataBuff.sampleStatus4 == "REJECT SAMPLE") {
      picSample4 = "assets/images/rejectsample.png";
    } else if (dataBuff.sampleStatus4 == "NOT SEND SAMPLE") {
      picSample4 = "assets/images/notsendsample.png";
    } else {
      picSample4 = "assets/images/nosample.png";
    }
    if (dataBuff.sampleStatus5 == "WAIT SAMPLE") {
      picSample5 = "assets/images/waitsample.png";
    } else if (dataBuff.sampleStatus5 == "SEND SAMPLE") {
      picSample5 = "assets/images/sendsample.png";
    } else if (dataBuff.sampleStatus5 == "RECEIVE SAMPLE") {
      picSample5 = "assets/images/receivedsample.png";
    } else if (dataBuff.sampleStatus5 == "REJECT SAMPLE") {
      picSample5 = "assets/images/rejectsample.png";
    } else if (dataBuff.sampleStatus5 == "NOT SEND SAMPLE") {
      picSample5 = "assets/images/notsendsample.png";
    } else {
      picSample5 = "assets/images/nosample.png";
    }

    return DataRow.byIndex(
      index: index,
      selected: dataBuff.selected,
      onSelectChanged: (value) async {
        final SharedPreferences prefs = await _prefs;
        await prefs.setString(
            'RoutineRequestDetailRequesterPage_reqNo', dataBuff.reqNo);
        BlocProvider.of<SwPageCubit>(context).togglePage("RefreshPage");
        BlocProvider.of<SwPageCubit>(context)
            .togglePage("RoutineRequestDetailRequesterPage");
      },
      cells: [
        DataCell(Container(
            //width: 90,
            child: Text(dataBuff.reqNo,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.jobType,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.reqDate,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.samplingDate,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            width: 250,
            child: Text(dataBuff.custFull,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.requestStatus,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(
          Container(
            width: 110,
            child: Wrap(
              children: [
                if (dataBuff.sampleName1 != "")
                  statusSampleLamp(
                      dataBuff.sampleName1, dataBuff.sampleStatus1),
                if (dataBuff.sampleName2 != "")
                  statusSampleLamp(
                      dataBuff.sampleName2, dataBuff.sampleStatus2),
                if (dataBuff.sampleName3 != "")
                  statusSampleLamp(
                      dataBuff.sampleName3, dataBuff.sampleStatus3),
                if (dataBuff.sampleName4 != "")
                  statusSampleLamp(
                      dataBuff.sampleName4, dataBuff.sampleStatus4),
                if (dataBuff.sampleName5 != "")
                  statusSampleLamp(
                      dataBuff.sampleName5, dataBuff.sampleStatus5),
                if (dataBuff.sampleName6 != "")
                  statusSampleLamp(
                      dataBuff.sampleName6, dataBuff.sampleStatus6),
                if (dataBuff.sampleName7 != "")
                  statusSampleLamp(
                      dataBuff.sampleName7, dataBuff.sampleStatus7),
                if (dataBuff.sampleName8 != "")
                  statusSampleLamp(
                      dataBuff.sampleName8, dataBuff.sampleStatus8),
                if (dataBuff.sampleName9 != "")
                  statusSampleLamp(
                      dataBuff.sampleName9, dataBuff.sampleStatus9),
                if (dataBuff.sampleName10 != "")
                  statusSampleLamp(
                      dataBuff.sampleName10, dataBuff.sampleStatus10),
              ],
            ),
            /* Row(children: [
              Container(
                height: 25,
                child: Tooltip(
                    message: dataBuff.sampleName1,
                    child: Image.asset(picSample1)),
              ),
              Container(
                height: 25,
                child: Tooltip(
                    message: dataBuff.sampleName2,
                    child: Image.asset(picSample2)),
              ),
              Container(
                height: 25,
                child: Tooltip(
                    message: dataBuff.sampleName3,
                    child: Image.asset(picSample3)),
              ),
              Container(
                height: 25,
                child: Tooltip(
                    message: dataBuff.sampleName4,
                    child: Image.asset(picSample4)),
              ),
              Container(
                height: 25,
                child: Tooltip(
                    message: dataBuff.sampleName5,
                    child: Image.asset(picSample5)),
              ),
            ]) */
          ),
        ),
        DataCell(Container(
            child: Text(dataBuff.manualDataStatus,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.reportStatus,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.reportDueDate,
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.nextApprover,
                style: styleDataRow, textAlign: TextAlign.start))),
      ],
    );
  }

  @override
  int get rowCount => dataSource.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void selectAll(bool? checked) {
    for (final dataBuff in dataSource) {
      dataBuff.selected = checked ?? false;
    }
    _selectedCount = (checked ?? false) ? dataSource.length : 0;
    notifyListeners();
  }
}

class RestorableDataSelections extends RestorableProperty<Set<int>> {
  Set<int> _dataSelections = {};

  /// Returns whether or not a dessert row is selected by index.
  bool isSelected(int index) => _dataSelections.contains(index);

  /// Takes a list of [Dessert]s and saves the row indices of selected rows
  /// into a [Set].
  void setDataSelections(List<ModelTableMainRequester> dataIn) {
    final updatedSet = <int>{};
    for (var i = 0; i < dataIn.length; i += 1) {
      var data = dataIn[i];
      if (data.selected) {
        updatedSet.add(i);
      }
    }
    _dataSelections = updatedSet;
    notifyListeners();
  }

  @override
  Set<int> createDefaultValue() => _dataSelections;

  @override
  Set<int> fromPrimitives(Object? data) {
    final selectedItemIndices = data as List<dynamic>;
    _dataSelections = {
      ...selectedItemIndices.map<int>((dynamic id) => id as int),
    };
    return _dataSelections;
  }

  @override
  void initWithValue(Set<int> value) {
    _dataSelections = value;
  }

  @override
  Object toPrimitives() => _dataSelections.toList();
}
