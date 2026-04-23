class MezoStatusbarCardSource {
  const MezoStatusbarCardSource({
    required this.drawable,
    required this.titleResId,
    required this.summaryResId,
    required this.title,
    required this.summary,
    required this.fragment,
    required this.sectionId,
  });

  final String drawable;
  final String titleResId;
  final String summaryResId;
  final String title;
  final String summary;
  final String fragment;
  final String sectionId;

  String get drawablePath => 'reference/mezo/mezo/res/drawable-xxxhdpi/$drawable.png';
}

class MezoStatusbarBoardSourceMap {
  const MezoStatusbarBoardSourceMap._();

  static const List<MezoStatusbarCardSource> cards = <MezoStatusbarCardSource>[
    MezoStatusbarCardSource(
      drawable: 'elem_resize_card',
      titleResId: 'resize_mezo_st_0',
      summaryResId: 'resize_mezo_st_1',
      title: 'Resize statusbar',
      summary: 'Notch/cutout/corners size etc',
      fragment: 'com.android.settings.MyResizeMezo',
      sectionId: 'resize_statusbar',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_bat_card',
      titleResId: 'battery_mezoset_0',
      summaryResId: 'battery_mezoset_1',
      title: 'Battery',
      summary: 'Customize battery view icon, size, color etc',
      fragment: 'com.android.settings.MyBatterySettings',
      sectionId: 'battery',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_clock_card',
      titleResId: 'my_clock_settings_title',
      summaryResId: 'my_clock_settings_summary',
      title: 'Clock',
      summary: 'Customize clock color, size, font etc',
      fragment: 'com.android.settings.MyClockSettings',
      sectionId: 'clock',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_speed_card',
      titleResId: 'netspeed_mezo_st_0',
      summaryResId: 'netspeed_mezo_st_1',
      title: 'Netspeed',
      summary: 'Netspeed color, size, offset etc',
      fragment: 'com.android.settings.NetspeedMezoSettings',
      sectionId: 'netspeed',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_net_card',
      titleResId: 'net_mezo_st_0',
      summaryResId: 'net_mezo_st_1',
      title: 'Network',
      summary: 'Customize network icons to your choice',
      fragment: 'com.android.settings.StatusbarIconColorsSettings',
      sectionId: 'network',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_notif_card',
      titleResId: 'notif_mezo_st_0',
      summaryResId: 'notif_mezo_st_1',
      title: 'Notification icons',
      summary: 'Notification icon color, size, offset etc',
      fragment: 'com.android.settings.MyNotifWeather',
      sectionId: 'notification_icons',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_status_card',
      titleResId: 'status_mezo_st_0',
      summaryResId: 'status_mezo_st_1',
      title: 'Status icons',
      summary: 'Status icon color, size, offset etc',
      fragment: 'com.android.settings.MyStatusIcons',
      sectionId: 'status_icons',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_date_card',
      titleResId: 'date_mezo_st_0',
      summaryResId: 'date_mezo_st_1',
      title: 'Date',
      summary: 'Date color, size, offset etc',
      fragment: 'com.android.settings.MyDateMezo',
      sectionId: 'date',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_weather_card',
      titleResId: 'weather_mezo_st_0',
      summaryResId: 'weather_mezo_st_1',
      title: 'Weather',
      summary: 'Weather icon color, size etc',
      fragment: 'com.android.settings.MyWeatherIcon',
      sectionId: 'weather',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_prompt_card',
      titleResId: 'prompt_mezo_st_0',
      summaryResId: 'prompt_mezo_st_1',
      title: 'Prompt icon',
      summary: 'Icon appear while calling etc',
      fragment: 'com.android.settings.MyPromptIcon',
      sectionId: 'prompt_icon',
    ),
    MezoStatusbarCardSource(
      drawable: 'elem_iback_card',
      titleResId: 'iback_mezo_st_0',
      summaryResId: 'iback_mezo_st_1',
      title: 'Background of statubar icons',
      summary: 'Configure background of statusbar icons',
      fragment: 'com.android.settings.MyIconBackMezo',
      sectionId: 'background',
    ),
  ];

  static String boardDrawablePath(String moduleId) {
    return 'reference/mezo/mezo/res/drawable-xxxhdpi/${_boardDrawableByModule[moduleId] ?? 'elem_clock_card'}.png';
  }

  static const Map<String, String> _boardDrawableByModule = <String, String>{
    'clock': 'elem_clock_card',
    'battery': 'elem_bat_card',
    'netspeed': 'elem_speed_card',
    'network': 'elem_net_card',
    'notification_icons': 'elem_notif_card',
    'status_icons': 'elem_status_card',
    'date': 'elem_date_card',
    'weather': 'elem_weather_card',
    'prompt_icon': 'elem_prompt_card',
  };
}
