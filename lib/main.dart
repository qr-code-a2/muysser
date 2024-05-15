import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_page/firebase_options.dart';
import 'dart:html';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pilgrim information',
      home: MyHomePage(title: 'Pilgrim information'),
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
  TextEditingController fullNameController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController NationalityController = TextEditingController();
  TextEditingController nationalID = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController Age = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController Height = TextEditingController();
  TextEditingController blood = TextEditingController();
  TextEditingController chronicdiseases = TextEditingController();
  TextEditingController Allergens = TextEditingController();
  TextEditingController emergencyPhone = TextEditingController();
  TextEditingController CampaignName = TextEditingController();
  TextEditingController regiment = TextEditingController();

  List chronic = [];
  List immune = [];

  QueryDocumentSnapshot? data;
  QueryDocumentSnapshot<Map>? supervisor;
  bool loading = false;
  int age = 0;
  String? date;

  @override
  void initState() {
    getId();
    super.initState();
  }

  Future getId() async {
    var uri = Uri.parse(window.location.href);
    var id = uri.pathSegments.last;

    if (id != null) {
      getPilgrim(id.toString());
    } else {
      print('Error: No ID parameter found in URL.');
    }
  }

  getPilgrim(String id) async {
    loading = true;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pilgrims')
        .where('hajLicense', isEqualTo: id)
        .get();
    data = snapshot.docs[0];
    await getSupervisor(data!['regiment']);
    var difference =
        DateTime.now().difference(DateFormat('yyyy-MM-dd').parse(data!['dob']));
    age = difference.inDays ~/ 365;

    DateFormat('yyyy-MM-dd').parse(data!['dob']);
    date = DateFormat('dd-MM-yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(data!['dob']))
        .toString();
    for (var item in data!['chronicDisease']) {
      chronic.add(item['label']);
    }
    for (var item in data!['immuneDisease']) {
      immune.add(item['label']);
    }
    setState(() {
      loading = false;
    });
  }

  Future getSupervisor(String regiment) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('regiment', isEqualTo: regiment)
        .get();
    supervisor = snapshot.docs[0] as QueryDocumentSnapshot<Map>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(86, 77, 78, 1),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                      height: 130,
                      child: Image(
                        image: AssetImage('images/logo.jpg'),
                        // height: 450,
                        //  width: 1000,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        color: const Color.fromARGB(187, 255, 254, 254),
                        width: 1100,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const CircleAvatar(
                              backgroundColor: Color.fromRGBO(86, 77, 78, 1),
                              radius: 50,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 300),
                              child: TextField(
                                controller: fullNameController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: licenseController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['hajLicense']} :     تصريح الحج     ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: NationalityController,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['nationality']} :     الجنسية    ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: nationalID,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['id']} :     الهوية الوطنية/الإقامة    ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: dob,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${date} :      تاريخ الميلاد    ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: Age,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "$age years :      العمر   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: weight,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['weight']} :      الوزن   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: gender,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['gender']} :      الجنس   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: Height,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['height']} :      الطول   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: blood,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['blood'][0]['label']} :      فصيلة الدم   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: chronicdiseases,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: chronic.length * 120,
                                      child: ListView.builder(
                                        itemCount: chronic.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => Text(
                                          chronic[index] + ', ',
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      ":      الأمراض المزمنة   ",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: Allergens,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: immune.length * 120,
                                      child: ListView.builder(
                                        itemCount: immune.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) => Text(
                                          immune[index] + ', ',
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      ":       مسببات الحساسية   ",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 0, 0, 0),
                                  child: TextField(
                                    controller: emergencyPhone,
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "${data!['countryCode']}${data!['phoneNumber']} :       رقم هاتف الطوارئ   ",
                                  style: const TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 250, 249, 249),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: TextField(
                                controller: CampaignName,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      width: 1100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 249, 249),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: regiment,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            "${data!['regiment']} :  رقم الفوج",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 500,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 249, 249),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 14, 1, 0)),
                        ),
                        onPressed: () async {
                          if (supervisor!.data().containsKey('location')) {
                            final Uri uri = Uri.parse(supervisor!['location']);
                            await launchUrl(uri);
                          }
                        },
                        child: const Text(
                          'عرض موقع مشرف الحملة',
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 250, 249, 249),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 14, 1, 0)),
                        ),
                        onPressed: () async {
                          final Uri uri = Uri.parse(
                              "whatsapp://send?phone${supervisor!['countryCode']}${supervisor!['phoneNumber']}");
                          await launchUrl(uri);
                        },
                        child: const Text(
                          'التواصل مع مشرف الحملة',
                          style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )));
  }
}
