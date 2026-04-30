# DeadZone / VipCavo — Mount + Statusbar Progress Summary

> آخر تحديث حسب آخر حالة وصلنا لها في الشات.  
> الهدف من الملف: يتبعت لـ Codex أو يتفتح في أي شات جديد عشان نكمل من نفس النقطة بدون إعادة شرح.

---

## 1) الحالة العامة الحالية

المشروع الحالي هو **DeadZone / VipCavo Flutter app**، والتركيز الحالي كان على:

- جعل **Mount Studio** مركز التحكم الحقيقي في شكل التطبيق.
- ربط ألوان ومكونات Mount بالتطبيق كله عن طريق `DeadzonThemeTokens`.
- إصلاح **Apply / Restore / Live Apply** في Mount.
- إكمال الجزء المتبقي من **Statusbar Adjustment**، خصوصًا الموديولات البايظة من أول:
  - Notification icons
  - Status icons
  - Date
  - Weather
  - Prompt icon
  - Background

الأجزاء العلوية من Statusbar كانت شغالة بالفعل، لذلك اتفقنا إننا **ما نلمسهاش** إلا لو فيه إصلاح مشترك ضروري.

الأجزاء العلوية الشغالة:

- Resize statusbar
- Battery
- Clock
- Netspeed
- Network

---

## 2) Mount Studio — المطلوب اللي اتفقنا عليه

Mount لازم يبقى هو **Master visual controller** للتطبيق كله، مش صفحة ديكور.

### Tabs المطلوبة فقط

لازم Mount يحتوي فقط على:

1. Colors
2. App Effects
3. Components
4. Control Apps
5. Profiles

### ممنوع

- ممنوع رجوع Preview tab.
- ممنوع Preview button.
- ممنوع أي sample/preview board مش مطلوب.

---

## 3) Mount — Apply / Restore / Live Apply

### Apply

تم طلب وتنفيذ إن زر **Apply** يكون حقيقي:

- يحفظ إعدادات Mount الحالية.
- يطبّق ألوان Mount على shared theme tokens.
- يحفظ bridge config.
- يطبّق component colors.
- يفضل في نفس الصفحة ولا يرجع Home.
- يظهر feedback نجاح.

### Restore

تم طلب وتنفيذ إن زر **Restore** يكون حقيقي:

- يعرض confirmation dialog.
- Cancel يقفل فقط بدون تغيير.
- Restore يرجع Mount defaults.
- يحفظ القيم الافتراضية.
- يحدّث tokens.
- يفضل في نفس الصفحة.

### Live Apply

تم طلب وتنفيذ النظام بالشكل ده:

- لو Live Apply ON: التغييرات تظهر فورًا بصريًا حيث ينفع.
- لو Live Apply OFF: التغييرات تفضل draft ولا تتحفظ إلا بعد Apply.

---

## 4) Mount — الملفات اللي اتعدلت في Apply/Restore

تم تعديل:

```text
lib/features/mount/presentation/mount_studio_controller.dart
lib/features/mount/presentation/mount_studio_screen.dart
lib/core/theme/deadzon_theme_controller.dart
```

الغرض:

- ربط apply/restore بالـ config الحقيقي.
- جعل Mount يغذي `DeadzonThemeTokens`.
- الحفاظ على الصفحة بدون navigation bug.

---

## 5) Mount Token Propagation — اللي اتعمل

تم عمل عدة تمريرات عشان Mount colors/components ينتشروا داخل التطبيق.

### Tokens اتضافت أو اتربطت

- `switchOffColor`
- `checkboxOffColor`
- `checkboxActive`
- `checkboxInactive`
- `iconAccent`
- `shadow(context)` لاحقًا اتضاف/اتصلح بسبب أخطاء build.

### Shared widgets اتربطت بـ Mount tokens

تم تحويل widgets مشتركة لاستخدام Mount-driven tokens:

- `DeadZoneSettingsCard`
- `DeadZoneNavigationRow`
- `DeadZoneSwitchRow`
- `DeadZoneSliderRow`
- `DeadZoneSelectRow`
- `DeadZoneColorRow`
- `DeadZoneFontRow`
- `DeadZoneOptionSheet`
- `DeadZoneColorPickerSheet`
- `DeadZoneFontPickerSheet`
- `DeadZoneIconChip`
- `MountGlassCard`
- `MountComponentsTab`
- `DeadzonFloatingTabBar`

### Bottom nav

تم ربط أجزاء من bottom nav بالـ tokens:

- nav surface
- border
- selected pill
- selected icon/label
- idle text
- shadow

---

## 6) Icon Accent

تم تحديد gap مهم: `DeadZoneIconChip` كان يستخدم `accent` العام بدل `iconAccent`.

تم تنفيذ follow-up:

- `DeadZoneIconChip` بقى يستخدم `DeadzonThemeTokens.iconAccent(context)`.
- chip background يستخدم iconAccent بدرجات opacity مختلفة حسب selected/unselected.
- border يستخدم border token أو iconAccent أقوى في selected state.

### مناطق اتربطت بـ iconAccent

- Home leading icons / verified icon
- Statusbar hub icons
- Settings icons
- Mount rows/icons
- Statusbar detail row icons
- Bottom nav selected icon

---

## 7) Mount — المشاكل اللي لسه لازم تتراجع بصريًا

رغم إن Apply/Restore/Live Apply شغالين، لازم اختبار بصري:

- هل تغيير iconAccent يغير كل الأيقونات فعلاً؟
- هل switch ON/OFF colors بتظهر في كل السويتشات؟
- هل seekbar/progressbar color بيأثر على كل sliders؟
- هل card tint يغير shared cards؟
- هل text accent يظهر في العناوين/selected text؟
- هل light mode بقي نظيف؟
- هل dark mode بقي premium ومقروء؟

---

## 8) Statusbar — التصحيح المهم في الـ scope

في البداية كان فيه أمر كبير لإعادة بناء Statusbar كله، لكن تم توضيح الآتي:

**مش مطلوب إعادة بناء كل Statusbar.**

الأجزاء اللي فوق في الصفحة شغالة، والمطلوب فقط من أول الجزء الظاهر في الصورة:

```text
Notification icons
Status icons
Date
Weather
Prompt icon
Background
```

يعني المطلوب كان rebuild حقيقي للست موديولات دول فقط، بدون لمس:

- Resize statusbar
- Battery
- Clock
- Netspeed
- Network

---

## 9) Statusbar — الست موديولات اللي اتعملها rebuild

Codex عمل تمريرة مخصصة للست موديولات:

1. Notification icons
2. Status icons
3. Date
4. Weather
5. Prompt icon
6. Background

### Routing

تم تعديل detail-screen routing بحيث الست موديولات دول يروحوا إلى focused module-detail flow.

الأجزاء العلوية الشغالة ظلت تستخدم builders القديمة الخاصة بها.

---

## 10) Statusbar — المفاتيح المستخدمة للست موديولات

### Notification icons

المفاتيح المستخدمة:

```text
reverse_notification_sorting_order
notif_icon_color
notif_icon_zoom
notif_icon_scale
notif_icon_division
```

الكنترولات:

- Switch
- Color row
- Sliders

### Status icons

المفاتيح المستخدمة:

```text
elem_status_element_visible
status_icon_zoom
status_icon_scale
status_icon_division
status_icon_color
```

الكنترولات:

- Visibility switch
- Sliders
- Color row

### Date

المفاتيح المستخدمة:

```text
elem_date_element_visible
statusbar_date_format
status_date_zoom
status_date_division
status_date_color
status_date_typefase
```

الكنترولات:

- Visibility switch
- Select/list
- Sliders
- Color row
- Font row

### Weather

المفاتيح المستخدمة:

```text
elem_weather_element_visible
weather_anim_enable
status_weather_zoom
status_weather_division
status_weather_color
status_weather_typefase
```

الكنترولات:

- Switches
- Sliders
- Color row
- Font row

### Prompt icon

المفاتيح المستخدمة:

```text
elem_prompt_scale
elem_prompt_division
```

الكنترولات:

- Sliders

ملاحظة: لم يتم اختراع visibility/color keys للـ Prompt لأن Codex لم يجد مفاتيح حقيقية لها في inventory/mapping.

### Background

تم الحفاظ على background-specific editor وربطه بالـ focused module detail flow.

الكنترولات:

- Background mapped controls
- Background target editor rows
- Color picker path

---

## 11) Statusbar — المطلوب من شكل الكروت للست موديولات

الكروت لازم تكون:

- compact
- professional
- ارتفاعها مش ضخم
- icon chip في الشمال
- title + subtitle واضحين
- chevron في اليمين
- tokenized card/background/border/shadow
- iconAccent من Mount
- مقروءة في light/dark
- bottom padding آمن فوق bottom nav
- بدون preview أو sample board

### Subtitles النظيفة المطلوبة

```text
Notification icons: Notification icon visibility, size, and spacing
Status icons: Utility icon visibility, size, and placement
Date: Date format, font, color, and spacing
Weather: Weather text, icon, color, and placement
Prompt icon: Prompt icon style, reveal, color, and size
Background: Statusbar background, blur, tint, and shadow
```

---

## 12) Statusbar — قواعد عرض الكنترولات

أي detail page من الستة لازم تستخدم:

```text
switch/check preference -> DeadZoneSwitchRow
seekbar/slider -> DeadZoneSliderRow
list/dropdown -> DeadZoneSelectRow + option sheet
color preference -> DeadZoneColorRow + full universal color picker
font/typeface preference -> DeadZoneFontRow + /product/media/fonts picker
navigation/child page -> DeadZoneNavigationRow
```

---

## 13) Color Picker Requirements

كل color row في Statusbar detail pages لازم يستخدم shared full color picker.

لازم يدعم:

- full color square
- hue slider
- alpha slider
- `#AARRGGBB`
- transparent `#00000000`
- presets
- Cancel
- Apply

القواعد:

- Cancel لا يكتب أي قيمة.
- Apply يكتب الصيغة القديمة المتوقعة.
- لا يرجع Home.
- يفضل في نفس الصفحة.

---

## 14) Font Picker Requirements

كل font/typeface row لازم يستخدم:

```text
/product/media/fonts/
```

القواعد:

- يقرأ `.ttf` و `.otf`.
- دائمًا يحتوي على `Default`.
- `Default` تتحفظ كـ `Default`.
- أي خط غير default يتحفظ كـ:

```text
/product/media/fonts/<file-name>
```

- UI يعرض اسم الملف فقط.
- لا ينهار لو المسار غير متاح.
- لا يرجع Home.

---

## 15) ممنوع الكلام الداخلي في UI

ظاهر للمستخدم ممنوع يحتوي على:

```text
Source-preserved
Depends on
old mod
Legacy fragment
Android.Theme.Customization
Coming soon
future flow
debug
TODO
raw keys
XML class names
fragment names
```

المفاتيح تفضل داخلية فقط للكود والحفظ.

---

## 16) أخطاء build/analyze اللي ظهرت وتم التعامل معها

### خطأ `DeadzonThemeTokens.shadow(context)`

ظهرت أخطاء لأن بعض الملفات استخدمت:

```dart
DeadzonThemeTokens.shadow(context)
```

لكن method لم تكن موجودة.

المطلوب كان إضافة accessor اسمه `shadow(BuildContext context)` داخل `DeadzonThemeTokens` أو استخدام الموجود فعلاً.

### خطأ `secondary`

تم حذف متغير `secondary` ثم ظل مستخدمًا في:

```text
lib/core/widgets/deadzone_settings_widgets.dart
```

المطلوب كان إما إرجاعه كـ token صحيح أو استبداله بـ token موجود.

### خطأ `onSurfaceVariant`

Codex استخدم:

```dart
DeadzonThemeTokens.onSurfaceVariant(context)
```

لكنه غير موجود.

المطلوب كان فتح `deadzon_theme_controller.dart` واستخدام اسم token موجود فعلاً، أو إضافة token واحد صحيح مثل:

```dart
textSecondary(BuildContext context)
```

بدون hardcoded colors داخل widget files.

---

## 17) آخر خطأ Build ظاهر حاليًا

آخر Screenshot أظهر الخطأ التالي في:

```text
lib/features/statusbar/presentation/statusbar_screen.dart
```

### الخطأ الأول

```text
line 3522:25
The method '_fontDisplayLabel' isn't defined for the type '_SettingControl'.
```

السبب:

تم استخدام `_fontDisplayLabel` داخل `_SettingControl` لكن الدالة غير متاحة في نفس الـ scope.

الإصلاح المطلوب:

إضافة helper داخل `_SettingControl` أو scope متاح:

```dart
String _fontDisplayLabel(String? value) {
  final raw = (value ?? '').trim();
  if (raw.isEmpty || raw == 'Default') return 'Default';
  return raw.split('/').last;
}
```

السلوك المطلوب:

```text
Default -> Default
/product/media/fonts/ios_bold.ttf -> ios_bold.ttf
empty/null -> Default
```

### الخطأ الثاني

```text
line 4059:7
The declaration '_NotificationIconsPreview' isn't referenced.
```

السبب:

Preview قديم متساب ومش مستخدم، وممنوع أساسًا رجوع Preview في Statusbar.

الإصلاح المطلوب:

- حذف `_NotificationIconsPreview` بالكامل.
- عدم إعادة ربطه.
- عدم إضافة Preview أو Sample board.

---

## 18) أمر Codex لإصلاح آخر خطأ فقط

```text
Continue from the current branch.

Fix the current flutter analyze errors in:

lib/features/statusbar/presentation/statusbar_screen.dart

Current errors:

1)
line 3522:25
The method '_fontDisplayLabel' isn't defined for the type '_SettingControl'.

Required fix:
- Inspect statusbar_screen.dart for any existing font label helper.
- If a helper already exists elsewhere, move it or make it accessible to _SettingControl safely.
- If no helper exists, add a small private helper inside _SettingControl or nearby shared scope.

Expected behavior:
Default -> "Default"
/product/media/fonts/ios_bold.ttf -> "ios_bold.ttf"
empty/null -> "Default"

Example:
String _fontDisplayLabel(String? value) {
  final raw = (value ?? '').trim();
  if (raw.isEmpty || raw == 'Default') return 'Default';
  return raw.split('/').last;
}

2)
line 4059:7
The declaration '_NotificationIconsPreview' isn't referenced.

Required fix:
- Remove the unused _NotificationIconsPreview class/function completely.
- Do not reconnect it.
- Do not add Preview back anywhere.

Rules:
- Do NOT touch working upper modules.
- Do NOT change the six module routing unless needed for this compile fix.
- Do NOT touch Apply/Restore/Live Apply.
- Do NOT rename old Mezo keys.
- Do NOT touch SystemUI/dex/smali/reference/mezo.
- Do NOT add Preview tab/card/sample board.
- Do NOT add ignore comments.
- Do NOT disable lints.

After fixing:
Run:
flutter analyze
flutter build apk --release --split-per-abi

Final response:
1. How _fontDisplayLabel was fixed.
2. Whether _NotificationIconsPreview was removed.
3. Changed files.
4. Confirmation no Preview UI was re-added.
5. Confirmation old keys preserved.
6. flutter analyze result.
7. build result.
```

---

## 19) Safety Rules الثابتة

ممنوع لمس:

```text
SystemUI
dex/classes
smali
reference/mezo/mezo/**
package name
signing config
GitHub workflows
old Mezo keys
Settings.System keys
status_bar_elem_position
```

ممنوع:

```text
rename old keys
remove working controls
invent fake controls
add Preview tab/card/sample board
show raw keys
disable lints
add ignore comments
break Apply/Restore/Live Apply
break working upper modules
```

---

## 20) اختبار مطلوب بعد نجاح الـ build

بعد APK ينزل:

### Mount

اختبر:

- Apply يحفظ ويطبق.
- Restore يرجع الافتراضي.
- Live Apply ON/OFF يعمل كما اتفقنا.
- تغيير `Icon accent color` يغير الأيقونات.
- تغيير slider/switch/card/text colors يظهر في التطبيق.

### Statusbar الست موديولات

افتح:

- Notification icons
- Status icons
- Date
- Weather
- Prompt icon
- Background

وتأكد من:

- الصفحة ليست فاضية.
- كل control ظاهر.
- لا يوجد raw keys.
- لا يوجد كلام داخلي غريب.
- Color picker يفتح ويطبق.
- Font picker يفتح في Date و Weather.
- لا يوجد Home-return bug.
- لا يوجد Preview/sample board.

---

## 21) آخر نقطة نكمل منها

آخر حاجة مطلوبة الآن هي إصلاح analyze في:

```text
lib/features/statusbar/presentation/statusbar_screen.dart
```

بسبب:

```text
_fontDisplayLabel undefined
_NotificationIconsPreview unused
```

بعد إصلاحهم، يتم تشغيل:

```bash
flutter analyze
flutter build apk --release --split-per-abi
```

ثم اختبار الست موديولات على الجهاز.

