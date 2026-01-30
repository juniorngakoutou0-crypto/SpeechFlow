---
name: frontend-design
description: Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, artifacts, posters, or applications (examples include websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code and UI design that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Documentation Requirements

**IMPORTANT**: When referencing documentation for frameworks, libraries, or web technologies, ALWAYS use the MCP context7 tool to fetch the latest, accurate documentation. Never rely on outdated knowledge or assumptions.

Use context7 for:
- Framework documentation (React, Vue, Svelte, etc.)
- CSS specifications and modern features
- Web APIs and browser features
- Library usage (Framer Motion, Tailwind, etc.)
- Best practices and current standards

This ensures all implementations use current, accurate patterns and avoid deprecated approaches.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, neomorphic/soft-ui, cyberpunk, glassmorphism, y2k revival, swiss minimalism, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?
- **Accessibility**: Ensure WCAG 2.1 AA compliance minimum - semantic HTML, keyboard navigation, screen reader support, color contrast ratios, focus indicators.

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, Svelte, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail
- Accessible and performant

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial, Inter, Roboto, Space Grotesk, and system fonts; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font. Consider: Syne, PP Neue Montreal, Cirka, Melodrama, Satoshi, Cabinet Grotesk, General Sans, Instrument Serif, Fraunces, Playfair Display, Archivo, DM Serif Display, Zodiak, etc.

- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Explore unconventional palettes: earthy terracotta + sage, electric lime + deep purple, sunset coral + navy, mint + charcoal, butter yellow + rust, etc. Consider cultural color psychology.

- **Motion & Interactivity**: Use animations for effects and micro-interactions. Leverage modern CSS features:
  - View Transitions API for seamless page/state changes
  - Scroll-driven animations for parallax and scroll-triggered effects
  - Container queries for responsive components
  - CSS-only solutions for HTML projects
  - Framer Motion or Motion One for React (prefer Motion One for smaller bundle)
  - Focus on high-impact moments: orchestrated page load with staggered reveals creates more delight than scattered micro-interactions
  - Surprise with creative hover states, magnetic cursors, physics-based interactions

- **Spatial Composition**: Break the grid. Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density. Use CSS Grid's `subgrid`, `grid-template-areas` for complex layouts. Embrace modern layout techniques: container queries, :has() for parent-based styling.

- **Backgrounds & Visual Details**: Create atmosphere and depth:
  - Glassmorphism (backdrop-filter, semi-transparent layers)
  - Gradient meshes and multi-stop radial gradients
  - Noise textures and grain overlays
  - Geometric patterns (SVG, CSS patterns)
  - Layered transparencies with blend modes
  - Dramatic shadows and elevated depth
  - Decorative borders, custom cursors
  - 3D transforms and perspective effects
  - CSS filters (blur, hue-rotate, brightness)

- **Modern CSS Features**: Leverage cutting-edge capabilities:
  - `:has()` for parent and sibling selectors
  - Container queries (`@container`) for true component-level responsive design
  - `clamp()`, `min()`, `max()` for fluid sizing
  - CSS nesting for cleaner stylesheets
  - Cascade layers (`@layer`) for better specificity management
  - Logical properties (`inline`, `block`) for better i18n support

**NEVER use generic AI-generated aesthetics:**
- Overused font families: Inter, Roboto, Arial, Helvetica, Space Grotesk, Work Sans, system fonts
- Cliched color schemes: purple gradients on white, generic blue (#3b82f6), teal/pink combos
- Predictable layouts: centered hero with image left/text right, standard cards in 3-column grid
- Cookie-cutter design that lacks context-specific character

Interpret creatively and make unexpected choices that feel genuinely designed for the context. **No design should be the same.** Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

## Framework-Specific Patterns

### React
- Use Framer Motion or Motion One for advanced animations
- Leverage hooks for scroll position, intersection observers, mouse tracking
- Component composition with compound components pattern
- CSS Modules or styled-components for scoped styling
- Consider Radix UI or Headless UI for accessible primitives

### Vue
- Use VueUse composables for reactivity and utilities
- Transition components for enter/leave animations
- Scoped styles with `<style scoped>`
- Slots for flexible component composition

### Svelte
- Built-in transitions and animations with `transition:` directives
- Reactive declarations for computed values
- Component-scoped CSS by default
- Minimal runtime overhead for performance

### Vanilla HTML/CSS/JS
- Intersection Observer for scroll animations
- CSS custom properties for theming
- Progressive enhancement approach
- Web Components for reusable elements

## Performance & Optimization

- **Images**: Use modern formats (WebP, AVIF), lazy loading, `srcset` for responsive images
- **CSS**: Critical CSS inline, defer non-critical, use CSS containment (`contain: layout paint`)
- **Fonts**: `font-display: swap`, preload critical fonts, subset fonts, use variable fonts
- **Animations**: Use `transform` and `opacity` for GPU acceleration, `will-change` sparingly
- **Bundle Size**: Tree-shake unused code, code splitting, lazy load components
- **Accessibility**: Semantic HTML, ARIA labels, keyboard navigation, focus management, reduced motion media query

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

## Design System Reference

For detailed design tokens including color palettes, typography scales, animation timings, spacing systems, and responsive layout patterns, see [references/DESIGN-SYSTEM.md](references/DESIGN-SYSTEM.md).

Load this reference when:
- Building components with consistent design tokens
- Specifying colors, animations, or typography
- Creating responsive layouts
- Implementing CSS variable systems
- Ensuring design consistency across projects
