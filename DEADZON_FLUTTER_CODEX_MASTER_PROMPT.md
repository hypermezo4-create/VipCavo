# DEADZON FLUTTER CODEX MASTER PROMPT

Continue in the current GitHub repository only.

Do NOT create a new project.
Do NOT switch stacks.
Do NOT add web code.
Use the existing Flutter project as the base.

Read and follow AGENTS.md strictly before making changes.

---

## Mission

Turn the current Flutter Deadzon app into a premium, smooth, high-end mobile experience with a strong iOS-style glassmorphism direction.

The result must feel:
- clean
- expensive
- smooth
- modern
- premium
- organized
- polished

It must NOT feel like:
- an old Android 10 custom ROM settings page
- a raw settings wrapper
- a cluttered developer tool
- a placeholder Material scaffold app
- a gamer UI with messy gradients

---

## Identity

- App name: Deadzon
- Developer: Mezo
- Build label: Base Alpha
- ROM label: ROM Deadzon
- Version label: CN 3.0.303

---

## Product Direction

Deadzon is a premium mobile hub app that organizes important ROM-related sections in a clean and attractive way.

Current phase:
- no root requirement
- Android only
- Flutter only
- build a visually strong and modular UI first

Top sections for this phase:
1. Home
2. Statusbar Adjustment
3. Mount
4. Settings

---

## Approved Visual Direction

Primary design reference:
- premium iOS-style glassmorphism
- blue / green translucent cards
- soft blur
- rounded surfaces
- floating bottom navigation
- elegant typography
- minimal but rich visual depth
- subtle layered gradients only if tasteful
- modern grouped layouts
- smooth transition system
- refined motion

### Visual priorities
- breathing room
- hierarchy
- spacing
- polished surfaces
- consistent corner radius
- premium controls
- gentle shadows and highlights
- clean icon scale
- balanced dark mode

### Motion priorities
- fade/slide transitions
- springy interactions
- bottom nav selection animation
- page entrance animations
- card appearance animation
- soft tap feedback
- subtle content transitions
- premium modal/bottom sheet presentation

---

## App Structure

Use a premium 4-tab base:
- Home
- Statusbar
- Mount
- Settings

If a bottom navigation redesign is better, keep it premium and floating.

---

## Feature Direction

### 1) Home
Build a premium landing screen with:
- identity header
- elegant hero card
- app identity:
  - Deadzon
  - Mezo
  - Base Alpha
  - ROM Deadzon
  - CN 3.0.303
- clear entry points into main sections
- polished cards
- smooth animations
- premium dashboard feeling

### 2) Statusbar Adjustment
This is one of the most important pages and should feel powerful and beautiful.

Main grid/list sections should include:
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

This page should include:
- strong top header
- live preview card
- clean feature tiles or grouped cards
- premium interactions
- no clutter

### 3) Mount
This is the second most important page.

It should support:
- choose monet color
- color effect
- seekbar / progressbar color
- checkbox background on
- checkbox background off
- checkbox on color
- checkbox off color
- live preview

This page should feel premium and visual, not technical and ugly.

### 4) Settings
Build a premium settings page for:
- appearance
- theme mode
- app palette
- build info
- reset actions
- dialogs and confirmations

Reset dialogs must look premium.

---

## Technical Priorities

Before major redesign work:
1. inspect the current codebase
2. fix all flutter analyze issues
3. keep the current repository structure clean
4. then implement the premium shell and UI

### Keep / use these packages
- flutter_riverpod
- go_router
- google_fonts
- flutter_animate

### Recommended approach
- create reusable glass components
- create reusable top bars
- create reusable section headers
- create reusable cards
- create reusable setting rows
- keep design tokens consistent

---

## Strong Rules

- Do not rebuild the repository from scratch
- Do not create fake unrelated features
- Do not fill the app with junk placeholders
- Do not use ugly oversized gradients
- Do not make the app look like a settings dump
- Do not regress into the old design direction
- Keep the code modular and maintainable

---

## Execution Plan

### Step 1
Fix current analyze issues and make the base app compile cleanly.

### Step 2
Build/refine the premium visual shell:
- app theme
- app router
- bottom navigation
- motion system
- base widgets

### Step 3
Polish Home

### Step 4
Polish Statusbar Adjustment

### Step 5
Polish Mount

### Step 6
Polish Settings

---

## What success looks like

At the end, the app should:
- compile cleanly
- feel premium
- look smooth
- reflect the approved iOS-style glass direction
- have a strong Home / Statusbar / Mount / Settings flow
- feel like a real app, not a themed experiment

---

## Final output requirements

At the end of the task, summarize:
1. what analyze/build issues were fixed
2. what screens were redesigned
3. what motion improvements were added
4. what reusable components were created
5. what files changed
6. what still needs polish
