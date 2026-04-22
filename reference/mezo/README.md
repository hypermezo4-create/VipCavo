# Mezo Reference Pack

This folder stores imported **Mezo source references** used to port ROM settings into the Flutter UI architecture.

## Structure

- `xml/` — preference and settings definitions used as source-of-truth for section ordering and option mapping.
- `layout/` — original layout definitions for grouping, card hierarchy, and component intent.
- `drawable/` — drawable and visual config references for icon/background style behavior.
- `res/` — original extracted source package kept for traceability.

## Important

These references are **not runtime Flutter assets**.
They are retained for mapping legacy keys into clean, human-readable Mezo UI controls.
