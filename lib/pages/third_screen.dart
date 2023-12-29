import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:suitmedia_test/utils/common.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, this.onUsernameSelected});

  final Function(String)? onUsernameSelected;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  String selectedName = '';

  List<dynamic> _users = [];
  final ScrollController _scrollController = ScrollController();
  int _page = 1;
  final int _perPage = 10;
  bool _isLoading = false;

  Future<void> _fetchUsers({bool refresh = false}) async {
    if (_isLoading) return;

    _isLoading = true;

    if (refresh) {
      _page = 1;
      _users.clear();
    }

    final response = await http.get(Uri.parse(
        'https://reqres.in/api/users?page=$_page&per_page=$_perPage'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedUsers = json.decode(response.body)['data'];
      // print(fetchedUsers);

      if (fetchedUsers.isNotEmpty) {
        setState(() {
          if (refresh) {
            _users = fetchedUsers;
          } else {
            _users.addAll(fetchedUsers);
          }
          _page++;
          _isLoading = false;
        });
      } else {
        _isLoading = false;
      }
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _page = 1;
      _users.clear();
    });
    await _fetchUsers(refresh: true);
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _fetchUsers();
      }
    });
  }

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
          "Third Screen",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: _refreshUsers,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            itemCount: _users.length + 1,
            itemBuilder: (context, index) {
              if (index == _users.length) {
                return Center(
                  child: _isLoading
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : const SizedBox(),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserItem(
                        avatar: _users[index]['avatar'],
                        firstName: _users[index]['first_name'],
                        email: _users[index]['email'],
                        lastName: _users[index]['last_name'],
                        onTap: () {
                          selectedName = _users[index]['first_name'] +
                              ' ' +
                              _users[index]['last_name'];
                          widget.onUsernameSelected!(selectedName);
                          // print(selectedName);
                          Navigator.pop(context);
                        },
                      ),
                      // SizedBox(height: 1.h),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.avatar,
    required this.firstName,
    required this.email,
    required this.lastName,
    this.onTap,
  });

  final String avatar;
  final String firstName;
  final String email;
  final String lastName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: primaryColor, width: 0.1))),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  avatar,
                  width: 49.dp,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    firstName + ' ' + lastName,
                    style: TextStyle(
                        fontSize: 16.dp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                  // SizedBox(width: 2.w),
                  // Text(
                  //   lastName,
                  //   style: TextStyle(
                  //     fontSize: 16.dp,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  Text(
                    email,
                    style: TextStyle(
                        fontSize: 10.dp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
