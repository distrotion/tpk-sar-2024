import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/Global/global_structure.dart';
import 'package:tpk_login_arsa_01/Global/status.dart';
import 'package:tpk_login_arsa_01/Layout/ChangePage/Data/BlocChagpage.dart';
import 'package:tpk_login_arsa_01/page/9ItemListPage/data/ItemListPage_bloc.dart';
import 'package:tpk_login_arsa_01/page/9ItemListPage/data/ItemListPage_event.dart';
// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// The file was extracted from GitHub: https://github.com/flutter/gallery
// Changes and modifications by Maxim Saplin, 2021

Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class TableListItem extends StatefulWidget {
  const TableListItem();

  @override
  _TableListItemState createState() => _TableListItemState();
}

class _TableListItemState extends State<TableListItem> with RestorationMixin {
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
        _dataSource.sort<String>((d) => d.sampleCode, _sortAscending.value);
        break;
      case 1:
        _dataSource.sort<String>((d) => d.itemName, _sortAscending.value);
        break;
      case 2:
        _dataSource.sort<String>((d) => d.remarkNo, _sortAscending.value);
        break;
      case 3:
        _dataSource.sort<String>((d) => d.jobType, _sortAscending.value);
        break;
      case 4:
        _dataSource.sort<String>((d) => d.custFull, _sortAscending.value);
        break;
      case 5:
        _dataSource.sort<String>((d) => d.samplingDate, _sortAscending.value);
        break;
      case 6:
        _dataSource.sort<String>((d) => d.itemStatus, _sortAscending.value);
        break;
      case 7:
        _dataSource.sort<String>((d) => d.sampleName, _sortAscending.value);
        break;
      case 8:
        _dataSource.sort<int>((d) => d.analysisDueDate, _sortAscending.value);
        break;
      case 9:
        _dataSource.sort<String>((d) => d.position, _sortAscending.value);
        break;
      case 10:
        _dataSource.sort<String>((d) => d.mag, _sortAscending.value);
        break;
      case 11:
        _dataSource.sort<String>((d) => d.temp, _sortAscending.value);
        break;
      case 12:
        _dataSource.sort<String>((d) => d.itemStatus, _sortAscending.value);
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
    Comparable<T> Function(ModelFullRequestData d) getField,
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
            'ITEM LIST',
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
            DataColumn(
              label: Text('SAMPLE CODE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'SAMPLE CODE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.sampleCode, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('ITEM NAME',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'ITEM NAME',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.itemName, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('JOB TYPE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'REQUEST TYPE',
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
              label: Text('SAMP.DATE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'SAMPLING DATE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.samplingDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('ITEM STATUS',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.itemStatus, columnIndex, ascending),
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
              label: Text('ANA.DUE',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: "ItemList DUE DATE",
              onSort: (columnIndex, ascending) => sort<String>(
                  (d) => d.analysisDueDate, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('POSITION',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'POSITION',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.position, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('MAG.',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'MAGIFICATION',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.mag, columnIndex, ascending),
            ),
            DataColumn(
              label: Text('TEMP',
                  style: styleDataColumn, textAlign: TextAlign.center),
              numeric: false,
              tooltip: 'TEMPERATURE',
              onSort: (columnIndex, ascending) =>
                  sort<String>((d) => d.temp, columnIndex, ascending),
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
  late List<ModelFullRequestData> dataSource;

  TableDataSource.empty(this.context) {
    dataSource = [];
  }

  TableDataSource(this.context) {
    dataSource = dataTablitemList;
  }

  void sort<T>(
      Comparable<T> Function(ModelFullRequestData d) getField, bool ascending) {
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

  void returnItem() {
    CoolAlert.show(
      barrierDismissible: false,
      width: 400,
      context: context,
      type: CoolAlertType.confirm,
      text: 'RETURN ITEM',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      loopAnimation: true,
      widget: Text(itemReturnData[0].itemName),
      onConfirmBtnTap: () {
        context
            .read<ManageDataItemListPage>()
            .add(ItemListPageEvent.returnItem);
       // Navigator.pop(context);
      },
      onCancelBtnTap: () {
       // Navigator.pop(context);
      },
    );
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
      onSelectChanged: (value) async {
        final SharedPreferences prefs = await _prefs;
        prefs.setString('ItemDetailPage_itemId', dataBuff.id.toString());
        BlocProvider.of<SwPageCubit>(context).togglePage("ItemDetailPage");
        dataItemSelected.clear();
        dataItemSelected.add(dataBuff);
        context
            .read<ManageDataItemListPage>()
            .add(ItemListPageEvent.selectInstrument);
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
            child: Text(dataBuff.sampleCode.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            width: 100,
            child: Text(dataBuff.itemName.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            //width: 150,
            child: Text(dataBuff.jobType.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            width: 150,
            child: Text(dataBuff.custFull.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.samplingDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(child: statusItem(dataBuff.itemStatus,12))),
        DataCell(Container(
            child: Text(dataBuff.sampleName.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.analysisDueDate.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.position.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.mag.toString(),
                style: styleDataRow, textAlign: TextAlign.start))),
        DataCell(Container(
            child: Text(dataBuff.temp.toString(),
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
  void setDataSelections(List<ModelFullRequestData> dataIn) {
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
