import 'package:network_sharing/main.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class Paramerter extends StatefulWidget {
  const Paramerter({super.key});

  @override
  State<Paramerter> createState() => _ParamerterState();
}

class _ParamerterState extends State<Paramerter> {
  String addr='204.12.218.221:443';
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Configuration',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Server Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            const SizedBox(width: 200,height: 40,),
            SizedBox(
              width: 250,
              height: 70,
              child: Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      // Validate the input against the regex pattern
                      bool isValid = RegExp(r'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$').hasMatch(value);

                      if (isValid) {
                        Toast.show("server changed", duration: Toast.lengthLong, gravity: Toast.bottom);
                        addr='$value:443';
                        gohome();

                      } else {
                        // Invalid IP address format
                        Toast.show("Invalid IP Address", duration: Toast.lengthLong, gravity: Toast.bottom);
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Enter IP Address',

                    ),
                  )
              ),
            ),
            const SizedBox(width: 200,height: 5,)
          ],
        ),
      ),

    );
  }
  void gohome(){
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyHomePage(title: 'Share your network', Address: addr),
          ));
    });
  }
}



