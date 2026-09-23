import 'package:flutter/material.dart';

void main() {
  runApp(const TechFestApp());
}

class TechFestApp extends StatelessWidget {
  const TechFestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechFest App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
    );
  }
}

// ---------------------- Registration Screen ----------------------

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();

  // Variables
  String? _selectedDepartment;
  bool _isTech = false;
  bool _isNonTech = false;
  DateTime? _selectedEventDateTime;
  String? _selectedEventName;
  double _fees = 100.0;

  // Dropdown options
  final List<String> _eventNames = [
    'Code War',
    'Robo Race',
    'Tech Quiz',
    'Cultural Night',
    'Gaming Arena',
  ];

  void _submitRegistration() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDepartment == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a department')),
        );
        return;
      }
      if (!_isTech && !_isNonTech) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select Tech or Non-Tech')),
        );
        return;
      }
      if (_selectedEventDateTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select event date & time')),
        );
        return;
      }
      if (_selectedEventName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an event')),
        );
        return;
      }

      // Navigate to home with registration data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(
            participantName: _nameController.text.trim(),
            department: _selectedDepartment!,
            isTech: _isTech,
            isNonTech: _isNonTech,
            eventDateTime: _selectedEventDateTime!,
            eventName: _selectedEventName!,
            fees: _fees,
          ),
        ),
      );
    }
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (pickedTime == null) return;

    setState(() {
      _selectedEventDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechFest Registration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Participant Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Participant Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Enter participant name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Department (Radio)
              const Text('Department', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                children: [
                  RadioListTile<String>(
                    title: const Text('Computer'),
                    value: 'Computer',
                    groupValue: _selectedDepartment,
                    onChanged: (val) => setState(() => _selectedDepartment = val),
                  ),
                  RadioListTile<String>(
                    title: const Text('IT'),
                    value: 'IT',
                    groupValue: _selectedDepartment,
                    onChanged: (val) => setState(() => _selectedDepartment = val),
                  ),
                  RadioListTile<String>(
                    title: const Text('Mechanical'),
                    value: 'Mechanical',
                    groupValue: _selectedDepartment,
                    onChanged: (val) => setState(() => _selectedDepartment = val),
                  ),
                  RadioListTile<String>(
                    title: const Text('Civil'),
                    value: 'Civil',
                    groupValue: _selectedDepartment,
                    onChanged: (val) => setState(() => _selectedDepartment = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Tech / Non-Tech (Checkbox)
              const Text('Category', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Tech'),
                value: _isTech,
                onChanged: (val) => setState(() => _isTech = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Non-Tech'),
                value: _isNonTech,
                onChanged: (val) => setState(() => _isNonTech = val ?? false),
              ),
              const SizedBox(height: 16),

              // Event Date-Time Picker
              const Text('Event Date & Time', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: _pickDateTime,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _selectedEventDateTime == null
                      ? 'Select Date & Time'
                      : _selectedEventDateTime!.toString().substring(0, 16),
                ),
              ),
              const SizedBox(height: 16),

              // Event Name (Dropdown)
              const Text('Event Name', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _selectedEventName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Select Event'),
                items: _eventNames
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedEventName = val),
                validator: (val) {
                  if (val == null) {
                    return 'Select an event';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Fees Slider
              const Text('Fees (₹)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text(
                '₹${_fees.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: _fees,
                min: 50,
                max: 500,
                divisions: 9,
                label: '₹${_fees.toStringAsFixed(0)}',
                onChanged: (val) => setState(() => _fees = val),
              ),
              const SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _submitRegistration,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

// ---------------------- Home Screen with Tabs ----------------------

class HomeScreen extends StatelessWidget {
  final String participantName;
  final String department;
  final bool isTech;
  final bool isNonTech;
  final DateTime eventDateTime;
  final String eventName;
  final double fees;

  const HomeScreen({
    super.key,
    required this.participantName,
    required this.department,
    required this.isTech,
    required this.isNonTech,
    required this.eventDateTime,
    required this.eventName,
    required this.fees,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TechFest'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Events'),
              Tab(text: 'Event 1'),
              Tab(text: 'Event 2'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllEventsTab(),
            EventDetailsTab(
              title: 'Code War',
              description:
                  'Showcase your coding skills in this intense programming battle. Solve algorithmic problems under time pressure and win exciting prizes.',
              images: const [
                'https://picsum.photos/seed/code1/400/250',
                'https://picsum.photos/seed/code2/400/250',
                'https://picsum.photos/seed/code3/400/250',
              ],
            ),
            EventDetailsTab(
              title: 'Robo Race',
              description:
                  'Build and race your own robots in this thrilling competition. Speed, control, and strategy will decide the winner.',
              images: const [
                'https://picsum.photos/seed/robo1/400/250',
                'https://picsum.photos/seed/robo2/400/250',
                'https://picsum.photos/seed/robo3/400/250',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------- Tab 1: All Events (GridView) ----------------------

class AllEventsTab extends StatelessWidget {
  const AllEventsTab({super.key});

  final List<Map<String, String>> _events = const [
    {'name': 'Code War', 'image': 'https://picsum.photos/seed/ev1/300/200'},
    {'name': 'Robo Race', 'image': 'https://picsum.photos/seed/ev2/300/200'},
    {'name': 'Tech Quiz', 'image': 'https://picsum.photos/seed/ev3/300/200'},
    {'name': 'Cultural Night', 'image': 'https://picsum.photos/seed/ev4/300/200'},
    {'name': 'Gaming Arena', 'image': 'https://picsum.photos/seed/ev5/300/200'},
    {'name': 'Hackathon', 'image': 'https://picsum.photos/seed/ev6/300/200'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 events per row
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          final event = _events[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.network(
                    event['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(Icons.image),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    event['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ---------------------- Tab 2 & 3: Event Details ----------------------

class EventDetailsTab extends StatelessWidget {
  final String title;
  final String description;
  final List<String> images;

  const EventDetailsTab({
    super.key,
    required this.title,
    required this.description,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      images[index],
                      width: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: 280,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'About Event',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}