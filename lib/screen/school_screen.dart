import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../model/school_model.dart';

class SchoolScreen extends StatefulWidget {
  final ApiService apiService;
  final String token;

  SchoolScreen({required this.apiService, required this.token});

  @override
  _SchoolScreenState createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  late Future<schoolModel> _schoolData;

  @override
  void initState() {
    super.initState();
    _schoolData = widget.apiService.fetchSchool(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'School Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<schoolModel>(
        future: _schoolData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final school = snapshot.data!.data;

            if (school == null) {
              return Center(child: Text('No data available'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // Added scroll view to handle overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (school.schoolLogo != null &&
                        school.schoolLogo!.isNotEmpty)
                      Image.network(
                        school.schoolLogo!,
                        errorBuilder: (context, error, stackTrace) {
                          return Text('Failed to load image');
                        },
                      ),
                    SizedBox(height: 20),
                    Text('Title: ${school.title ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('Email: ${school.email ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('Phone: ${school.phone ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('Address: ${school.address ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('School Info: ${school.schoolInfo ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Text('Session: ${school.session ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    if (school.createdAt != null &&
                        school.createdAt!.isNotEmpty)
                      Text('Created At: ${school.createdAt}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
