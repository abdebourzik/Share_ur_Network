import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:network_sharing/configuration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'share network',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home:const getstarted(),
    );
  }
}
class getstarted extends StatefulWidget {
  const getstarted({super.key});

  @override
  State<getstarted> createState() => _getstartedState();
}

class _getstartedState extends State<getstarted> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app_logo.png',
              width: 200,
              height: 200,),
            const SizedBox(width: 200,height: 50,),
            GestureDetector(
              onTap: (){
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: 'Share your network',Address: '204.12.218.221:443'),
                      ));
                });
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Center(
                  child:  Text(
                    'Get started',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
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


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,required this.Address});
  final String title;
  final String Address;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends  State<MyHomePage> {
  late String serviceProvider='svs provider';
  late String publicIP='public ip' ;
  late String position='contry' ;
  late String city ='city';
  late String address;
  Color containerColor=const Color(0xff26273b);
  Color backcontainercolor=const Color(0xff1cbfff);
  String containerText='Connect';
  Color textColor=Colors.white;

  static const hellochanel=MethodChannel("santage");

  methodcaller () {
    hellochanel.invokeMethod("connect",{"address":(address.isEmpty)?'204.12.218.221:443':address});
  }
  @override
  void initState() {
      super.initState();
      _getCurrentPublicIP();
      _getCurrentprovider();
      setcity();
      setcurentcontry();
      setaddress();

  }
  void setaddress(){
    address=widget.Address;
  }
  void _getCurrentprovider() async {
    serviceProvider = await getServiceProvider();
  }
  void _getCurrentPublicIP() async {
    publicIP = await getCurrentPublicIP();
  }
  void setcurentcontry() async{
    position = await getContry();
  }
  void setcity() async{
    city =await getcity();
  }
  void _handleTap() {
    setState(() {
      // Change color and text when tapped
      containerColor = const Color(0xff1cbfff);
      backcontainercolor= Colors.black;
      containerText = 'Connected..!';
      textColor = Colors.black;
    });
  }
  void Confpage() {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Paramerter(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff26273b),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                _handleTap();
                Toast.show("conecting to server: $address", duration: Toast.lengthLong, gravity: Toast.bottom);
                methodcaller();
                },
              child: Container(
                padding: const EdgeInsets.all(11),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: backcontainercolor,
                ),
                height: 200,
                width: 200,
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: containerColor,
                  ),
                  height: 150,
                  width: 150,
                  child:  Center(
                    child: Text(
                      containerText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 25,

                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),

                        child:SvgPicture.asset('assets/images/user.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            //serviceProvider.toString(),
                            providertext(serviceProvider),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            iptext(publicIP),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),

                        child:SvgPicture.asset('assets/images/location.svg',
                          height: 30,
                          width: 30,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            contrytext(position),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            citytext(city),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

      floatingActionButton: FloatingActionButton(
        onPressed: Confpage,
        tooltip: 'Configuration',
        backgroundColor: const Color(0xff1cbfff),
        child: SvgPicture.asset('assets/images/configuration.svg'),
      ),
    );
  }
}

Future<String> getcity() async{
  try {
    var response = await http.get(Uri.parse('http://ip-api.com/json'));

    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = Map<String, dynamic>.from(
          response.body is Map ? response.body : json.decode(response.body));

      // Extract the service provider information
      String contry = data['city']?? 'not available';
      return contry;
    } else {
      // If the request was unsuccessful, return an error message
      return 'Error fetching data: ${response.statusCode}';
    }
  } catch (e) {
    // Handle any exceptions that might occur during the request
    return 'Error: $e';
  }
}

String iptext(String publicIP) {
  return publicIP;
}
String contrytext(String contry) {
  return contry;
}
String citytext(String city) {
  return city;
}
String providertext(String provider) {
  return provider;
}
Future<String> getCurrentPublicIP() async {
  try {
    var response = await http.get(Uri.parse('https://ipinfo.io/json'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data['ip'];
    } else {
      return 'Failed to get public IP';
    }
  } catch (e) {
    return 'Error: $e';
  }
}



Future<String> getServiceProvider() async {
  try {
    var response = await http.get(Uri.parse('https://ipapi.is/json/'));

    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = Map<String, dynamic>.from(
          response.body is Map ? response.body : json.decode(response.body));

      // Extract the service provider information
      String serviceProvider = data['asn']['org']?? 'not available';
      return serviceProvider;
    } else {
      // If the request was unsuccessful, return an error message
      return 'Error fetching data: ${response.statusCode}';
    }
  } catch (e) {
    // Handle any exceptions that might occur during the request
    return 'Error: $e';
  }
}
Future<String> getContry() async {
  try {
    var response = await http.get(Uri.parse('http://ip-api.com/json'));

    if (response.statusCode == 200) {
      // Parse the response JSON
      Map<String, dynamic> data = Map<String, dynamic>.from(
          response.body is Map ? response.body : json.decode(response.body));

      // Extract the service provider information
      String contry = data['country']?? 'not available';
      return contry;
    } else {
      // If the request was unsuccessful, return an error message
      return 'Error fetching data: ${response.statusCode}';
    }
  } catch (e) {
    // Handle any exceptions that might occur during the request
    return 'Error: $e';
  }
}
