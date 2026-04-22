class StatusbarDetailContent {
  const StatusbarDetailContent({required this.title, required this.highlights});

  final String title;
  final List<String> highlights;
}

const Map<String, StatusbarDetailContent> statusbarDetailContent = <String, StatusbarDetailContent>{
  'resize_statusbar': StatusbarDetailContent(
    title: 'Resize statusbar',
    highlights: <String>[
      'Adjust global top margin and safe area fit.',
      'Choose center/left cutout behavior.',
      'Fine tune balance for Dynamic Island style layouts.',
    ],
  ),
  'battery': StatusbarDetailContent(
    title: 'Battery',
    highlights: <String>[
      'Control battery icon visibility and scale.',
      'Switch indicator style families.',
      'Prepare for charging/percentage expansion presets.',
    ],
  ),
  'clock': StatusbarDetailContent(
    title: 'Clock',
    highlights: <String>[
      'Enable seconds and smooth transitions.',
      'Adjust typography size and style.',
      'Tune animation mode for time updates.',
    ],
  ),
  'netspeed': StatusbarDetailContent(
    title: 'Netspeed',
    highlights: <String>[
      'Toggle live upload/download text.',
      'Adjust text scale for dense layouts.',
      'Apply readable accents.',
    ],
  ),
  'network': StatusbarDetailContent(
    title: 'Network',
    highlights: <String>[
      'Pick signal icon family and spacing.',
      'Control Wi-Fi/mobile icon rhythm.',
      'Prepare compact and classic modes.',
    ],
  ),
  'notification_icons': StatusbarDetailContent(
    title: 'Notification icons',
    highlights: <String>[
      'Choose max visible icons before overflow.',
      'Set compact tint style.',
      'Balance with other right-side groups.',
    ],
  ),
  'status_icons': StatusbarDetailContent(
    title: 'Status icons',
    highlights: <String>[
      'Manage utility icons like alarm/headset.',
      'Scale icon set for compact bars.',
      'Switch profile presets quickly.',
    ],
  ),
  'date': StatusbarDetailContent(
    title: 'Date',
    highlights: <String>[
      'Pick date format and text size.',
      'Set accent color and spacing behavior.',
      'Align with clock layout in live preview.',
    ],
  ),
  'weather': StatusbarDetailContent(
    title: 'Weather',
    highlights: <String>[
      'Show condition text/icon in status area.',
      'Control icon style family.',
      'Keep text readable with dark glass backgrounds.',
    ],
  ),
  'prompt_icon': StatusbarDetailContent(
    title: 'Prompt icon',
    highlights: <String>[
      'Enable or hide prompt icon instantly.',
      'Adjust icon scale and color accent.',
      'Keep icon behavior subtle and premium.',
    ],
  ),
  'background': StatusbarDetailContent(
    title: 'Background',
    highlights: <String>[
      'Enable translucent status backdrop.',
      'Tune blur strength and tint.',
      'Balance depth against icon readability.',
    ],
  ),
};
