import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _ekleController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _cikarController = TextEditingController();

  TextEditingController _guncellenecekController = TextEditingController();
  TextEditingController _yeniIsimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Veri İşlemleri'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _ekleController,
            decoration: InputDecoration(labelText: 'Eklenecek İsim'),
          ),
          TextField(
            controller: _surnameController,
            decoration: InputDecoration(
                labelText: 'Eklenecek Soyisim'), // Add this field
          ),
          ElevatedButton(
            onPressed: () =>
                _addToFirestore(_ekleController.text, _surnameController.text),
            child: Text('Ekle'),
          ),
          TextField(
            controller: _cikarController,
            decoration: InputDecoration(labelText: 'Çıkarılacak İsim'),
          ),
          ElevatedButton(
            onPressed: () => _deleteFromFirestore(_cikarController.text),
            child: Text('Çıkar'),
          ),
          TextField(
            controller: _guncellenecekController,
            decoration: InputDecoration(labelText: 'Güncellenecek İsim'),
          ),
          TextField(
            controller: _yeniIsimController,
            decoration: InputDecoration(labelText: 'Yeni İsim'),
          ),
          ElevatedButton(
            onPressed: () => _updateFirestore(
                _guncellenecekController.text, _yeniIsimController.text),
            child: Text('Güncelle'),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('koleksiyon')
                .orderBy('isim')
                .snapshots(), //where muhabbeti buraya geliyor
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Hata oluştu: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: Text('Veri bulunamadı'),
                );
              }

              var documents = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var documentData =
                        documents[index].data() as Map<String, dynamic>;
                    var isim = documentData['isim'];
                    var soyisim = documentData['soyisim'];

                    return Column(
                      children: [
                        ListTile(
                          title: Text('Firebase Verisi: $isim $soyisim'),
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _addToFirestore(String name, String surname) async {
    try {
      await _firestore.collection('koleksiyon').add({
        'isim': name,
        'soyisim': surname, // Add the surname field
        // Add other fields as needed
      });
      // Clear the text fields after adding to Firestore
      _ekleController.clear();
      _surnameController.clear();
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _deleteFromFirestore(String isim) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('koleksiyon').get();

      querySnapshot.docs.forEach((doc) {
        var documentData = doc.data() as Map<String, dynamic>;
        var belgeIsmi = documentData['isim'];

        // Büyük küçük harf duyarlılığını dikkate almadan karşılaştırma yapma
        if (belgeIsmi.toString().toLowerCase() == isim.toLowerCase()) {
          doc.reference.delete();
        }
      });

      // Clear the text field after deleting from Firestore
      _cikarController.clear();
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  void _updateFirestore(String oldName, String newName) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('koleksiyon').get();

      querySnapshot.docs.forEach((doc) {
        var documentData = doc.data() as Map<String, dynamic>;
        var belgeIsmi = documentData['isim'];

        if (belgeIsmi.toString().toLowerCase() == oldName.toLowerCase()) {
          doc.reference.update({'isim': newName});
        }
      });

      // Clear the text fields after updating in Firestore
      _guncellenecekController.clear();
      _yeniIsimController.clear();
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
