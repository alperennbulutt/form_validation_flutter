import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

// veri tabanında kullanıcının olup olmadığını kontrol eden fonksiyon
  bool handleUser() {
    if (emailTextEditingController.text == "qnbfinansbank" &&
        passwordTextEditingController.text == "123456") {
      return true;
    } else {
      return false;
    }
  }

  clearTextValues() {
    emailTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // email alanı
          TextFormField(
            controller: emailTextEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
          ),

          // password alanı
          TextFormField(
            controller: passwordTextEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan boş bırakılamaz';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && handleUser()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Giriş başarılı.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Kullanıcı adı veya şifre yanlış!!')),
                  );
                }
              },
              child: const Text('Kaydet'),
            ),
          ),

          ElevatedButton(
              onPressed: () {
                // setstate kullanmadan form elemanları yardımı ile ekranda dinamik olarak verilerin silindiğini gördük
                // textformfield controller elemanlarını temizler
                clearTextValues();
              },
              child: const Text('Sil'))
        ],
      ),
    );
  }
}
