import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quantumit/model/api_module.dart';
import 'package:quantumit/model/mymodel.dart';
import 'package:quantumit/utils/sharedpreference_helper.dart';
import 'package:quantumit/view/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  var url =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=8f3655e3c396458caa5a41f6460af83b";

  var _dio = Dio();

  late ApiModule _apiModule;

  List<MyModel>? value = [];

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("hellow");
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Search in Feed",
                style: TextStyle(color: Colors.blueAccent),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  SharedPreferencesHelper.sharedPreferenceClear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                },
                child: Text(
                  "SignOut",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        body: value == null || value!.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                    itemCount: value?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 1,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(value![index]
                                      .publishedAt!
                                      .hour
                                      .toString()),
                                  const Text(" hours ago by "),
                                  Text(
                                    value![index].author ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            value![index].title ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(value![index].description ?? '')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 5, top: 4, bottom: 4),
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      value![index].urlToImage ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ));
  }

  Future<dynamic>? getUserData() async {
    try {
      Response response = await _dio.get(url);
      var dataResponse = ApiModule.fromJson(response.data,
          (data) => MyModel.fromJson(data as Map<String, dynamic>));
      if (dataResponse.articles != null) {
        value = dataResponse.articles;
        print("hi");
        setState(() {});
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
