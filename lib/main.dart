import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

bool hasInternet=false;
ConnectivityResult result = ConnectivityResult.none;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        title: "CheckInternet",
        home: Scaffold(
          appBar: AppBar(
            title: Text('Check Connectivity'),
            centerTitle: true,
          ),
          body: Center(
            child: ElevatedButton(
                onPressed: () async{
                  hasInternet=await InternetConnectionChecker().hasConnection;

                  result=await Connectivity().checkConnectivity();
                  final text= hasInternet?'Internet :':'No Internet :';
                  final Color = hasInternet?Colors.green:Colors.red;

                  if (result== ConnectivityResult.mobile) {
                    showSimpleNotification(
                    Text("${text} Mobile Network",style: TextStyle(color: Colors.white),),
                    background: Color
                  );
                  }else if (result== ConnectivityResult.wifi) {
                    showSimpleNotification(
                    Text("${text} Wifi Netwwork",style: TextStyle(color: Colors.white),),
                    background: Color
                  );
                  }else{
                    showSimpleNotification(
                    Text("${text} No Network",style: TextStyle(color: Colors.white),),
                    background: Color
                  );
                  }

                  // showSimpleNotification(
                  //   Text(text,style: TextStyle(color: Colors.white),),
                  //   background: Color
                  // );
                },
                child: Text("Check Network"),
                style: ElevatedButton.styleFrom(primary: Colors.amber)),
          ),
        ),
      ),
    );
  }
}
