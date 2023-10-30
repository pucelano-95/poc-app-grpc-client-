import 'package:flutter/material.dart';
import 'package:flutter_grpc_poc/dependency_injection.dart';
import 'package:flutter_grpc_poc/presentation/user/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection di = DependencyInjection();
  InjectionContainer container = di.inject();
  runApp(Application(container));
}

class Application extends StatelessWidget {
  const Application(this.container, {super.key});

  final InjectionContainer container;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gRPC PoC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(title: 'gRPC PoC', container: container),
    );
  }
}
