import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/page/8ListJobPage/Data/ListJobPageStructure.dart';
import 'package:tpk_login_arsa_01/page/8ListJobPage/Data/ListJobPage_bloc.dart';

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

class TableWaitList extends StatefulWidget {
  const TableWaitList();

  @override
  _TableWaitListState createState() => _TableWaitListState();
}

class _TableWaitListState extends State<TableWaitList> with RestorationMixin {
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
      /*  case 0:
        _dataSource.sort<String>((d) => d.custShort, _sortAscending.value);
        break;
      case 1:
        _dataSource.sort<String>((d) => d.instrumentName, _sortAscending.value);
        break;
      case 2:
        _dataSource.sort<String>((d) => d.itemName, _sortAscending.value);
        break;
      case 3:
        _dataSource.sort<String>((d) => d.itemStatus, _sortAscending.value);
        break;
      case 4:
        _dataSource.sort<String>((d) => d.branch, _sortAscending.value);
        break;
      case 5:
        _dataSource.sort<String>((d) => d.sampleType, _sortAscending.value);
        break;
      case 6:
        _dataSource.sort<String>((d) => d.sampleName, _sortAscending.value);
        break;
      /* case 7:
        _dataSource.sort<int>((d) => d.sampleAmount, _sortAscending.value);
        break; */
      case 7:
        _dataSource.sort<DateTime>((d) => d.samplingDate, _sortAscending.value);
        break;
      case 8:
        _dataSource.sort<DateTime>((d) => d.receiveDate, _sortAscending.value);
        break;
      case 9:
        _dataSource.sort<DateTime>(
            (d) => d.analysisDueDate, _sortAscending.value);
        break; */
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
    Comparable<T> Function(ModelTableWaitList d) getField,
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
            'ITEM WAIT LIST',
            style: TextStyle(
                fontFamily: 'Mitr',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          /* actions: [
            InkWell(
              child: Text("LIST ITEM"),
              onTap: () => print("aaaaa"),
            )
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
            /* DataColumn(
              label: Text('SAMPLE NO',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.sampleCode, columnIndex, ascending),
            ), */
            DataColumn(
              label: Text('CUSTOMER',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'CUSTOMER NAME',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.custShort, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('INSTRUMENT',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'INSTRUMENT NAME',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.instrumentName, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('ITEM',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'ITEM NAME',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.itemName, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('ITEM STATUS',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'ITEM STATUS',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.itemStatus, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('BRANCH',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'BRANCH',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.branch, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMPLE TYPE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.sampleType, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMP.NAME',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: "SAMPLE NAME",
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.sampleName, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('SAMP.DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: "SAMPLING DATE",
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
              label: Text('DUE DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'ANALYSIS DUE DATE',
              onSort: (columnIndex, ascending) => sort<String>(
                  (d) => d.analysisDueDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('REMARK',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'ERROR REMARK',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.errorName, columnIndex, ascending),
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
  late List<ModelTableWaitList> dataSource;

  TableDataSource.empty(this.context) {
    dataSource = [];
  }

  TableDataSource(this.context) {
    dataSource = dataTableWaitList;
  }

  void sort<T>(
      Comparable<T> Function(ModelTableWaitList d) getField, bool ascending) {
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
          BlocProvider.of<SwPageCubit>(context)
              .togglePage("RoutineCreteRequest");
        } */
      },
      cells: [
        /* DataCell(Container(
            width: 100,
            child: Text(dataBuff.sampleCode.toString(),
                style: styleDataRow, textAlign: TextAlign.start))), */
        DataCell(Container(
            //width: 100,
            child: Text(dataBuff.custShort.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.instrumentName.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            //width: 150,
            child: Text(dataBuff.itemName.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        /* DataCell(
          Container(child: statusItem(dataBuff.itemStatus.toString(), 12)),
        ), */
        DataCell(Container(
            child: Text(dataBuff.itemStatus.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.branch.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.sampleType.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.sampleName.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        /*  DataCell(Container(
            child: Text(dataBuff.sampleAmount.toString(),
                style: styleDataRow, textAlign: TextAlign.start))), */
        DataCell(Container(
            child: Text(dataBuff.samplingDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.receiveDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.analysisDueDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.errorName.toString(),
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
  void setDataSelections(List<ModelTableWaitList> dataIn) {
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
