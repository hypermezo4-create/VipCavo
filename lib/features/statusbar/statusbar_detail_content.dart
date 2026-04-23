class StatusbarDetailContent {
  const StatusbarDetailContent({required this.title, required this.highlights});

  final String title;
  final List<String> highlights;
}

const Map<String, StatusbarDetailContent> statusbarDetailContent = <String, StatusbarDetailContent>{
  'resize_statusbar': StatusbarDetailContent(
    title: 'Resize statusbar',
    highlights: <String>[
      'Source-backed controls mirror settings_resize_elite for height, margins, and cutout spacing.',
      'Notch Settings includes camera location, camera position line, and camera width behavior.',
      'Left camera notch settings controls left cutout placement, first element position, and remove-camera behavior.',
    ],
  ),
  'battery': StatusbarDetailContent(
    title: 'Battery',
    highlights: <String>[
      'Control battery visibility, style family, icon profile, and percent marker behavior.',
      'Adjust icon, charge indicator, and percent measurements independently.',
      'Customize battery font and color layers for a premium high-contrast finish.',
    ],
  ),
  'clock': StatusbarDetailContent(
    title: 'Clock',
    highlights: <String>[
      'Manage statusbar and notification center clock blocks with independent controls.',
      'Set 24-hour mode, blinking dots, seconds, animation style, and format presets.',
      'Customize date, weather, and settings icon blocks with refined typography controls.',
    ],
  ),
  'netspeed': StatusbarDetailContent(
    title: 'Netspeed',
    highlights: <String>[
      'Switch between traffic display modes and tune refresh behavior.',
      'Refine speed text sizing, spacing, and color for dense top bars.',
      'Keep traffic telemetry clean and readable on compact devices.',
    ],
  ),
  'network': StatusbarDetailContent(
    title: 'Network',
    highlights: <String>[
      'Configure Wi-Fi, signal, VoWiFi, and VoLTE style hierarchies.',
      'Tune icon sizes, spacing, rotation, and typography for every network cluster.',
      'Preserve structure while enabling cleaner and more organized sub-control groups.',
    ],
  ),
  'notification_icons': StatusbarDetailContent(
    title: 'Notification icons',
    highlights: <String>[
      'Control visibility, ordering behavior, icon size, spacing, and tint.',
      'Keep alert symbols compact without clipping in right-side clusters.',
      'Blend notification symbols with glassy statusbar styling.',
    ],
  ),
  'status_icons': StatusbarDetailContent(
    title: 'Status icons',
    highlights: <String>[
      'Manage utility icons such as Bluetooth, alarm, and headset indicators.',
      'Tune icon size and spacing to avoid crowding in compact widths.',
      'Apply dedicated color tint for consistency with your Mezo palette.',
    ],
  ),
  'date': StatusbarDetailContent(
    title: 'Date',
    highlights: <String>[
      'Enable date in statusbar and choose polished date formats.',
      'Adjust date typography sizing and spacing for balanced hierarchy.',
      'Use dedicated color control for readable glass overlays.',
    ],
  ),
  'weather': StatusbarDetailContent(
    title: 'Weather',
    highlights: <String>[
      'Show weather with optional animation and dedicated style controls.',
      'Tune weather typography and spacing for compact statusbar placement.',
      'Maintain readability with custom color controls on dark glass layers.',
    ],
  ),
  'prompt_icon': StatusbarDetailContent(
    title: 'Prompt icon',
    highlights: <String>[
      'Enable prompt icon visibility and tune scale/offset behavior.',
      'Use color accent controls to match your global status palette.',
      'Keep the prompt module subtle while preserving quick recognizability.',
    ],
  ),
  'background': StatusbarDetailContent(
    title: 'Background',
    highlights: <String>[
      'Configure per-item backgrounds for clock, battery, SIM, Wi-Fi, and more.',
      'Set distinct background tones for notification, status, weather, date, and prompt items.',
      'Build a layered translucent aesthetic without crowding the status layout.',
    ],
  ),
};
