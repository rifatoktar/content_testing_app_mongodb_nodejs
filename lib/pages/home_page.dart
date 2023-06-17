import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sloshy/pages/intro_page.dart';
import 'package:sloshy/services/config.dart';

import '../theme/theme.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const HomePage({super.key, this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _content = TextEditingController();
  late String userId;
  List? items;
  bool _switchValue = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    getContentList(userId);
  }

  void addUserContent() async {
    if (_content.text.isNotEmpty) {
      var regBody = {'userId': userId, 'text': _content.text};

      var response = await http.post(Uri.parse(addContent),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(regBody));

      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['status']);

      if (jsonResponse['status']) {
        _content.clear();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        getContentList(userId);
      } else {
        print('Something went wrong while your creating your content');
      }
    }
  }

  void getContentList(userId) async {
    var regBody = {'userId': userId};

    var response = await http.post(Uri.parse(getContent),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(regBody));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      items = jsonResponse['status'];
    } else {
      print('Something went wrong while getting contents');
      print(response.statusCode);
    }
  }

  void deleteItem(id) async {
    var regBody = {'id': id};

    var response = await http.post(Uri.parse(deleteContent),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(regBody));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getContentList(userId);
    }
  }

  void toggleImportant2(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  _addANewContent() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: secondaryColor),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Add a new content',
                      style: CustomTheme.head,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor),
                    child: TextField(
                      controller: _content,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'your content details...',
                        hintStyle: CustomTheme.hintText,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                        onPressed: () {
                          addUserContent();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0,
                          backgroundColor: primaryColor,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Add a content',
                          style: CustomTheme.textButton,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        );
      },
    );
  }

  _settings() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: secondaryColor),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Settings',
                      style: CustomTheme.head,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  ListTile(
                    onTap: () {},
                    leading: SvgPicture.asset(
                      "assets/icons/moon.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    title: Text(
                      'Dark mode',
                      style: CustomTheme.subHead,
                    ),
                    horizontalTitleGap: 2.0,
                    trailing: CupertinoSwitch(
                      value: _switchValue,
                      onChanged: (value) {
                        toggleImportant2(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IntroPage()),
                        );
                      },
                      leading: SvgPicture.asset(
                        "assets/icons/exit.svg",
                        colorFilter:
                            const ColorFilter.mode(thirdColor, BlendMode.srcIn),
                      ),
                      title: Text(
                        'Log out',
                        style: CustomTheme.logoutText,
                      ),
                      horizontalTitleGap: 2.0,
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: thirdColor,
                      )),
                ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text('Sloshy', style: CustomTheme.subHead),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _addANewContent();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: SvgPicture.asset(
                  'assets/icons/add.svg',
                  colorFilter:
                      const ColorFilter.mode(textColor, BlendMode.srcIn),
                )),
            IconButton(
                onPressed: () {
                  _settings();
                },
                icon: SvgPicture.asset(
                  'assets/icons/settings.svg',
                  colorFilter:
                      const ColorFilter.mode(textColor, BlendMode.srcIn),
                )),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: primaryColor),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: items == null
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                  : ListView.builder(
                      itemCount: items!.length,
                      itemBuilder: (context, int index) {
                        return Expanded(
                          child: Container(
                              height: 120,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${items![index]['name']}',
                                          style: CustomTheme.contentText,
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              //BuildContext context
                                              print('${items![index]['_id']}');
                                              deleteItem(
                                                  '${items![index]['_id']}');
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 70,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: secondaryColor),
                                    child: Center(
                                        child: Text(
                                      '${items![index]['text']}',
                                      style: CustomTheme.contentText,
                                    )),
                                  )
                                ],
                              )),
                        );
                      })),
        ));
  }
}
