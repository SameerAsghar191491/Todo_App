import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

class editBottomSheet extends StatefulWidget {
  final int column_id;
  final String todoText;
  final VoidCallback onTap;
  const editBottomSheet({
    super.key,
    required this.column_id,
    required this.todoText,
    required this.onTap,
  });

  @override
  State<editBottomSheet> createState() => editBottomSheetState();
}

class editBottomSheetState extends State<editBottomSheet> {
  static TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = widget.todoText;
    debugPrint(textController.text);
    // final provider = Provider.of<pHelper>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: height * 0.3,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Edit Your Todo',
                  style: TextStyle(fontSize: 25, color: Colors.grey.shade700),
                ),
                // SizedBox(height: 10),
                Container(
                  // height: height * 0.07,
                  // width: width * 0.9,
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
                    decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: InkWell(
                        onTap: () {
                          textController.clear();
                        },
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          // minimumSize: Size(width * 0.1, height * 0.075),
                          minimumSize: Size(width, height * 0.06),
                          backgroundColor: tdBlue,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(5),
                            side: BorderSide.none,
                          ),
                        ),
                        // onTap
                        onPressed: widget.onTap,
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          // minimumSize: Size(width * 0.1, height * 0.075),
                          // minimumSize: Size(width * 0.1, height * 0.075),
                          minimumSize: Size(width, height * 0.06),
                          backgroundColor: tdRed,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(5),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
