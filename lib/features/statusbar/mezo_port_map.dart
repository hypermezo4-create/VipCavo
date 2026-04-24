import 'package:flutter/foundation.dart';

@immutable
class MezoBackgroundTarget {
  const MezoBackgroundTarget({
    required this.id,
    required this.title,
    required this.xmlSource,
    required this.colorKeys,
    required this.sliderKeys,
  });

  final String id;
  final String title;
  final String xmlSource;
  final List<String> colorKeys;
  final List<String> sliderKeys;
}

class MezoPortMap {
  const MezoPortMap._();

  static const String batterySource = 'reference/mezo/mezo/res/xml/my_battery_settings.smali';
  static const String clockSource = 'reference/mezo/mezo/res/xml/my_clock_settings.smali';
  static const String networkSource = 'reference/mezo/mezo/res/xml/elem_net_elite.smali';
  static const String backgroundSource = 'reference/mezo/mezo/res/xml/settings_iback_elite.smali';
  static const String seekbarLayoutSource = 'reference/mezo/mezo/res/layout/ed_seekbar_layout.smali';

  static const List<MezoBackgroundTarget> backgroundTargets = <MezoBackgroundTarget>[
    MezoBackgroundTarget(
      id: 'clock',
      title: 'Clock',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_clock.smali',
      colorKeys: <String>['elem_clock_bg_first_color', 'elem_clock_bg_second_color', 'elem_clock_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_clock_left_margin',
        'elem_clock_right_margin',
        'elem_clock_left_padd',
        'elem_clock_right_padd',
        'elem_clock_bottom_margin',
        'elem_clock_top_margin',
        'elem_clock_bg_stroke_width',
        'elem_clock_bg_LT_corner',
        'elem_clock_bg_RT_corner',
        'elem_clock_bg_LB_corner',
        'elem_clock_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'battery',
      title: 'Battery',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_bat.smali',
      colorKeys: <String>['elem_bat_bg_first_color', 'elem_bat_bg_second_color', 'elem_bat_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_bat_left_margin',
        'elem_bat_right_margin',
        'elem_bat_left_padd',
        'elem_bat_right_padd',
        'elem_bat_bottom_margin',
        'elem_bat_top_margin',
        'elem_bat_bg_stroke_width',
        'elem_bat_bg_LT_corner',
        'elem_bat_bg_RT_corner',
        'elem_bat_bg_LB_corner',
        'elem_bat_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'sim_1',
      title: 'SIM 1',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_net1.smali',
      colorKeys: <String>['elem_net1_bg_first_color', 'elem_net1_bg_second_color', 'elem_net1_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_net1_left_margin', 'elem_net1_right_margin', 'elem_net1_left_padd', 'elem_net1_right_padd', 'elem_net1_bottom_margin',
        'elem_net1_top_margin', 'elem_net1_bg_stroke_width', 'elem_net1_bg_LT_corner', 'elem_net1_bg_RT_corner', 'elem_net1_bg_LB_corner', 'elem_net1_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'sim_2',
      title: 'SIM 2',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_net2.smali',
      colorKeys: <String>['elem_net2_bg_first_color', 'elem_net2_bg_second_color', 'elem_net2_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_net2_left_margin', 'elem_net2_right_margin', 'elem_net2_left_padd', 'elem_net2_right_padd', 'elem_net2_bottom_margin',
        'elem_net2_top_margin', 'elem_net2_bg_stroke_width', 'elem_net2_bg_LT_corner', 'elem_net2_bg_RT_corner', 'elem_net2_bg_LB_corner', 'elem_net2_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'wifi',
      title: 'WiFi',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_wifi.smali',
      colorKeys: <String>['elem_wifi_bg_first_color', 'elem_wifi_bg_second_color', 'elem_wifi_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_wifi_left_margin', 'elem_wifi_right_margin', 'elem_wifi_left_padd', 'elem_wifi_right_padd', 'elem_wifi_bottom_margin',
        'elem_wifi_top_margin', 'elem_wifi_bg_stroke_width', 'elem_wifi_bg_LT_corner', 'elem_wifi_bg_RT_corner', 'elem_wifi_bg_LB_corner', 'elem_wifi_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'network_speed',
      title: 'Network Speed',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_speed.smali',
      colorKeys: <String>['elem_speed_bg_first_color', 'elem_speed_bg_second_color', 'elem_speed_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_speed_left_margin', 'elem_speed_right_margin', 'elem_speed_left_padd', 'elem_speed_right_padd', 'elem_speed_bottom_margin',
        'elem_speed_top_margin', 'elem_speed_bg_stroke_width', 'elem_speed_bg_LT_corner', 'elem_speed_bg_RT_corner', 'elem_speed_bg_LB_corner', 'elem_speed_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'notification_icon',
      title: 'Notification icon',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_fullscreen_notification.smali',
      colorKeys: <String>['elem_fullscreen_notification_bg_first_color', 'elem_fullscreen_notification_bg_second_color', 'elem_fullscreen_notification_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_fullscreen_notification_left_margin', 'elem_fullscreen_notification_right_margin', 'elem_fullscreen_notification_left_padd',
        'elem_fullscreen_notification_right_padd', 'elem_fullscreen_notification_bottom_margin', 'elem_fullscreen_notification_top_margin',
        'elem_fullscreen_notification_bg_stroke_width', 'elem_fullscreen_notification_bg_LT_corner', 'elem_fullscreen_notification_bg_RT_corner',
        'elem_fullscreen_notification_bg_LB_corner', 'elem_fullscreen_notification_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'status_icon',
      title: 'Status icon',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_status.smali',
      colorKeys: <String>['elem_status_bg_first_color', 'elem_status_bg_second_color', 'elem_status_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_status_left_margin', 'elem_status_right_margin', 'elem_status_left_padd', 'elem_status_right_padd', 'elem_status_bottom_margin',
        'elem_status_top_margin', 'elem_status_bg_stroke_width', 'elem_status_bg_LT_corner', 'elem_status_bg_RT_corner', 'elem_status_bg_LB_corner', 'elem_status_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'weather',
      title: 'Weather',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_weather.smali',
      colorKeys: <String>['elem_weather_bg_first_color', 'elem_weather_bg_second_color', 'elem_weather_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_weather_left_margin', 'elem_weather_right_margin', 'elem_weather_left_padd', 'elem_weather_right_padd', 'elem_weather_bottom_margin',
        'elem_weather_top_margin', 'elem_weather_bg_stroke_width', 'elem_weather_bg_LT_corner', 'elem_weather_bg_RT_corner', 'elem_weather_bg_LB_corner', 'elem_weather_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'date',
      title: 'Date',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_date.smali',
      colorKeys: <String>['elem_date_bg_first_color', 'elem_date_bg_second_color', 'elem_date_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_date_left_margin', 'elem_date_right_margin', 'elem_date_left_padd', 'elem_date_right_padd', 'elem_date_bottom_margin',
        'elem_date_top_margin', 'elem_date_bg_stroke_width', 'elem_date_bg_LT_corner', 'elem_date_bg_RT_corner', 'elem_date_bg_LB_corner', 'elem_date_bg_RB_corner',
      ],
    ),
    MezoBackgroundTarget(
      id: 'prompt_icon',
      title: 'Prompt icon',
      xmlSource: 'reference/mezo/mezo/res/xml/elem_bg_prompt.smali',
      colorKeys: <String>['elem_prompt_bg_first_color', 'elem_prompt_bg_second_color', 'elem_prompt_bg_stroke_color'],
      sliderKeys: <String>[
        'elem_prompt_left_margin', 'elem_prompt_right_margin', 'elem_prompt_left_padd', 'elem_prompt_right_padd', 'elem_prompt_bottom_margin',
        'elem_prompt_top_margin', 'elem_prompt_bg_stroke_width', 'elem_prompt_bg_LT_corner', 'elem_prompt_bg_RT_corner', 'elem_prompt_bg_LB_corner', 'elem_prompt_bg_RB_corner',
      ],
    ),
  ];
}
