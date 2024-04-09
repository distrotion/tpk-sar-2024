import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/page/30RequestDetailTTC/data/RoutineRequestDetailTTCPageStructure.dart';


// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

List<ModelTableResultDetail> dataTableResultApprove = [];

class TableResultApprove extends StatefulWidget {
  const TableResultApprove();

  @override
  _TableResultApproveState createState() => _TableResultApproveState();
}

class _TableResultApproveState extends State<TableResultApprove>
    with RestorationMixin {
  //edit
  final RestorableDataSelections _dataSelections = RestorableDataSelections();
  final RestorableInt _rowIndex = RestorableInt(0);
  final RestorableInt _rowsPerPage = RestorableInt(10);
  final RestorableBool _sortAscending = RestorableBool(true);
  final RestorableIntN _sortColumnIndex = RestorableIntN(null);
  late TableDataSource _dataSource;
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
      _dataSource = TableDataSource(context);
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
        _dataSource.sort<String>((d) => d.custFull, _sortAscending.value);
        break;
      case 3:
        _dataSource.sort<String>((d) => d.incharge, _sortAscending.value);
        break;
      case 4:
        _dataSource.sort<String>((d) => d.samplingDate, _sortAscending.value);
        break;
      case 5:
        _dataSource.sort<String>((d) => d.receiveDate, _sortAscending.value);
        break;
      case 6:
        _dataSource.sort<String>((d) => d.userReceive, _sortAscending.value);
        break;
      case 7:
        _dataSource.sort<String>(
            (d) => d.analysisDueDate, _sortAscending.value);
        break;
    }
    _dataSource.updateSelectedData(_dataSelections);
    _dataSource.addListener(_updateSelectedDataRowListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      _dataSource = TableDataSource(context);
      initialized = true;
    }
    _dataSource.addListener(_updateSelectedDataRowListener);
  }

  void _updateSelectedDataRowListener() {
    _dataSelections.setDataSelections(_dataSource.dataSource);
  }

  void sort<T>(
    Comparable<T> Function(ModelTableResultDetail d) getField,
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
          header: Text(
            'HISTORY DATA',
            style: TextStyle(
                fontFamily: 'Mitr',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          /* actions: [
            InkWell(
                child: Text("LIST ITEM"),
                onTap: () => print(
                    modelTableResultApproveToJson(dataTableResultApprove)))
          ], */
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
              label: Text('REQ NO',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'REQUEST NO',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.reqNo, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('JOB TYPE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'JOB TYPE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.jobType, columnIndex, ascending),
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
              label: Text('INCHARGE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'INCHARGE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.incharge, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMP.DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'SAMPLING DATE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.samplingDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('RECE.DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'RECEIVE DATE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.receiveDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('RECEIVER BY',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.userReceive, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('ANAL.DUE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: "ANALYSIS DUEDATE",
              onSort: (columnIndex, ascending) => sort<String>(
                  (d) => d.analysisDueDate, columnIndex, ascending),
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

class TableDataSource extends DataTableSource {
  final BuildContext context;
  late List<ModelTableResultDetail> dataSource;

  TableDataSource.empty(this.context) {
    dataSource = [];
  }

  TableDataSource(this.context) {
    print(dataTableResultApprove);
    dataSource = dataTableResultApprove;
  }

  void sort<T>(Comparable<T> Function(ModelTableResultDetail d) getField,
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
    return DataRow.byIndex(
      index: index,
      selected: dataBuff.selected,
      onSelectChanged: (value) {
        
        /* if (dataBuff.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dataBuff.selected = value;
          notifyListeners();
          print(jsonEncode(dataBuff));
        } */
      },
      cells: [
        DataCell(Container(
            width: 100,
            child: Text(dataBuff.reqNo.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            width: 100,
            child: Text(dataBuff.jobType.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.custFull.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            //width: 150,
            child: Text(dataBuff.incharge.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            width: 150,
            child: Text(dataBuff.samplingDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.receiveDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.userReceive.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.analysisDueDate.toString(),
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
  void setDataSelections(List<ModelTableResultDetail> dataIn) {
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
