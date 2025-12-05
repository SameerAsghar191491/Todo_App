import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Screens/drawer.dart';
import 'package:todo_app/Screens/editBottomSheet.dart';
import 'package:todo_app/Screens/profile.dart';
import 'package:todo_app/utils/Utils.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/database/dbHelper.dart';
import 'package:todo_app/statemanagement/pHelper.dart';

class Todoapp extends StatefulWidget {
  const Todoapp({super.key});

  @override
  State<Todoapp> createState() => TodoappState();
}

class TodoappState extends State<Todoapp> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final textController = TextEditingController();
  final searchController = TextEditingController();
  pHelper phelper = pHelper();
  List<Map<String, dynamic>> initialList = [];
  List<Map<String, dynamic>> todoList = [];
  bool todoDone = false;
  String mkeyword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialNotes();
  }

  void getInitialNotes() async {
    debugPrint('initial function called');
    initialList = await context.read<pHelper>().Fetch_Todos_List();
    todoList = initialList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    debugPrint('build function called');
    final provider = Provider.of<pHelper>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: tdBGColor,
      key: globalKey,
      // drawerScrimColor: Colors.transparent,
      drawer: myDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            globalKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu, size: 30, color: tdBlack),
        ),
        backgroundColor: tdBGColor,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(size: 30),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(1), // border width
                decoration: BoxDecoration(
                  color: Colors.grey.shade600, // border color
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset('assets/profile_avatar.jpeg'),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: CircleAvatar(
          //     backgroundImage: AssetImage('assets/boy_logo.jpeg'),
          //   ),
          // ),
        ],
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  // height: height * 0.06,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      todoList = provider.filterList(keyword: value);
                      mkeyword = value;
                    },

                    controller: searchController,
                    decoration: InputDecoration(
                      hint: Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Search",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tdGrey,
                          ),
                        ),
                      ),
                      // hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      // icon: Icon(Icons.search),
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.only(bottom: 3, left: 5),
                      //   child: const Icon(
                      //     Icons.search,
                      //     size: 21,
                      //     color: tdGrey,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 21,
                        color: tdGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // const SizedBox(height: 20),
                Expanded(
                  child: Consumer<pHelper>(
                    builder: (ctx, value, _) {
                      debugPrint('consumer function called');
                      debugPrint(todoList.isEmpty.toString());
                      // todoList = value
                      //     .filterList(keyword: mkeyword)
                      //     .reversed
                      //     .toList();
                      return todoList.isNotEmpty
                          ? ListView.builder(
                              controller: ScrollController(),
                              itemCount: todoList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: ListTile(
                                    onTap: () async {
                                      todoDone = !todoDone;
                                      var done = await provider
                                          .todoStatusUpdate(
                                            mid:
                                                todoList[index][Dbhelper
                                                    .COLUMN_ID],
                                            misDone: todoDone,
                                          );
                                      if (done) {
                                        todoList = provider.XList.reversed
                                            .toList();
                                      } else {}
                                    },
                                    minTileHeight: 65,
                                    // contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                    tileColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(15),
                                    ),
                                    leading: Icon(
                                      todoList[index][Dbhelper.COLUMN_isDone] ==
                                              1
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: tdBlue,
                                    ),
                                    title:
                                        todoList[index][Dbhelper
                                                .COLUMN_isDone] ==
                                            1
                                        ? Text(
                                            todoList[index][Dbhelper
                                                .COLUMN_TITLE],
                                            style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          )
                                        : Text(
                                            todoList[index][Dbhelper
                                                .COLUMN_TITLE],
                                          ),

                                    trailing: SizedBox(
                                      // color: Colors.amber,
                                      width: width * 0.22,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showModalBottomSheet(
                                                // isScrollControlled: false,
                                                // constraints: BoxConstraints(
                                                //   maxHeight: height * 0.5,
                                                //   minWidth: height * 0.5,
                                                // ),
                                                context: context,
                                                builder: (context) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: MediaQuery.of(context)
                                                          .viewInsets
                                                          .bottom, // moves up with keyboard
                                                    ),
                                                    child: editBottomSheet(
                                                      column_id:
                                                          todoList[index][Dbhelper
                                                              .COLUMN_ID],
                                                      todoText:
                                                          todoList[index][Dbhelper
                                                              .COLUMN_TITLE],
                                                      onTap: () async {
                                                        final title =
                                                            editBottomSheetState
                                                                .textController
                                                                .text;
                                                        final id =
                                                            todoList[index][Dbhelper
                                                                .COLUMN_ID];
                                                        if (title.isNotEmpty) {
                                                          var isDone =
                                                              await provider
                                                                  .updateTodo(
                                                                    mtitle:
                                                                        title,
                                                                    mid: id,
                                                                  );
                                                          if (isDone) {
                                                            debugPrint(
                                                              '${TodoappState().todoList.length}',
                                                            );
                                                            todoList = provider
                                                                .XList
                                                                .reversed
                                                                .toList();
                                                            debugPrint(
                                                              '${TodoappState().todoList.length}',
                                                            );
                                                            Utils()
                                                                .toastmessage(
                                                                  'Updated',
                                                                );
                                                            textController
                                                                .clear();
                                                            Navigator.pop(
                                                              context,
                                                            );
                                                          } else {
                                                            Utils().toastmessage(
                                                              'Something is Wrong',
                                                            );
                                                          }
                                                        } else {
                                                          Utils().toastmessage(
                                                            'Field cannot be empty',
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: tdGrey,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          InkWell(
                                            onTap: () async {
                                              final done = await provider
                                                  .deleteTodo(
                                                    mid:
                                                        todoList[index][Dbhelper
                                                            .COLUMN_ID],
                                                  );
                                              if (done) {
                                                todoList = provider
                                                    .XList
                                                    .reversed
                                                    .toList();
                                                Utils().toastmessage('Deleted');
                                              } else {
                                                Utils().toastmessage(
                                                  'something is wrong',
                                                );
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: tdRed,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text('No Todos Added Yet'));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Expanded(
                    child: Row(
                      children: [
                        Container(
                          // height: height * 0.07,
                          height: 60,
                          width: width * 0.65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 5.0,
                                spreadRadius: 0.2,
                                // offset: Offset(0.1, 0.1),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              hintText: 'Add a new todo item',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(width: 20),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                blurRadius: 5.0,
                                spreadRadius: 0.1,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              // minimumSize: Size(
                              //   height * 0.075,
                              //   width * 0.1,
                              // ),
                              fixedSize: Size(75, 65),
                              backgroundColor: tdBlue,
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(5),
                                side: BorderSide.none,
                              ),
                            ),
                            onPressed: () async {
                              final title = textController.text;
                              if (title.isNotEmpty) {
                                var isDone = await provider.addTodo(
                                  mtitle: textController.text,
                                );
                                if (isDone) {
                                  todoList = provider.XList.reversed.toList();
                                  Utils().toastmessage('Added');
                                  textController.clear();
                                  // setState(() {});
                                } else {
                                  Utils().toastmessage('Something is Wrong');
                                }
                              } else {
                                Utils().toastmessage('Field cannot be empty');
                              }
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
