# خادم تفعيل Deadzon للفلاشر المحمي

هذا المجلد مستقل بالكامل ويشرح نظام تفعيل آمن لـ **DeadZoneFlasher.exe** بدون تعديل التطبيق الحالي.

## الفكرة العامة
- لا يتم توزيع `super.img` بشكل مباشر.
- يتم تشفيره مسبقًا داخل: `payload/customization.dz`.
- عند التشغيل، يقوم EXE بقراءة:
  - Fastboot Serial
  - Product
  - Build
- ثم يرسلها إلى الخادم.
- إذا الجهاز غير مسجل: يرجع `allowed=false` ويتوقف التفليش.
- إذا الجهاز مسجل ومسموح: يرجع الخادم مفتاح فك التشفير `payloadKey`.
- EXE يفك `customization.dz` مؤقتًا إلى `super.img` ثم يفعل التفليش ثم يحذف الملف المؤقت.

## تشغيل الخادم محليًا
1. ادخل إلى مجلد الخادم:
   ```bash
   cd protected_flasher_server/server
   ```
2. ثبّت الحزم:
   ```bash
   npm install
   ```
3. أنشئ ملف البيئة من المثال:
   ```bash
   cp .env.example .env
   ```
4. عدّل `.env` وضع قيم قوية لـ:
   - `PAYLOAD_KEY_B64`
   - `ADMIN_TOKEN`
5. أنشئ ملفات البيانات الأولية:
   ```bash
   mkdir -p data
   cp devices.example.json data/devices.json
   cp builds.example.json data/builds.json
   ```
6. شغّل الخادم:
   ```bash
   npm start
   ```
7. الخادم يعمل افتراضيًا على:
   - `http://localhost:3000`

## إضافة Serial جديد (Admin API)
استخدم endpoint:
- `POST /api/admin/add-device`
- Header إجباري:
  - `x-admin-token: <ADMIN_TOKEN>`

مثال cURL:
```bash
curl -X POST http://localhost:3000/api/admin/add-device \
  -H "Content-Type: application/json" \
  -H "x-admin-token: REPLACE_WITH_ADMIN_TOKEN" \
  -d '{
    "serial":"ABC123XYZ",
    "active":true,
    "expiresAt":"2027-12-31T23:59:59Z",
    "allowedBuilds":["CN_3.0.303"]
  }'
```

## كيف EXE يستدعي API التفعيل
Endpoint:
- `POST /api/activate`

Body JSON مطلوب:
```json
{
  "serial": "ABC123XYZ",
  "product": "zircon",
  "build": "CN_3.0.303"
}
```

استجابة عند الرفض:
```json
{
  "allowed": false,
  "reason": "device_not_registered"
}
```

استجابة عند القبول:
```json
{
  "allowed": true,
  "payloadKey": "<PAYLOAD_KEY_B64>"
}
```

## الملفات التي يجب عدم توزيعها نهائيًا
- `images/super.img`
- `DEVELOPMENT_PAYLOAD_KEY_DO_NOT_DISTRIBUTE.txt`
- `.env`

