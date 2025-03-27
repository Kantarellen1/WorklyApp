import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Velkommen til Veldo'), // Title displayed only once
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1), // Border around the menu
              borderRadius: BorderRadius.circular(8),
            ),
            child: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                } else if (value == 'logout') {
                  Navigator.popUntil(context, (route) => route.isFirst); // Logout and go back to login
                } else if (value == 'create_job') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateJobPage()),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Text('Profile'),
                  ),
                  const PopupMenuItem(
                    value: 'create_job',
                    child: Text('Create Job'),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: const JobList(), // Job list
    );
  }
}

class JobList extends StatelessWidget {
  const JobList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of jobs with descriptions and pay details
    final List<Map<String, dynamic>> jobs = [
      {
        'title': 'Fix plumbing',
        'description': 'Fix the leaking pipes in the kitchen.',
        'totalPay': 500, // Total payment in DKK
        'hourlyPay': 145, // Hourly pay in DKK
      },
      {
        'title': 'Paint walls',
        'description': 'Paint the living room walls with white paint.',
        'totalPay': 1200,
        'hourlyPay': 145,
      },
      {
        'title': 'Clean windows',
        'description': 'Clean all the windows in the house.',
        'totalPay': 800,
        'hourlyPay': 145,
      },
    ];

    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Sharp corners
            ),
            elevation: 4, // Shadow effect
            child: ExpansionTile(
              title: Text(job['title']),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${job['description']}'),
                      const SizedBox(height: 10),
                      Text('Total Pay: ${job['totalPay']} DKK'),
                      const SizedBox(height: 10),
                      Text('Hourly Pay: ${job['hourlyPay']} DKK/hour'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Accept job logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('You accepted ${job['title']}')),
                          );
                        },
                        child: const Text('Accept Job'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: const Center(
        child: Text(
          'User Profile Page',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CreateJobPage extends StatelessWidget {
  const CreateJobPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController jobTitleController = TextEditingController();
    final TextEditingController jobDescriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Job'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: jobTitleController,
                decoration: const InputDecoration(labelText: 'Job Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: jobDescriptionController,
                decoration: const InputDecoration(labelText: 'Job Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logic to create a job
                  final jobTitle = jobTitleController.text;
                  final jobDescription = jobDescriptionController.text;

                  if (jobTitle.isNotEmpty && jobDescription.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Job "$jobTitle" created successfully!')),
                    );
                    Navigator.pop(context); // Go back to the main page
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields')),
                    );
                  }
                },
                child: const Text('Create Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}