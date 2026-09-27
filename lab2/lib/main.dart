import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Business Card',
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
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const BusinessCardScreen(),
    );
  }
}

class BusinessCardScreen extends StatelessWidget {
  const BusinessCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh thiếp cá nhân'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ảnh đại diện lấy từ thư mục images/
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/avt.jpg'),
                  ),
                  const SizedBox(height: 16),

                  // Tên
                  const Text(
                    'Nguyễn Trọng Minh Huy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Nghề nghiệp
                  Text(
                    'Sinh viên Công nghệ thông tin',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const Divider(height: 32),

                  // Thông tin liên lạc dùng ListTile + Cupertino icons
                  const ListTile(
                    leading: Icon(CupertinoIcons.phone, color: Colors.indigo),
                    title: Text('037 792 0935'),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.mail, color: Colors.indigo),
                    title: Text('huyntm.23it@vku.udn.vn'),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.location_solid,
                        color: Colors.indigo),
                    title: Text('Đà Nẵng, Việt Nam'),
                  ),
                  const ListTile(
                    leading:
                        Icon(CupertinoIcons.globe, color: Colors.indigo),
                    title: Text('www.huyhuyhihi.dev'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}