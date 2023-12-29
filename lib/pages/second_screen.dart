import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:suitmedia_test/pages/third_screen.dart';
import 'package:suitmedia_test/utils/common.dart';
import 'package:suitmedia_test/widgets/custom_button.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({
    super.key,
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String? selectedName = 'John Doe';

  // void updateName(String? ) {
  //   setState(() {
  //     firstName = oneName;
  //     lastName = twoName;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shape: Border(
              bottom: BorderSide(
            color: primaryColor,
            width: 0.1,
          )),
          leading: CupertinoNavigationBarBackButton(
            color: primaryColor,
          ),
          title: const Text(
            "Second Screen",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 2.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    selectedName ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.dp,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  // Text(
                  //   lastName ?? '',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 18.dp,
                  //   ),
                  // ),
                ],
              ),
              Center(
                child: Text(
                  "Selected User Name",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.dp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CustomButton(
                text: "Choose a User",
                textStyle: const TextStyle(color: Colors.white),
                backgroundColor: primaryColor,
                borderRadius: 12,
                width: MediaQuery.of(context).size.width,
                height: 5.h,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThirdScreen(
                        onUsernameSelected: (String username) {
                          setState(() {
                            selectedName = username;
                          });
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
