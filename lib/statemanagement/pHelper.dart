import 'package:flutter/widgets.dart';
import 'package:todo_app/database/dbHelper.dart';

class pHelper with ChangeNotifier {
  List<Map<String, dynamic>> XList = [];

  Dbhelper DB = Dbhelper.Instance;

  /// get function to get all todo as list from database
  List<Map<String, dynamic>> get allTodos => XList;

  /// fetch todos from database
  Future<List<Map<String, dynamic>>> Fetch_Todos_List() async {
    XList = await DB.fetchDB();
    notifyListeners();
    return XList;
  }

  /// insert todo
  Future<bool> addTodo({required String mtitle}) async {
    var isDone = await DB.insertDB(title: mtitle);
    if (isDone) {
      XList = await Fetch_Todos_List();
    } else {}
    notifyListeners();
    return isDone;
  }

  /// update todo
  Future<bool> updateTodo({required String mtitle, required int mid}) async {
    var isDone = await DB.updateDB(id: mid, title: mtitle);
    if (isDone) {
      XList = await Fetch_Todos_List();
    } else {}
    notifyListeners();
    return isDone;
  }

  /// delete todo
  Future<bool> deleteTodo({required int mid}) async {
    var isDone = await DB.deleteDB(id: mid);
    if (isDone) {
      XList = await Fetch_Todos_List();
    } else {}
    notifyListeners();
    return isDone;
  }

  /// todoStatuschecker
  Future<bool> todoStatusUpdate({
    required int mid,
    required bool misDone,
  }) async {
    var isDone = await DB.updateIsDone(id: mid, isDone: misDone);
    if (isDone) {
      XList = await Fetch_Todos_List();
    } else {}
    notifyListeners();
    return isDone;
  }

  /// filterList
  List<Map<String, dynamic>> filterList({required String keyword}) {
    List<Map<String, dynamic>> filteredList = [];
    if (keyword.isEmpty) {
      filteredList = XList;
    } else {
      filteredList = XList.where((todo) {
        return todo[Dbhelper.COLUMN_TITLE].toString().toLowerCase().contains(
          keyword.toLowerCase(),
        );
      }).toList();
    }
    notifyListeners();
    return filteredList;
  }
}
