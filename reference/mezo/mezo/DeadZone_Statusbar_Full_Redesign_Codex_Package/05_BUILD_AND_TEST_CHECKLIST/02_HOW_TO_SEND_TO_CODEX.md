# How to Use This Package with Codex

1. Upload the latest DeadZone / VipCavo project ZIP to Codex.
2. Upload this package ZIP too.
3. Tell Codex:

Use `03_CODEX_READ_THIS_FIRST/01_MASTER_CODEX_PROMPT.md` as the main instruction.

4. Tell Codex:

Do not rewrite the whole project. Only redesign Statusbar screens and preserve XML/Smali keys.

5. After Codex finishes:
- Download changed files or full project.
- Build APK through the existing GitHub Actions.
- Test Statusbar screen first.

## Best Codex message to paste

Use this exact message:

```
Read the uploaded package:
DeadZone_Statusbar_Full_Redesign_Codex_Package.zip

Start from:
03_CODEX_READ_THIS_FIRST/01_MASTER_CODEX_PROMPT.md

Implement the full Statusbar UI redesign once, using the new reference images.
Preserve the old working XML/Smali keys, IDs, preference keys, apply logic, package/applicationId/signing/google-services/GitHub Actions.
Do not rewrite the whole project.
Do not expose technical/root/ROM/key wording to users.
Default layout must be Single Row; Two Rows optional.
Direct drag, no long press.
Build and fix only issues related to this hotfix.
```
