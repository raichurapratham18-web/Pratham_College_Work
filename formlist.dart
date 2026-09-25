import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FormList extends StatefulWidget {
  const FormList({super.key});

  @override
  State<FormList> createState() => _FormListState();
}

class _FormListState extends State<FormList> {
  final nameCtrl = TextEditingController();
  String gender = 'M';
  bool agree = false;
  List<Map<String, dynamic>> items = <Map<String, dynamic>>[];
  bool isLoading = true;
  bool isSaving = false;
  static const _key = 'entries';

  Future<void> _load() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final raw = pref.getString(_key);
      if (raw == null || raw.isEmpty) return;

      final decoded = jsonDecode(raw);
      if (decoded is! List) return;

      final loadedItems = decoded
          .whereType<Map>()
          .map(
            (item) => <String, dynamic>{
              'name': item['name']?.toString() ?? '',
              'gender': item['gender']?.toString() ?? 'M',
              'agree': item['agree'] == true,
            },
          )
          .where((item) => item['name'].toString().isNotEmpty)
          .toList();

      if (!mounted) return;
      setState(() => items = loadedItems);
    } catch (_) {
      if (!mounted) return;
      _showMessage('Could not load saved entries.');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = nameCtrl.text.trim();
    if (name.isEmpty) {
      _showMessage('Please enter a name.');
      return;
    }
    if (!agree) {
      _showMessage('Please agree before saving.');
      return;
    }

    final entry = <String, dynamic>{
      'name': name,
      'gender': gender,
      'agree': agree,
    };

    setState(() => isSaving = true);
    try {
      final updatedItems = [...items, entry];
      final pref = await SharedPreferences.getInstance();
      await pref.setString(_key, jsonEncode(updatedItems));

      if (!mounted) return;
      setState(() {
        items = updatedItems;
        nameCtrl.clear();
        gender = 'M';
        agree = false;
      });
      _showMessage('Entry saved.');
    } catch (_) {
      if (mounted) _showMessage('Could not save the entry.');
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Entries')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            RadioGroup<String>(
              groupValue: gender,
              onChanged: (value) {
                if (value != null) setState(() => gender = value);
              },
              child: const Column(
                children: [
                  RadioListTile<String>(title: Text('Male'), value: 'M'),
                  RadioListTile<String>(title: Text('Female'), value: 'F'),
                ],
              ),
            ),
            CheckboxListTile(
              title: const Text('I agree'),
              value: agree,
              onChanged: (value) => setState(() => agree = value ?? false),
            ),
            ElevatedButton(
              onPressed: isSaving ? null : _save,
              child: isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : items.isEmpty
                  ? const Center(child: Text('No saved entries yet.'))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item['name'].toString()),
                          subtitle: Text(
                            'Gender: ${item['gender']} | Agree: ${item['agree']}',
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
