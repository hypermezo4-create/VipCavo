import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:flutter/material.dart';

class AppPickerScreen extends StatefulWidget {
  const AppPickerScreen({
    required this.apps,
    required this.initialSelection,
    super.key,
  });

  final List<MountSelectableApp> apps;
  final List<String> initialSelection;

  @override
  State<AppPickerScreen> createState() => _AppPickerScreenState();
}

class _AppPickerScreenState extends State<AppPickerScreen> {
  final TextEditingController _controller = TextEditingController();
  late Set<String> selected;
  String query = '';

  @override
  void initState() {
    super.initState();
    selected = widget.initialSelection.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.apps.where((a) {
      final q = query.toLowerCase();
      return a.name.toLowerCase().contains(q) || a.packageName.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Choose apps')),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _controller,
                onChanged: (v) => setState(() => query = v),
                decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search apps'),
              ),
            ),
            Row(
              children: <Widget>[
                TextButton(onPressed: () => setState(() => selected = widget.apps.map((e) => e.packageName).toSet()), child: const Text('Select All')),
                TextButton(onPressed: () => setState(() => selected.clear()), child: const Text('Deselect All')),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final app = filtered[index];
                  final checked = selected.contains(app.packageName);
                  return CheckboxListTile(
                    value: checked,
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          selected.add(app.packageName);
                        } else {
                          selected.remove(app.packageName);
                        }
                      });
                    },
                    secondary: CircleAvatar(child: Text(app.name.characters.first.toUpperCase())),
                    title: Text(app.name),
                    subtitle: Text(app.packageName),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: FilledButton(
                onPressed: () => Navigator.of(context).pop(selected.toList()),
                child: const Text('Save selection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
