import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:suitmedia_test/pages/second_screen.dart';
import 'package:suitmedia_test/utils/common.dart';
import 'package:suitmedia_test/widgets/custom_button.dart';
import 'package:suitmedia_test/widgets/custom_textfield.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void checkPalindrome(String text) {
    String originalText =
        text.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    String reversedText = originalText.split('').reversed.join('');

    if (originalText == reversedText) {
      palindromeTC.text = 'isPalindrome';
    } else {
      palindromeTC.text = 'notPalindrome';
    }
  }

  TextEditingController nameTC = TextEditingController();
  TextEditingController palindromeTC = TextEditingController();

  @override
  void dispose() {
    nameTC.dispose();
    palindromeTC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background1.png'),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 5.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/ic_photo.png',
                  height: 116.dp,
                ),
              ),
              SizedBox(height: 5.h),
              CustomTextField(
                controller: nameTC,
                hint: 'Name',
                borderRadius: 12,
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: palindromeTC,
                hint: 'Polindrome',
                borderRadius: 12,
                onChanged: (value) {
                  checkPalindrome(value);
                },
              ),
              SizedBox(height: 4.h),
              CustomButton(
                borderRadius: 12,
                backgroundColor: primaryColor,
                onPressed: () {
                  checkPalindrome(nameTC.text);
                },
                text: "CHECK",
                textStyle: const TextStyle(color: Colors.white),
              ),
              CustomButton(
                borderRadius: 12,
                backgroundColor: primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondScreen(),
                      ));
                },
                text: "NEXT",
                textStyle: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
