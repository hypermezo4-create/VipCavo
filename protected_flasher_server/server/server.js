'use strict';

const fs = require('fs');
const path = require('path');
const express = require('express');
const dotenv = require('dotenv');

dotenv.config();

const PORT = Number(process.env.PORT || 3000);
const PRODUCT_REQUIRED = 'zircon';
const PAYLOAD_KEY_B64 = process.env.PAYLOAD_KEY_B64 || '';
const ADMIN_TOKEN = process.env.ADMIN_TOKEN || '';

if (!PAYLOAD_KEY_B64) {
  console.warn('[WARN] PAYLOAD_KEY_B64 is not set. Activation cannot return payload keys.');
}
if (!ADMIN_TOKEN) {
  console.warn('[WARN] ADMIN_TOKEN is not set. Admin endpoint is disabled.');
}

const DATA_DIR = path.join(__dirname, 'data');
const DEVICES_PATH = path.join(DATA_DIR, 'devices.json');
const BUILDS_PATH = path.join(DATA_DIR, 'builds.json');

function ensureDataFiles() {
  if (!fs.existsSync(DATA_DIR)) fs.mkdirSync(DATA_DIR, { recursive: true });
  if (!fs.existsSync(DEVICES_PATH)) fs.writeFileSync(DEVICES_PATH, JSON.stringify({ devices: [] }, null, 2));
  if (!fs.existsSync(BUILDS_PATH)) fs.writeFileSync(BUILDS_PATH, JSON.stringify({ builds: [] }, null, 2));
}

function readJson(filePath, fallback) {
  try {
    const raw = fs.readFileSync(filePath, 'utf8');
    return JSON.parse(raw);
  } catch {
    return fallback;
  }
}

function writeJson(filePath, data) {
  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
}

function normalizeText(value) {
  return String(value || '').trim();
}

function normalizeUpper(value) {
  return normalizeText(value).toUpperCase();
}

function isExpired(expiresAt) {
  if (!expiresAt) return false;
  const ts = Date.parse(expiresAt);
  if (Number.isNaN(ts)) return true;
  return ts < Date.now();
}

ensureDataFiles();

const app = express();
app.use(express.json({ limit: '64kb' }));

app.post('/api/activate', (req, res) => {
  const serial = normalizeUpper(req.body?.serial);
  const product = normalizeText(req.body?.product).toLowerCase();
  const build = normalizeText(req.body?.build);

  if (!serial || !product || !build) {
    return res.status(400).json({
      allowed: false,
      reason: 'missing_fields'
    });
  }

  if (product !== PRODUCT_REQUIRED) {
    return res.status(403).json({
      allowed: false,
      reason: 'unsupported_product'
    });
  }

  const buildsDb = readJson(BUILDS_PATH, { builds: [] });
  const devicesDb = readJson(DEVICES_PATH, { devices: [] });

  const buildEntry = (buildsDb.builds || []).find((b) => normalizeText(b.build) === build);
  if (!buildEntry || !buildEntry.active) {
    return res.status(403).json({
      allowed: false,
      reason: 'inactive_or_missing_build'
    });
  }

  const deviceEntry = (devicesDb.devices || []).find((d) => normalizeUpper(d.serial) === serial);
  if (!deviceEntry) {
    return res.status(403).json({
      allowed: false,
      reason: 'device_not_registered'
    });
  }

  if (!deviceEntry.active || isExpired(deviceEntry.expiresAt)) {
    return res.status(403).json({
      allowed: false,
      reason: 'device_inactive_or_expired'
    });
  }

  if (Array.isArray(deviceEntry.allowedBuilds) && deviceEntry.allowedBuilds.length > 0) {
    const allowed = deviceEntry.allowedBuilds.includes(build);
    if (!allowed) {
      return res.status(403).json({
        allowed: false,
        reason: 'build_not_allowed_for_device'
      });
    }
  }

  if (!PAYLOAD_KEY_B64) {
    return res.status(500).json({
      allowed: false,
      reason: 'server_key_not_configured'
    });
  }

  console.log(`[ACTIVATE] serial=${serial} product=${product} build=${build} allowed=true`);

  return res.json({
    allowed: true,
    payloadKey: PAYLOAD_KEY_B64
  });
});

app.post('/api/admin/add-device', (req, res) => {
  const auth = normalizeText(req.headers['x-admin-token']);
  if (!ADMIN_TOKEN || auth !== ADMIN_TOKEN) {
    return res.status(401).json({ ok: false, error: 'unauthorized' });
  }

  const serial = normalizeUpper(req.body?.serial);
  const active = Boolean(req.body?.active ?? true);
  const expiresAt = normalizeText(req.body?.expiresAt) || null;
  const allowedBuilds = Array.isArray(req.body?.allowedBuilds)
    ? req.body.allowedBuilds.map((x) => normalizeText(x)).filter(Boolean)
    : [];

  if (!serial) {
    return res.status(400).json({ ok: false, error: 'serial_required' });
  }

  if (expiresAt && Number.isNaN(Date.parse(expiresAt))) {
    return res.status(400).json({ ok: false, error: 'invalid_expiresAt_iso8601' });
  }

  const devicesDb = readJson(DEVICES_PATH, { devices: [] });
  const devices = Array.isArray(devicesDb.devices) ? devicesDb.devices : [];

  const existingIndex = devices.findIndex((d) => normalizeUpper(d.serial) === serial);
  const entry = {
    serial,
    active,
    expiresAt,
    allowedBuilds
  };

  if (existingIndex >= 0) {
    devices[existingIndex] = { ...devices[existingIndex], ...entry };
  } else {
    devices.push(entry);
  }

  writeJson(DEVICES_PATH, { devices });
  console.log(`[ADMIN] device_upsert serial=${serial}`);

  return res.json({ ok: true, serial });
});

app.listen(PORT, () => {
  console.log(`Deadzon activation server listening on :${PORT}`);
});
