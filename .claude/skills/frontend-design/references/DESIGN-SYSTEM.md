# Design System - Frontend Design Skill

## Table of Contents
1. [Color Palette](#color-palette)
2. [Typography](#typography)
3. [Animations & Motion](#animations--motion)
4. [Layout Patterns](#layout-patterns)
5. [Component Spacing](#component-spacing)
6. [Modern CSS Features](#modern-css-features)
7. [Advanced Visual Effects](#advanced-visual-effects)
8. [Accessibility Guidelines](#accessibility-guidelines)
9. [Performance Optimization](#performance-optimization)

---

## Color Palette

**IMPORTANT**: The palettes below are examples for reference. Always choose colors that match your specific aesthetic direction. Avoid using these generic palettes verbatim - create custom, contextual color schemes.

### Palette 1: Sunset & Earth (Warm, Organic)

```css
:root {
  /* Primary - Terracotta */
  --color-primary-50: #fef5f1;
  --color-primary-100: #fde8df;
  --color-primary-200: #fcd0be;
  --color-primary-300: #f9ad91;
  --color-primary-400: #f58563;
  --color-primary-500: #e86a47;
  --color-primary-600: #d4512f;
  --color-primary-700: #b03d26;
  --color-primary-800: #913426;
  --color-primary-900: #782e24;

  /* Accent Colors */
  --color-accent-sage: #8b9a8d;
  --color-accent-mustard: #d4a854;
  --color-accent-rust: #a64b2a;
  --color-accent-cream: #f5ebe0;

  /* Neutral - Warm Gray */
  --color-neutral-950: #1c1614;
  --color-neutral-900: #332b24;
  --color-neutral-800: #4a3f35;
  --color-neutral-700: #6b5d51;
  --color-neutral-600: #8a7a6d;
  --color-neutral-500: #a59788;
  --color-neutral-400: #c4b8ae;
  --color-neutral-300: #d9d1c8;
  --color-neutral-200: #eae5df;
  --color-neutral-100: #f5f1ed;
  --color-neutral-50: #faf8f5;
}
```

### Palette 2: Cyberpunk Neon (Electric, Dark)

```css
:root {
  /* Primary - Electric Purple */
  --color-primary-50: #f5f3ff;
  --color-primary-100: #ede9fe;
  --color-primary-200: #ddd6fe;
  --color-primary-300: #c4b5fd;
  --color-primary-400: #a78bfa;
  --color-primary-500: #8b5cf6;
  --color-primary-600: #7c3aed;
  --color-primary-700: #6d28d9;
  --color-primary-800: #5b21b6;
  --color-primary-900: #4c1d95;

  /* Accent Colors */
  --color-accent-cyan: #00fff9;
  --color-accent-magenta: #ff00ff;
  --color-accent-lime: #ccff00;
  --color-accent-orange: #ff6e00;

  /* Neutral - Cool Dark */
  --color-neutral-950: #0a0a0f;
  --color-neutral-900: #13131a;
  --color-neutral-800: #1f1f29;
  --color-neutral-700: #2d2d3d;
  --color-neutral-600: #3d3d52;
  --color-neutral-500: #52526b;
  --color-neutral-400: #7a7a94;
  --color-neutral-300: #a3a3bd;
  --color-neutral-200: #c7c7d6;
  --color-neutral-100: #e3e3eb;
  --color-neutral-50: #f5f5f8;
}
```

### Palette 3: Mint & Charcoal (Fresh, Modern)

```css
:root {
  /* Primary - Mint */
  --color-primary-50: #f0fdf9;
  --color-primary-100: #ccfbee;
  --color-primary-200: #99f6e0;
  --color-primary-300: #5feaca;
  --color-primary-400: #2dd4ae;
  --color-primary-500: #14b895;
  --color-primary-600: #0d9579;
  --color-primary-700: #107763;
  --color-primary-800: #115e50;
  --color-primary-900: #134e43;

  /* Accent Colors */
  --color-accent-coral: #ff6b6b;
  --color-accent-gold: #ffd93d;
  --color-accent-lavender: #b8b8ff;
  --color-accent-peach: #ffb4a2;

  /* Neutral - Charcoal */
  --color-neutral-950: #0f1419;
  --color-neutral-900: #1a2128;
  --color-neutral-800: #252e38;
  --color-neutral-700: #3a4452;
  --color-neutral-600: #525e6e;
  --color-neutral-500: #6e7a8a;
  --color-neutral-400: #97a1ad;
  --color-neutral-300: #bdc4cc;
  --color-neutral-200: #d9dfe4;
  --color-neutral-100: #eef1f4;
  --color-neutral-50: #f8f9fa;
}
```

### Palette 4: Butter & Dusk (Soft, Elegant)

```css
:root {
  /* Primary - Butter Yellow */
  --color-primary-50: #fffef0;
  --color-primary-100: #fffac2;
  --color-primary-200: #fff488;
  --color-primary-300: #ffe749;
  --color-primary-400: #ffd520;
  --color-primary-500: #f5bb06;
  --color-primary-600: #d99102;
  --color-primary-700: #b36805;
  --color-primary-800: #91500c;
  --color-primary-900: #77410d;

  /* Accent Colors */
  --color-accent-dusk: #5d5379;
  --color-accent-rose: #e8a0bf;
  --color-accent-teal: #4a9b9b;
  --color-accent-sand: #d4c4a8;

  /* Neutral - Warm Slate */
  --color-neutral-950: #1a1716;
  --color-neutral-900: #2e2925;
  --color-neutral-800: #433d36;
  --color-neutral-700: #5c544a;
  --color-neutral-600: #786f63;
  --color-neutral-500: #958b7d;
  --color-neutral-400: #b4aca1;
  --color-neutral-300: #cfc9c1;
  --color-neutral-200: #e5e1db;
  --color-neutral-100: #f3f1ed;
  --color-neutral-50: #faf9f7;
}
```

### Palette 5: Ocean Depth (Deep, Mysterious)

```css
:root {
  /* Primary - Deep Ocean Blue */
  --color-primary-50: #f0f9ff;
  --color-primary-100: #e0f2fe;
  --color-primary-200: #bae6fd;
  --color-primary-300: #7dd3fc;
  --color-primary-400: #38bdf8;
  --color-primary-500: #0ea5e9;
  --color-primary-600: #0284c7;
  --color-primary-700: #0369a1;
  --color-primary-800: #075985;
  --color-primary-900: #0c4a6e;

  /* Accent Colors */
  --color-accent-seafoam: #5ee7ca;
  --color-accent-sunset: #ff8c42;
  --color-accent-plum: #9b59b6;
  --color-accent-pearl: #ecf0f1;

  /* Neutral - Cool Gray */
  --color-neutral-950: #0c1318;
  --color-neutral-900: #15202b;
  --color-neutral-800: #1e2d3d;
  --color-neutral-700: #2d4152;
  --color-neutral-600: #475663;
  --color-neutral-500: #657180;
  --color-neutral-400: #8d98a5;
  --color-neutral-300: #b4bcc6;
  --color-neutral-200: #d4dae0;
  --color-neutral-100: #eaeef1;
  --color-neutral-50: #f7f9fa;
}
```

### Creating Custom Palettes

Use these tools for inspiration:
- **Coolors.co**: Generate harmonious color schemes
- **Adobe Color**: Create palettes from images or color theory
- **Paletton**: Advanced color scheme designer
- **Realtime Colors**: Visualize palettes on UI components
- **Huemint**: AI-powered palette generation for UIs

**Best Practices:**
- Start with 1-2 primary colors that define your brand/aesthetic
- Add 2-3 accent colors for variety and emphasis
- Include a full neutral scale (50-950) for text, backgrounds, borders
- Ensure WCAG AA contrast ratios (4.5:1 for normal text, 3:1 for large text)
- Test palettes in light AND dark modes
- Use semantic naming for clarity (`--color-success`, `--color-danger`)

---

## Typography

**CRITICAL**: Avoid overused fonts like Inter, Roboto, Space Grotesk, Work Sans, Arial. Choose distinctive fonts that match your aesthetic vision.

### Font Pairing Examples

#### Pairing 1: Editorial & Refined
```css
@import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700;900&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Source+Serif+4:wght@300;400;500;600&display=swap');

--font-display: 'Playfair Display', Georgia, serif; /* Elegant, editorial */
--font-body: 'Source Serif 4', Georgia, serif; /* Readable, refined */
```

#### Pairing 2: Modern & Geometric
```css
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;700&display=swap');

--font-display: 'Syne', sans-serif; /* Bold, geometric, modern */
--font-body: 'DM Sans', sans-serif; /* Clean, versatile */
```

#### Pairing 3: Brutalist & Raw
```css
@import url('https://fonts.googleapis.com/css2?family=Archivo+Black&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Archivo:wght@300;400;500;600&display=swap');

--font-display: 'Archivo Black', sans-serif; /* Heavy, impactful */
--font-body: 'Archivo', sans-serif; /* Neutral, readable */
```

#### Pairing 4: Playful & Friendly
```css
@import url('https://fonts.googleapis.com/css2?family=Fredoka:wght@400;500;600;700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700&display=swap');

--font-display: 'Fredoka', sans-serif; /* Rounded, friendly */
--font-body: 'Nunito', sans-serif; /* Soft, approachable */
```

#### Pairing 5: Technical & Monospace
```css
@import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;500;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Manrope:wght@300;400;500;600;700&display=swap');

--font-display: 'JetBrains Mono', monospace; /* Technical, distinct */
--font-body: 'Manrope', sans-serif; /* Balanced, modern */
```

### More Distinctive Font Options

**Display Fonts:**
- Melodrama (dramatic, high-contrast)
- Cabinet Grotesk (geometric, refined)
- Satoshi (modern, versatile)
- Fraunces (soft serif with character)
- DM Serif Display (elegant, high-contrast)
- Instrument Serif (editorial, distinctive)
- Zodiak (bold, geometric serif)
- Gochi Hand (handwritten, playful)

**Body Fonts:**
- General Sans (geometric, readable)
- Plus Jakarta Sans (friendly, modern)
- Outfit (rounded, contemporary)
- Epilogue (elegant, versatile)
- Red Hat Display (technical, clean)
- Lexend (optimized for readability)
- Chivo (strong, legible)

**Finding Fonts:**
- Google Fonts (free, large selection)
- Adobe Fonts (premium, included with Creative Cloud)
- Fontshare (free, high-quality)
- Font Squirrel (free for commercial use)
- Future Fonts (experimental, indie)

### Type Scale

```css
:root {
  /* Headings */
  --fs-h1: clamp(2rem, 5vw, 3.5rem);    /* 32px - 56px */
  --fs-h2: clamp(1.75rem, 4vw, 2.75rem); /* 28px - 44px */
  --fs-h3: clamp(1.5rem, 3vw, 2.25rem);  /* 24px - 36px */
  --fs-h4: 1.5rem;                        /* 24px */
  --fs-h5: 1.25rem;                       /* 20px */
  --fs-h6: 1rem;                          /* 16px */

  /* Body Text */
  --fs-body-lg: 1.125rem;  /* 18px */
  --fs-body: 1rem;         /* 16px */
  --fs-body-sm: 0.875rem;  /* 14px */
  --fs-body-xs: 0.75rem;   /* 12px */

  /* Line Heights */
  --lh-tight: 1.2;
  --lh-normal: 1.5;
  --lh-relaxed: 1.75;

  /* Font Weights */
  --fw-light: 300;
  --fw-normal: 400;
  --fw-medium: 500;
  --fw-semibold: 600;
  --fw-bold: 700;
}
```

### Usage Patterns

```css
h1 {
  font-family: var(--font-display);
  font-size: var(--fs-h1);
  font-weight: var(--fw-bold);
  line-height: var(--lh-tight);
  letter-spacing: -0.02em;
}

body {
  font-family: var(--font-body);
  font-size: var(--fs-body);
  line-height: var(--lh-normal);
  color: var(--color-text-primary);
}
```

---

## Animations & Motion

### Easing Functions

```css
:root {
  /* Easing curves */
  --ease-smooth: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-spring: cubic-bezier(0.34, 1.56, 0.64, 1);
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
}
```

### Timing Variables

```css
:root {
  --duration-instant: 0.1s;
  --duration-fast: 0.2s;
  --duration-normal: 0.3s;
  --duration-slow: 0.5s;
  --duration-veryslow: 0.8s;
}
```

### Core Animations

#### Fade In
```css
@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.fade-in {
  animation: fadeIn var(--duration-normal) var(--ease-smooth);
}
```

#### Slide Up
```css
@keyframes slideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.slide-up {
  animation: slideUp var(--duration-normal) var(--ease-smooth);
}
```

#### Slide In (Left/Right)
```css
@keyframes slideInLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}
```

#### Scale Pop
```css
@keyframes scalePop {
  from {
    opacity: 0;
    transform: scale(0.95);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.scale-pop {
  animation: scalePop var(--duration-fast) var(--ease-spring);
}
```

#### Pulse
```css
@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.pulse {
  animation: pulse var(--duration-slow) var(--ease-smooth) infinite;
}
```

#### Shimmer (Loading)
```css
@keyframes shimmer {
  0% {
    background-position: -1000px 0;
  }
  100% {
    background-position: 1000px 0;
  }
}

.shimmer {
  background: linear-gradient(
    90deg,
    var(--color-neutral-300) 0%,
    var(--color-neutral-200) 50%,
    var(--color-neutral-300) 100%
  );
  background-size: 1000px 100%;
  animation: shimmer var(--duration-veryslow) linear infinite;
}
```

### Hover & Interactive States

```css
:root {
  --transition-base: all var(--duration-normal) var(--ease-smooth);
}

/* Button Hover */
.btn {
  transition: var(--transition-base);
}

.btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

.btn:active {
  transform: translateY(0);
}

/* Link Underline Reveal */
a {
  position: relative;
  transition: color var(--duration-normal) var(--ease-smooth);
}

a::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  width: 0;
  height: 2px;
  background: currentColor;
  transition: width var(--duration-normal) var(--ease-smooth);
}

a:hover::after {
  width: 100%;
}
```

### Page Load Sequence

```css
/* Staggered animations */
.item {
  animation: slideUp var(--duration-normal) var(--ease-smooth);
}

.item:nth-child(1) { animation-delay: 0.1s; }
.item:nth-child(2) { animation-delay: 0.2s; }
.item:nth-child(3) { animation-delay: 0.3s; }
.item:nth-child(n+4) { animation-delay: calc(0.1s * var(--item-index, 4)); }
```

---

## Layout Patterns

### Spacing Scale

```css
:root {
  --space-xs: 0.25rem;   /* 4px */
  --space-sm: 0.5rem;    /* 8px */
  --space-md: 1rem;      /* 16px */
  --space-lg: 1.5rem;    /* 24px */
  --space-xl: 2rem;      /* 32px */
  --space-2xl: 3rem;     /* 48px */
  --space-3xl: 4rem;     /* 64px */
  --space-4xl: 6rem;     /* 96px */
}
```

### Container Widths

```css
:root {
  --container-sm: 640px;
  --container-md: 768px;
  --container-lg: 1024px;
  --container-xl: 1280px;
  --container-2xl: 1536px;
  --max-width: 1400px;
}

.container {
  width: 100%;
  max-width: var(--max-width);
  margin-inline: auto;
  padding-inline: var(--space-lg);
}

@media (max-width: 768px) {
  .container {
    padding-inline: var(--space-md);
  }
}
```

### Grid Layouts

#### 12-Column Grid
```css
.grid-12 {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: var(--space-lg);
}

.col-1 { grid-column: span 1; }
.col-2 { grid-column: span 2; }
.col-3 { grid-column: span 3; }
.col-4 { grid-column: span 4; }
.col-6 { grid-column: span 6; }
.col-full { grid-column: 1 / -1; }

@media (max-width: 768px) {
  .grid-12 { grid-template-columns: repeat(6, 1fr); }
  .col-6 { grid-column: span 6; }
  .col-4 { grid-column: span 4; }
}

@media (max-width: 480px) {
  .grid-12 { grid-template-columns: 1fr; }
  .col-4, .col-6 { grid-column: 1 / -1; }
}
```

#### Flexbox Patterns
```css
/* Hero Section */
.hero {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-2xl);
  min-height: 100vh;
}

@media (max-width: 768px) {
  .hero {
    flex-direction: column;
    justify-content: center;
  }
}

/* Card Grid */
.card-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: var(--space-xl);
}
```

### Asymmetric Layouts

```css
/* Z-Pattern (hero + content) */
.section-hero {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: center;
  gap: var(--space-2xl);
}

.section-hero:nth-child(even) {
  direction: rtl; /* Reverse order */
}

.section-hero > * {
  direction: ltr; /* Reset text direction */
}

/* Overlap Effect */
.overlap-container {
  position: relative;
  padding-bottom: var(--space-4xl);
}

.overlap-child {
  position: absolute;
  bottom: 0;
  transform: translateY(50%);
}
```

---

## Component Spacing

### Buttons

```css
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-md) var(--space-lg);
  border-radius: 0.5rem;
  font-weight: var(--fw-semibold);
  font-size: var(--fs-body);
  transition: var(--transition-base);
  border: none;
  cursor: pointer;
}

.btn-lg {
  padding: var(--space-lg) var(--space-2xl);
  font-size: var(--fs-body-lg);
}

.btn-sm {
  padding: var(--space-sm) var(--space-md);
  font-size: var(--fs-body-sm);
}

.btn-primary {
  background: var(--color-primary-600);
  color: white;
}

.btn-primary:hover {
  background: var(--color-primary-700);
}
```

### Cards

```css
.card {
  background: var(--color-bg-primary);
  border: 1px solid var(--color-border-light);
  border-radius: 0.75rem;
  padding: var(--space-lg);
  transition: var(--transition-base);
}

.card:hover {
  border-color: var(--color-primary-600);
  box-shadow: 0 10px 30px rgba(61, 59, 255, 0.1);
}
```

### Forms

```css
.form-group {
  margin-bottom: var(--space-xl);
}

label {
  display: block;
  margin-bottom: var(--space-sm);
  font-weight: var(--fw-medium);
  color: var(--color-text-primary);
}

input, textarea, select {
  width: 100%;
  padding: var(--space-md);
  border: 1px solid var(--color-border-light);
  border-radius: 0.5rem;
  font-size: var(--fs-body);
  font-family: var(--font-body);
  transition: var(--transition-base);
}

input:focus, textarea:focus, select:focus {
  outline: none;
  border-color: var(--color-primary-600);
  box-shadow: 0 0 0 3px rgba(61, 59, 255, 0.1);
}
```

---

## Responsive Breakpoints

```css
:root {
  --bp-xs: 320px;
  --bp-sm: 480px;
  --bp-md: 768px;
  --bp-lg: 1024px;
  --bp-xl: 1280px;
  --bp-2xl: 1536px;
}

/* Mobile First Approach */
@media (min-width: 768px) { /* Tablet */ }
@media (min-width: 1024px) { /* Desktop */ }
@media (min-width: 1280px) { /* Large Desktop */ }
```

---

## Shadow System

```css
:root {
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  --shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
}
```

---

## Modern CSS Features

### Container Queries

Enable component-level responsive design:

```css
.card-container {
  container-type: inline-size;
  container-name: card;
}

@container card (min-width: 400px) {
  .card-title {
    font-size: 2rem;
  }

  .card-content {
    display: grid;
    grid-template-columns: 1fr 1fr;
  }
}

/* Multiple breakpoints */
@container (min-width: 300px) {
  .card { padding: var(--space-md); }
}

@container (min-width: 500px) {
  .card { padding: var(--space-xl); }
}
```

### :has() Parent Selector

Style parents based on children:

```css
/* Card with image gets different layout */
.card:has(img) {
  display: grid;
  grid-template-columns: 200px 1fr;
}

/* Form with error shows red border */
.form-group:has(.error) {
  border-color: var(--color-error);
}

/* Navigation with active link */
.nav:has(.nav-link.active) {
  background: var(--color-primary-50);
}

/* Highlight parent on child focus */
.input-wrapper:has(input:focus) {
  box-shadow: 0 0 0 3px var(--color-primary-200);
}
```

### CSS Nesting

Cleaner, more maintainable styles:

```css
.button {
  padding: var(--space-md) var(--space-lg);
  background: var(--color-primary-600);
  color: white;

  &:hover {
    background: var(--color-primary-700);
    transform: translateY(-2px);
  }

  &:active {
    transform: translateY(0);
  }

  &.button--large {
    padding: var(--space-lg) var(--space-2xl);
    font-size: var(--fs-body-lg);
  }

  & .icon {
    margin-right: var(--space-sm);
  }
}
```

### Cascade Layers

Better specificity management:

```css
@layer reset, base, components, utilities;

@layer reset {
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
}

@layer base {
  body {
    font-family: var(--font-body);
    color: var(--color-text-primary);
  }
}

@layer components {
  .button {
    /* Component styles */
  }
}

@layer utilities {
  .mt-4 { margin-top: var(--space-lg); }
}
```

### Logical Properties

Better internationalization support:

```css
/* Instead of left/right, use inline-start/inline-end */
.card {
  padding-inline: var(--space-lg); /* left and right */
  padding-block: var(--space-xl);  /* top and bottom */
  margin-inline-start: auto;       /* margin-left in LTR, margin-right in RTL */
  border-inline-end: 2px solid;    /* border-right in LTR */
}

/* Size properties */
.container {
  inline-size: 100%;     /* width */
  block-size: 100vh;     /* height */
  max-inline-size: 1200px;
}
```

### View Transitions API

Smooth page/state transitions:

```css
/* Enable view transitions */
@view-transition {
  navigation: auto;
}

/* Customize transition */
::view-transition-old(root),
::view-transition-new(root) {
  animation-duration: 0.3s;
}

/* Specific element transitions */
.card {
  view-transition-name: card-transition;
}

::view-transition-old(card-transition) {
  animation: slideOut 0.3s ease-out;
}

::view-transition-new(card-transition) {
  animation: slideIn 0.3s ease-out;
}
```

### Scroll-Driven Animations

```css
/* Animate on scroll */
@keyframes reveal {
  from {
    opacity: 0;
    transform: translateY(50px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.reveal-on-scroll {
  animation: reveal linear;
  animation-timeline: view();
  animation-range: entry 0% cover 30%;
}

/* Parallax effect */
.parallax {
  animation: parallax linear;
  animation-timeline: scroll();
}

@keyframes parallax {
  to {
    transform: translateY(calc(var(--scroll-position) * -0.5px));
  }
}
```

---

## Advanced Visual Effects

### Glassmorphism

```css
.glass {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px) saturate(180%);
  -webkit-backdrop-filter: blur(10px) saturate(180%);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 1rem;
  box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.1);
}

/* Dark mode glass */
.glass-dark {
  background: rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}
```

### Gradient Meshes

```css
.gradient-mesh {
  background:
    radial-gradient(at 20% 30%, #ff00ff 0%, transparent 50%),
    radial-gradient(at 80% 70%, #00ffff 0%, transparent 50%),
    radial-gradient(at 50% 50%, #ffff00 0%, transparent 50%),
    linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  background-size: 100% 100%;
  background-position: 0% 0%;
}

/* Animated gradient mesh */
@keyframes meshMove {
  0%, 100% { background-position: 0% 0%, 100% 100%, 50% 50%, 0% 0%; }
  50% { background-position: 100% 100%, 0% 0%, 80% 20%, 100% 100%; }
}

.animated-mesh {
  animation: meshMove 10s ease-in-out infinite;
}
```

### Noise & Grain Textures

```css
/* CSS-only grain (lightweight) */
.grain {
  position: relative;
  overflow: hidden;
}

.grain::before {
  content: '';
  position: absolute;
  inset: 0;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='4' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
  opacity: 0.05;
  pointer-events: none;
  mix-blend-mode: overlay;
}
```

### 3D Transforms & Perspective

```css
.card-3d {
  perspective: 1000px;
}

.card-3d-inner {
  transform-style: preserve-3d;
  transition: transform 0.6s;
}

.card-3d:hover .card-3d-inner {
  transform: rotateY(180deg);
}

/* Tilt effect on hover */
.tilt-card {
  transition: transform 0.3s ease;
}

.tilt-card:hover {
  transform: perspective(1000px) rotateX(5deg) rotateY(5deg) scale(1.02);
}
```

### Blend Modes & Filters

```css
.creative-blend {
  mix-blend-mode: difference; /* or multiply, screen, overlay, color-dodge */
}

/* Duotone effect */
.duotone {
  filter:
    grayscale(100%)
    contrast(1.2)
    brightness(1.1)
    sepia(100%)
    hue-rotate(180deg);
}

/* Glow effect */
.glow {
  filter: drop-shadow(0 0 20px rgba(255, 0, 255, 0.8));
}

/* Frosted glass */
.frosted {
  backdrop-filter: blur(20px) brightness(1.1);
  background: rgba(255, 255, 255, 0.05);
}
```

### Custom Cursors

```css
.creative-cursor {
  cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32"><circle cx="16" cy="16" r="10" fill="%23ff00ff"/></svg>') 16 16, auto;
}

/* Magnetic cursor effect (requires JS) */
.magnetic {
  transition: transform 0.2s ease;
}

/* Hide default cursor on interactive areas */
.custom-cursor-area {
  cursor: none;
}
```

### Neumorphism (Soft UI)

```css
.neomorphic {
  background: #e0e5ec;
  border-radius: 1rem;
  box-shadow:
    12px 12px 24px #b8b9be,
    -12px -12px 24px #ffffff;
}

.neomorphic-inset {
  background: #e0e5ec;
  border-radius: 1rem;
  box-shadow:
    inset 8px 8px 16px #b8b9be,
    inset -8px -8px 16px #ffffff;
}
```

### Animated Backgrounds

```css
@keyframes gradientShift {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

.animated-gradient {
  background: linear-gradient(
    -45deg,
    #ee7752,
    #e73c7e,
    #23a6d5,
    #23d5ab
  );
  background-size: 400% 400%;
  animation: gradientShift 15s ease infinite;
}
```

---

## Accessibility Guidelines

### WCAG 2.1 AA Compliance

#### Color Contrast

```css
/* Minimum contrast ratios */
/* Normal text (< 18pt): 4.5:1 */
/* Large text (>= 18pt or 14pt bold): 3:1 */
/* UI components and graphics: 3:1 */

/* Check contrast */
:root {
  /* Good: Dark text on light bg */
  --text-on-light: #1a1a1a; /* 16.1:1 ratio */

  /* Good: Light text on dark bg */
  --text-on-dark: #ffffff; /* 21:1 ratio */

  /* Bad: Low contrast */
  --text-low-contrast: #999999; /* 2.8:1 - fails AA */
}
```

#### Semantic HTML

```html
<!-- Use semantic elements -->
<header>
  <nav>
    <ul>
      <li><a href="/">Home</a></li>
    </ul>
  </nav>
</header>

<main>
  <article>
    <h1>Article Title</h1>
    <section>
      <h2>Section Heading</h2>
      <p>Content...</p>
    </section>
  </article>
</main>

<footer>
  <p>&copy; 2026 Company</p>
</footer>
```

#### Keyboard Navigation

```css
/* Clear focus indicators */
:focus-visible {
  outline: 3px solid var(--color-primary-500);
  outline-offset: 2px;
  border-radius: 0.25rem;
}

/* Remove outline for mouse users, keep for keyboard */
:focus:not(:focus-visible) {
  outline: none;
}

/* Skip to main content */
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: var(--color-primary-600);
  color: white;
  padding: var(--space-sm) var(--space-md);
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}
```

#### ARIA Labels

```html
<!-- Descriptive labels for screen readers -->
<button aria-label="Close menu">
  <span aria-hidden="true">&times;</span>
</button>

<!-- Live regions for dynamic content -->
<div role="status" aria-live="polite" aria-atomic="true">
  Form submitted successfully
</div>

<!-- Hidden text for context -->
<a href="/learn-more">
  Learn more
  <span class="sr-only">about our services</span>
</a>
```

#### Screen Reader Only Class

```css
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border-width: 0;
}
```

#### Reduced Motion

```css
/* Respect user preferences */
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}

/* Alternative: subtle animations for reduced motion */
@media (prefers-reduced-motion: reduce) {
  .fancy-animation {
    animation: none;
    opacity: 1; /* Show final state */
  }
}
```

#### Form Accessibility

```html
<!-- Proper labels and error messages -->
<div class="form-group">
  <label for="email">Email Address</label>
  <input
    type="email"
    id="email"
    name="email"
    aria-describedby="email-help email-error"
    aria-invalid="false"
    required
  />
  <small id="email-help">We'll never share your email.</small>
  <span id="email-error" class="error" role="alert"></span>
</div>
```

---

## Performance Optimization

### Critical CSS

```html
<!-- Inline critical CSS in <head> -->
<style>
  /* Above-the-fold styles */
  body { margin: 0; font-family: system-ui; }
  .hero { min-height: 100vh; }
</style>

<!-- Load full CSS asynchronously -->
<link rel="preload" href="styles.css" as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript><link rel="stylesheet" href="styles.css"></noscript>
```

### Font Loading

```css
/* Optimize font loading */
@font-face {
  font-family: 'CustomFont';
  src: url('/fonts/custom.woff2') format('woff2');
  font-display: swap; /* Show fallback, then swap */
  font-weight: 400;
  unicode-range: U+0000-00FF; /* Latin subset */
}

/* Preload critical fonts */
/* <link rel="preload" href="/fonts/custom.woff2" as="font" type="font/woff2" crossorigin> */
```

### Image Optimization

```html
<!-- Responsive images with modern formats -->
<picture>
  <source srcset="image.avif" type="image/avif" />
  <source srcset="image.webp" type="image/webp" />
  <img
    src="image.jpg"
    alt="Description"
    loading="lazy"
    decoding="async"
    width="800"
    height="600"
  />
</picture>

<!-- Responsive with srcset -->
<img
  srcset="
    small.jpg 400w,
    medium.jpg 800w,
    large.jpg 1200w
  "
  sizes="(max-width: 600px) 400px, (max-width: 900px) 800px, 1200px"
  src="medium.jpg"
  alt="Description"
  loading="lazy"
/>
```

### CSS Containment

```css
/* Limit layout recalculation scope */
.card {
  contain: layout style paint;
}

.isolated-component {
  contain: strict; /* layout + style + paint + size */
}

/* Content visibility for off-screen elements */
.lazy-section {
  content-visibility: auto;
  contain-intrinsic-size: 0 500px; /* Estimated height */
}
```

### GPU Acceleration

```css
/* Use transform and opacity for animations (GPU-accelerated) */
.smooth-animation {
  transform: translateZ(0); /* Force GPU layer */
  will-change: transform, opacity; /* Hint to browser */
}

/* Remove will-change after animation */
.smooth-animation.idle {
  will-change: auto;
}

/* Avoid animating expensive properties */
/* ❌ BAD */
.bad-animation {
  animation: badMove 1s;
}

@keyframes badMove {
  to { margin-left: 100px; } /* Triggers layout */
}

/* ✅ GOOD */
.good-animation {
  animation: goodMove 1s;
}

@keyframes goodMove {
  to { transform: translateX(100px); } /* GPU-accelerated */
}
```

### Bundle Optimization

```javascript
// Code splitting (React example)
import { lazy, Suspense } from 'react';

const HeavyComponent = lazy(() => import('./HeavyComponent'));

function App() {
  return (
    <Suspense fallback={<div>Loading...</div>}>
      <HeavyComponent />
    </Suspense>
  );
}

// Tree-shaking: import only what you need
import { specific } from 'library'; // ✅ Good
import * as library from 'library';  // ❌ Bundles everything
```

---

## Usage in SKILL.md

Reference this design system in the main SKILL.md when:
- Specifying color requirements for a component
- Defining animation timing and easing
- Setting up typography hierarchy
- Creating consistent spacing between elements
- Building responsive layouts
- Implementing modern CSS features
- Adding visual effects and creative styling
- Ensuring accessibility compliance
- Optimizing performance

Load this file when the user requests specific design tokens or wants to maintain consistency across components.
