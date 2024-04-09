/* import 'package:cool_alert/cool_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_login_arsa_01/global_structure.dart';
import 'package:tpk_login_arsa_01/global_var.dart';
import 'package:http/http.dart' as http;

List<ModelFullRequestData> item_itemData = [];
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

Future searchItemDetailData() async {
  final SharedPreferences prefs = await _prefs;
  String id = prefs.getString('ItemDetailPage_itemId') ?? "";
  Map<String, String> qParams = {
    'Id': id,
  };
  print("in searchItemDetailData");
  final response = await http.get(
      Uri.parse("$url/ItemDetailPage_SearchItemDetailData"),
      headers: qParams);
  if (response.statusCode == 200) {
    item_itemData = modelFullRequestDataFromJson(response.body);
    //print("IN Search item detail${modelFullRequestDataToJson(item_itemData)}");
    return response.body;
  } else {
    CoolAlert.show(
      width: 150,
      context: contextBG,
      type: CoolAlertType.error,
      title: 'Oops...',
      text: 'NOT FOUND ITEM',
      loopAnimation: false,
    );
    return;
  }
}
 */