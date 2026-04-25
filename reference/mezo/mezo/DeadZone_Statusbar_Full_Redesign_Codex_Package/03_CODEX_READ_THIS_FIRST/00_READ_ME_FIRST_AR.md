# DeadZone / VipCavo — Full Statusbar Redesign Package for Codex

ده البكدج النهائي الكامل عشان Codex ينفذ إعادة تصميم شاشة Statusbar بالكامل مرة واحدة.

## الفكرة
المود القديم شغال بكل تفاصيله. المطلوب مش تغيير التشغيل، المطلوب تغيير الواجهة فقط.

Codex لازم يستخدم:
- نفس ملفات XML الحالية قدر الإمكان.
- نفس ملفات Smali الحالية قدر الإمكان.
- نفس preference keys.
- نفس IDs.
- نفس apply methods.
- نفس internal logic.

ويحوّل الشكل القديم إلى UI جديد احترافي بنفس التفاصيل الموجودة، بدون كسر أي وظيفة.

## محتويات البكدج

### 01_OLD_WORKING_MOD_FULL_REFERENCE
كل صور المود القديم اللي شغال + ZIP الأصلي.

### 02_NEW_FULL_UI_REDESIGN_REFERENCE
صور التصميم الجديد الكاملة لكل شاشة/جزء:
1. Statusbar Studio main screen
2. Arrange Layout single row
3. Arrange Layout two rows
4. Battery
5. Clock
6. Network
7. Date & Weather
8. Icons
9. Prompt & Background
10. Background Advanced

### 03_CODEX_READ_THIS_FIRST
أهم ملفات التعليمات لـ Codex. يبدأ من هنا.

### 04_IMPLEMENTATION_MAPS
خريطة تحويل القديم للجديد بدون كسر المفاتيح.

### 05_BUILD_AND_TEST_CHECKLIST
اختبار سريع بعد التنفيذ.

### 06_EXTRA_VISUAL_BACKUPS
صور إضافية مرجعية لو احتاج تفاصيل شكل/ستايل.

## أهم قاعدة
لا تغيّر أي حاجة في التشغيل. غيّر UI فقط.

ممنوع تغيير:
- package name
- applicationId
- signing configs
- release keys
- google-services.json
- Firebase config
- Gradle namespace
- GitHub Actions
- AndroidManifest package/application labels إلا لو موجودة بالفعل
- preference keys
- XML android:key
- view IDs المرتبطة بـ Smali
- أسماء classes أو methods المستخدمة داخليًا

## شكل التنفيذ المطلوب
- UI جديد premium iOS glassmorphism.
- Dark navy/black.
- Blue/cyan glow.
- Rounded glass cards.
- Floating bottom navigation موجود زي التطبيق.
- كل التفاصيل القديمة تفضل موجودة لكن بأسماء مفهومة.
- أي كلام تقني زي Root / ROM / key / status_bar_elem_position لا يظهر للمستخدم.

## الافتراضي
Default layout = Single Row.

Two Rows = اختيار إضافي داخل Arrange Layout.

Restore Default يرجع دائمًا Single Row.
