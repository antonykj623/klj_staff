import 'package:flutter/material.dart';
import 'package:kljcafe_employee/blocs/login/login_bloc.dart';
import 'package:kljcafe_employee/widgets/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
void main() {

  runApp(
    MultiBlocProvider(
      providers: [

        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KLJ Cafe Staff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'KLJ Cafe Staff'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    redirectToNextPage();
  }






  redirectToNextPage()
  {
Future.delayed(Duration(seconds: 3),() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );


},);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/kljcafe.jpeg",width: 150,height: 150,),
            SizedBox(height: 20,),
            Text(
              'KLJ Cafe Staff',
              style: Theme.of(context).textTheme.headlineMedium,
            ),


          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
