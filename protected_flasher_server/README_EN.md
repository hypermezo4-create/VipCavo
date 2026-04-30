# Deadzon Protected Flasher Server (Standalone)

This folder contains an isolated activation server design for **DeadZoneFlasher.exe**.

## Purpose
- Do **not** distribute `super.img` directly.
- Distribute only encrypted payload: `payload/customization.dz`.
- EXE sends `serial + product + build` to server.
- Server allows only registered devices and active build.
- On allow, server returns `payloadKey`.
- EXE decrypts temporary `super.img`, flashes it, then securely deletes temp file.

## Files
- `server/server.js` - Express API server.
- `server/.env.example` - environment variable template.
- `server/devices.example.json` - sample registered devices list.
- `server/builds.example.json` - sample builds list.
- `client_config.example.json` - sample EXE integration config.

## Security Notes
- Never log or print payload key.
- Use strong random values for `PAYLOAD_KEY_B64` and `ADMIN_TOKEN`.
- Deploy behind HTTPS.
- Restrict server access by firewall/IP where possible.
- Keep data files in private server storage.

