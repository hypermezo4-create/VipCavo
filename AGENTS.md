# AGENTS.md

## Deadzon — Project Rules

### Identity
- App name: Deadzon
- Developer: Mezo
- Build label: Base Alpha
- ROM label: ROM Deadzon
- Version label: CN 3.0.303

### Repository Rule
- Work ONLY inside the current repository.
- Do NOT create a new project.
- Do NOT reintroduce website code or legacy web structure.
- This repository is a Flutter rebuild and must stay Flutter-first.

### Product Direction
Deadzon is a premium standalone mobile app hub for organized ROM feature access.
It must NOT feel like an old Android settings dump or a dev tool.
It must feel like a high-end smooth app.

### Visual Direction
Use this as the primary design language:
- premium iOS-style glassmorphism
- blue/green translucent surfaces
- soft blur
- rounded corners
- floating polished bottom navigation
- strong spacing and hierarchy
- modern typography
- polished grouped cards
- clean iconography
- smooth motion and transitions
- no heavy ugly gradients
- no cluttered red gamer style
- no old ROM settings look

### Current Phase Rules
- No root requirement in this phase
- Android only for now
- Flutter only
- Build a strong UI shell first
- Keep the code modular and clean
- Prefer reusable widgets and shared visual language

### Priority Features
1. Home
2. Statusbar Adjustment
3. Mount
4. Settings

### UX Priorities
- smooth animations
- clean transitions
- premium cards
- elegant bottom navigation
- modern list/detail flow
- polished controls
- strong readability
- consistent spacing
- refined dark mode

### Statusbar Section Direction
This is one of the most important parts of the app.
It should feel premium and powerful.

Subsections should be visually organized such as:
- Resize statusbar
- Battery
- Clock
- Netspeed
- Network
- Notification icons
- Status icons
- Date
- Weather
- Prompt icon
- Background

### Mount Section Direction
This is also a top-priority section.

It should support a premium UI around:
- choose monet color
- color effect
- seekbar / progressbar color
- checkbox on/off background colors
- checkbox on/off colors
- live preview

### Settings Direction
- appearance
- theme mode
- UI palette
- app info
- reset dialogs
- build info

### Code Quality Rules
- Fix analyze issues before expanding the app further
- Keep files readable
- Avoid giant monolithic widgets when possible
- Build production-grade structure, not placeholder junk
- Use reusable components for:
  - glass card
  - section headers
  - top bars
  - bottom navigation
  - action buttons
  - list rows
  - color chips/pickers

### Architecture Preference
Suggested structure:
- lib/core/theme
- lib/core/router
- lib/core/widgets
- lib/core/constants
- lib/features/home
- lib/features/statusbar
- lib/features/mount
- lib/features/settings

### Packages Preferred
Use or keep:
- flutter_riverpod
- go_router
- google_fonts
- flutter_animate

### Workflow Rule
Before big changes:
1. inspect the current repository
2. fix analyze/build issues
3. provide a short implementation plan
4. then implement in small focused steps

### Done means
- analyze issues fixed
- app shell polished
- home polished
- statusbar page polished
- mount page polished
- settings page polished
- code remains organized
- UI clearly matches the approved premium direction
