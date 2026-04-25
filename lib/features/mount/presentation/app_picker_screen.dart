import 'package:deadzon/features/mount/domain/mount_monet_app.dart';
import 'package:flutter/material.dart';

class AppPickerScreen extends StatefulWidget {
  const AppPickerScreen({required this.apps, required this.initialSelection, super.key});

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.apps.where((a) {
      final q = query.toLowerCase();
      return a.name.toLowerCase().contains(q) || a.packageName.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B161E),
      appBar: AppBar(
        title: const Text('Target apps'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      onChanged: (v) => setState(() => query = v),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search_rounded),
                        hintText: 'Search apps',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(child: OutlinedButton.icon(onPressed: _selectAll, icon: const Icon(Icons.check_box_rounded), label: const Text('Select All'))),
                        const SizedBox(width: 8),
                        Expanded(child: OutlinedButton.icon(onPressed: _clearAll, icon: const Icon(Icons.check_box_outline_blank_rounded), label: const Text('Deselect All'))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => Divider(height: 1, color: Colors.white.withValues(alpha: 0.1)),
                  itemBuilder: (context, index) {
                    final app = filtered[index];
                    final checked = selected.contains(app.packageName);
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        child: Text(app.name.characters.first.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      ),
                      title: Text(app.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      subtitle: Text(app.packageName, style: TextStyle(color: Colors.white.withValues(alpha: 0.62), fontSize: 12)),
                      trailing: Checkbox(
                        value: checked,
                        onChanged: app.installed
                            ? (v) {
                                setState(() {
                                  if (v == true) {
                                    selected.add(app.packageName);
                                  } else {
                                    selected.remove(app.packageName);
                                  }
                                });
                              }
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(selected.toList()),
                  child: const Text('Save & apply'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAll() {
    setState(() {
      selected = widget.apps.where((app) => app.installed).map((e) => e.packageName).toSet();
    });
  }

  void _clearAll() {
    setState(() {
      selected.clear();
    });
  }
}
