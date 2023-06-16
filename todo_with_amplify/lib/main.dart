import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_with_amplify/views/app_navigator.dart';
import 'data/repositories/auth_repository.dart';
import 'logic/cubit/auth/auth_cubit.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'data/models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
import 'views/pages/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  final AuthRepository _authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: _authRepository,
      )..attemptAutoSignIn(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo Amplify',
        theme: ThemeData.dark(),
        home: _amplifyConfigured ? AppNavigator() : const LoadingPage(),
      ),
    );
  }

  void _configureAmplify() async {
    try {
      await Future.wait([
        Amplify.addPlugin(
            AmplifyDataStore(modelProvider: ModelProvider.instance)),
        Amplify.addPlugin(AmplifyAPI()),
        Amplify.addPlugin(AmplifyAuthCognito()),
      ]);

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);

      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
