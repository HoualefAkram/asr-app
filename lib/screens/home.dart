import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

late TextEditingController number1Controller;
late TextEditingController number2Controller;

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    number1Controller = TextEditingController();
    number2Controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    number1Controller.dispose();
    number2Controller.dispose();
    super.dispose();
  }

  bool isLoading = false;
  double response = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: number1Controller,
                decoration: InputDecoration(
                  labelText: 'Number 1',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: number2Controller,
                decoration: InputDecoration(
                  labelText: 'Number 2',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        final double a = double.parse(number1Controller.text);
                        final double b = double.parse(number2Controller.text);

                        final double result = await add(a, b);
                        setState(() {
                          response = result;
                          isLoading = false;
                        });
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                          log(e.toString());
                          setState(() {
                            isLoading = false;
                            response = 0.0;
                          });
                        }
                      }
                    },
                    child: const Text('Add'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        final double a = double.parse(number1Controller.text);
                        final double b = double.parse(number2Controller.text);

                        final double result = await sub(a, b);
                        setState(() {
                          response = result;
                          isLoading = false;
                        });
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                          log(e.toString());
                          setState(() {
                            isLoading = false;
                            response = 0.0;
                          });
                        }
                      }
                    },
                    child: const Text('Sub'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        final double a = double.parse(number1Controller.text);
                        final double b = double.parse(number2Controller.text);

                        final double result = await mul(a, b);
                        setState(() {
                          response = result;
                          isLoading = false;
                        });
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                          log(e.toString());
                          setState(() {
                            isLoading = false;
                            response = 0.0;
                          });
                        }
                      }
                    },
                    child: const Text('mul'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          isLoading = true;
                        });
                        final double a = double.parse(number1Controller.text);
                        final double b = double.parse(number2Controller.text);

                        final double result = await div(a, b);
                        setState(() {
                          response = result;
                          isLoading = false;
                        });
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $e'),
                            ),
                          );
                          log(e.toString());
                          setState(() {
                            isLoading = false;
                            response = 0.0;
                          });
                        }
                      }
                    },
                    child: const Text('div'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (isLoading)
                const CircularProgressIndicator()
              else
                Text('Result: $response'),
            ],
          ),
        ),
      ),
    );
  }
}

Future<double> add(double a, double b) async {
  const String url = "https://fastapi-refresh.onrender.com/math/add";
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(<String, double>{
      'a': a,
      'b': b,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return double.parse(jsonDecode(response.body)['result'].toString());
  } else {
    throw Exception(
        'Failed to add numbers, status code: ${response.statusCode}, response: ${response.body}');
  }
}

Future<double> sub(double a, double b) async {
  const String url = "https://fastapi-refresh.onrender.com/math/sub";
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(<String, double>{
      'a': a,
      'b': b,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return double.parse(jsonDecode(response.body)['result'].toString());
  } else {
    throw Exception(
        'Failed to subtract numbers, status code: ${response.statusCode}, response: ${response.body}');
  }
}

Future<double> mul(double a, double b) async {
  const String url = "https://fastapi-refresh.onrender.com/math/mul";
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(<String, double>{
      'a': a,
      'b': b,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return double.parse(jsonDecode(response.body)['result'].toString());
  } else {
    throw Exception(
        'Failed to multiply numbers, status code: ${response.statusCode}, response: ${response.body}');
  }
}

Future<double> div(double a, double b) async {
  const String url = "https://fastapi-refresh.onrender.com/math/div";
  final response = await http.post(
    Uri.parse(url),
    body: jsonEncode(<String, double>{
      'a': a,
      'b': b,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    return double.parse(jsonDecode(response.body)['result'].toString());
  } else {
    throw Exception(
        'Failed to divide numbers, status code: ${response.statusCode}, response: ${response.body}');
  }
}
