import 'package:flutter/material.dart';
import 'package:todo_app/utils/Utils.dart';
import 'package:todo_app/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    String myName = 'Mirza Sameer Asghar';
    nameController.text = myName;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Editprofile()),
                // );
                Utils().toastmessage('Buy Premuim to open this Feature');
              },
              child: Text('Edit'),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromARGB(255, 95, 82, 238),
              Color.fromARGB(255, 119, 108, 247),
              Color.fromARGB(255, 149, 153, 249),
            ],
          ),
        ),
        // color: tdBlue,
        height: height * 1,
        width: width * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.asset('assets/profile_avatar.jpeg'),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 107,
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Editprofile()),
                      // );
                      Utils().toastmessage('Buy Premuim to open this Feature');
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Card(
              child: Container(
                height: height * 0.55,
                width: width * 0.83,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 8,
                  ),
                  child: Container(
                    // color: Colors.amber,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            children: [
                              Icon(Icons.person, color: tdGrey, size: 20),
                              SizedBox(width: 15),
                              Text(
                                myName,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 2),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              Icon(Icons.email, color: tdGrey, size: 20),
                              SizedBox(width: 15),
                              Text(
                                'sameerasghar018@gmail.com',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 2),
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              Icon(Icons.phone, color: tdGrey, size: 20),
                              SizedBox(width: 15),
                              Text(
                                '03244258476',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About:',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Hi! I am Flutter Learner, i am very optimistic and harkworker following with smarkwork, right now focusing on my flutter development skills and learning or growing continously. Thanks!',
                              style: TextStyle(fontSize: 15, color: tdGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
