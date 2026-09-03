# zzb — Brand Image Prompts

15 image-generation prompts for the `zzb` repo, README, and landing page. Written
as direction to a human artist (or a top-tier image model), described in Photoshop
**layers**, with the **feeling** we're after and an **ideal shape** for each. A
downstream checker reshapes/crops any generated image to the target aspect ratio
below, so compose the *hero element inside a centered safe zone* and let the
background bleed to the edges.

---

## The brand — read this first (applies to ALL 15)

**Who we're for.** Developers, platform engineers, and security-minded builders.
Smart, busy, allergic to hype and to cliché "cyber-security" stock art. They value
*clarity, control, and trust*. Every image should feel like it was made by someone
who respects them.

**The one feeling.** *Quiet confidence — clarity emerging out of complexity.* Not
fear, not "hackers in hoodies," not sterile enterprise. A calm, luminous sense of
*"I can see exactly who can do what, and I trust it."* Think the emotional register
of a beautifully lit architectural photograph or an award-winning data-visualization
— restraint, depth, one perfect focal point.

**Core visual motif.** A **relationship graph**: glowing nodes joined by fine,
deliberate edges — the ReBAC idea made visible. A *single luminous path* threading
through a dense field is our signature move (clarity out of complexity). Objects,
people, and permissions as nodes; access as light travelling an edge.

**Palette (keep it consistent).**
- Base / background: near-black deep indigo `#0B0E1A` → `#0D1117` (kin to a dark
  terminal), with soft navy falloff.
- Primary accent (our hero color — "allow," signal, clarity): electric teal-cyan
  `#2DE1C2`.
- Secondary accent (warmth, energy, human): amber-gold `#F5B841`.
- Alert, used *sparingly* only where meaning demands (deny / risk): restrained
  coral `#FF5C7A` — never dominant.
- Neutrals: cool graphite grays, soft off-white `#E6EAF2` for any light element.

**Rendering & light.** Dark scene, one key light in the teal accent, a soft warm
rim light, gentle bloom on the brightest connections, real depth-of-field. Allowed
styles across the set (pick per prompt, stay tonally identical): clean 3D isometric
render, cinematic macro photography, and tasteful abstract data-art. Fine geometric
line-work and a barely-there dot-grid tie everything together.

**Typography (only when text appears).** Modern geometric grotesque or a crisp
monospace. Prefer *no* text in images unless specified — models render text poorly
and the checker can't fix gibberish.

**Always avoid:** padlocks on circuit boards, green "Matrix" rain, hooded figures,
corporate handshakes, literal shields-with-checkmarks, glowing brains, cluttered
fake UI, lens flares as decoration, watermarks, and any garbled letterforms.

**Shape legend** (target the checker enforces): `2:1` 1280×640 · `16:9` 1920×1080 ·
`21:9` 2560×1080 · `1:1` 1024×1024 · `4:5` 1080×1350 · `3:2` 1620×1080 ·
`16:10` 1920×1200.

---

## 1 — Repo social preview (og:image)
**Use:** GitHub repo card, link unfurls. **Shape:** `2:1` (1280×640). Keep the mark
in the centered safe zone; graph bleeds off all four edges.

> A cinematic dark hero card, deep indigo-to-black background (`#0B0E1A`).
> **Layer 1 (background):** a vast, softly out-of-focus field of faint graph nodes
> and edges receding into darkness, like a city seen from orbit at night — cool,
> quiet, immense. **Layer 2 (mid):** from the depth, one luminous teal-cyan
> (`#2DE1C2`) path snakes forward and resolves into sharp focus, its nodes glowing,
> a single amber (`#F5B841`) node pulsing warm where the path arrives. **Layer 3
> (foreground / focal):** centered negative space holding the lowercase wordmark
> "zzb" in a clean geometric sans, soft off-white, with a whisper of teal glow
> underneath — as if lit by the graph itself. **Lighting:** one teal key light from
> the path, warm rim on the amber node, gentle bloom, shallow depth of field.
> **Grade:** rich blacks, no gray haze. **Feeling:** you're looking at order pulled
> out of an enormous tangle — calm mastery. Minimal, premium, confident. No other
> text, no UI, no clutter.

## 2 — Landing hero (wide)
**Use:** top of the landing page, text overlaid to one side. **Shape:** `16:9`
(1920×1080). Compose the subject on the **right third**; leave the left third calm
for headline text.

> A wide, atmospheric scene. **Layer 1:** deep indigo gradient sky-scape, a soft
> horizon of blurred nodes like distant lights. **Layer 2:** on the right, a
> three-dimensional, semi-transparent lattice of glowing nodes and edges — an
> authorization graph rendered like elegant architecture, teal edges carrying tiny
> travelling motes of light. **Layer 3:** a few edges resolve into crisp focus; one
> amber node stands out as "the answer." **Layer 4 (foreground):** faint dot-grid
> and a subtle vignette framing the left negative space for text. **Lighting:**
> teal key, warm amber accent, cinematic bloom, believable depth. **Feeling:**
> standing calmly in front of something powerful and *legible* — you're in control
> of it, not intimidated by it. Award-winning data-art energy, spacious, premium.

## 3 — Logo mark / avatar
**Use:** GitHub org avatar, favicon, social profile. **Shape:** `1:1`
(1024×1024). Single centered glyph, generous padding, works small.

> A minimal, iconic monogram for "zzb" built from the graph motif: three glowing
> nodes connected by two clean edges that also *read* as the letters z-z-b — a
> node-and-edge glyph, not a typeface. **Layer 1:** flat near-black indigo field.
> **Layer 2:** the glyph in electric teal (`#2DE1C2`) with a single amber node as
> the accent, crisp geometric line-work, subtle inner glow. **Layer 3:** faint
> concentric ring or dot-grid halo for depth, very restrained. **Lighting:** even,
> emblem-like, tiny bloom on the nodes. **Feeling:** trustworthy, modern, instantly
> recognizable at 32px. Think a beautifully reductive tech mark — Stripe-level
> restraint. Perfectly centered, symmetrical enough to feel stable. No text.

## 4 — The money question (check → allow / deny)
**Use:** "instant answers" section. **Shape:** `16:9` (1920×1080). Single decisive
focal point, centered.

> A single, dramatic moment of decision. **Layer 1:** dark indigo void with a faint
> graph texture. **Layer 2:** a clean, minimal *gate* or threshold made of light —
> one luminous teal archway (ALLOW) rendered crisply, and far to the side, dimmed
> and small, a coral (`#FF5C7A`) closed gate (DENY) — teal dominant, coral a whisper.
> **Layer 3:** a single mote of light — a request — passing cleanly through the teal
> gate, motion-blurred, purposeful. **Lighting:** hard teal key on the open gate,
> soft falloff everywhere else, elegant bloom. **Feeling:** *decisive, fast,
> certain* — the satisfying click of a correct yes/no. Not binary-cold; warm at the
> edges. Editorial, minimal, one hero element. No text, no literal checkmarks.

## 5 — Who can access this? (list-users)
**Use:** "know exactly who" section. **Shape:** `4:5` (1080×1350), portrait.
Subject centered, room top and bottom.

> A spotlight of understanding. **Layer 1:** dark scene, dense faint graph. **Layer
> 2:** a single bright object-node at center (a glowing document/resource abstracted
> as a luminous shard). **Layer 3:** from it, teal edges fan outward and connect to a
> small constellation of *person-nodes* — softly humanized dots, each haloed — the
> exact set of people who can reach it; everyone else fades to near-invisible in the
> dark. **Layer 4:** a gentle volumetric light beam picking out the connected few.
> **Lighting:** teal key from the object, warm rims on the people. **Feeling:**
> revelation and relief — *"oh, THESE are the people, and only these."* Intimate,
> clear, reassuring. Beautiful, not clinical. No faces, no text.

## 6 — Audit: catch the dangerous mistake
**Use:** "audit / lint your model" section. **Shape:** `3:2` (1620×1080). Focal
crack slightly right of center.

> A guardian scan across a permission graph. **Layer 1:** a broad, orderly teal
> graph filling the frame, calm and healthy. **Layer 2:** a soft horizontal *scan
> line* of light sweeping across it (like a document scanner), leaving crisp focus
> in its wake. **Layer 3:** where the scan passes one region, it exposes a hairline
> **coral fracture** — a single edge glowing red-pink where access leaks somewhere
> it shouldn't — small but unmistakable, the one flaw found in the order. **Layer 4:**
> faint measurement ticks / reticle framing to imply inspection, very subtle.
> **Lighting:** teal ambient, a concentrated coral glow at the flaw. **Feeling:**
> vigilance rewarded — *the tool caught the thing you'd have missed.* Precise,
> protective, quietly heroic. Not alarming; controlled. No text, no literal magnifier.

## 7 — Access review / certification
**Use:** "run reviews without a spreadsheet" section. **Shape:** `4:5` (1080×1350).

> A calm ledger of trust. **Layer 1:** dark indigo, soft graph bokeh. **Layer 2:** a
> floating, elegant vertical column of glowing rows — each row a person-node joined
> by a teal edge to a small "why" glyph (a path, a badge) — abstract, not a UI, more
> like an illuminated manuscript of access. **Layer 3:** most rows glow steady teal;
> one or two carry a faint amber flag ("review me") — attention, not alarm. **Layer
> 4:** a soft hand-of-light or gentle checkmark-of-photons certifying a row (implied,
> not literal). **Lighting:** warm key, teal fill, museum-quiet. **Feeling:**
> composure and stewardship — *compliance season is under control.* Dignified,
> orderly, humane. No readable text (abstract glyphs only).

## 8 — What-if diff (preview before you apply)
**Use:** "see the blast radius" section. **Shape:** `16:9` (1920×1080). Fork
centered, before/after left/right.

> A fork in time. **Layer 1:** dark scene with a graph flowing left-to-right.
> **Layer 2:** the graph splits at a glowing pivot node into two ghosted futures:
> the **left/back** version faint and neutral (before), the **right/front** version
> crisp (after). **Layer 3:** on the "after" branch, a few nodes bloom teal (GAINED
> access) and one dims to coral-gray (LOST access) — the delta made visible as light
> vs. shadow. **Layer 4:** a translucent overlay seam down the middle where the two
> states register, like onion-skin animation frames. **Lighting:** teal on gains,
> cool shadow on losses, soft central glow at the pivot. **Feeling:** foresight and
> safety — *you can see what will change before it changes.* Thoughtful, cinematic,
> reassuring. No text.

## 9 — Templates / init (zero to a working model)
**Use:** "one command to a real model" section. **Shape:** `1:1` (1024×1024).

> Creation from a blueprint. **Layer 1:** dark indigo work-surface with a faint
> engineer's dot-grid. **Layer 2:** a flat teal *blueprint* — thin schematic lines of
> an org/permission structure. **Layer 3:** the blueprint lifting and unfolding
> upward into a real three-dimensional glowing lattice — nodes rising, edges
> connecting, an amber "seed" node at the base powering the growth — the moment a
> plan becomes a living structure. **Layer 4:** tiny motes of light streaming along
> the newly formed edges (it's alive and running). **Lighting:** teal key, amber
> uplight from the seed, gentle bloom. **Feeling:** momentum and delight — *from
> nothing to something real, instantly.* Optimistic, generative, clean. No text.

## 10 — Time-bound / break-glass grant (--expires)
**Use:** "grants that clean up after themselves" section. **Shape:** `3:2`
(1620×1080).

> Access that knows when to end. **Layer 1:** dark scene, single spotlit subject.
> **Layer 2:** a luminous *key made of light* shaped subtly like an edge/connection,
> its far end already dissolving into fine teal particles that drift away — temporary
> made visible. **Layer 3:** a faint hourglass or arc of falling light-grains behind
> it, implying a countdown, elegant not literal. **Layer 4:** the node it unlocked
> glows warm amber, calm, momentary. **Lighting:** teal key, warm accent on the node,
> particles catching light as they fade. **Feeling:** trust and tidiness — *the door
> opens exactly as long as it should, then closes itself.* Graceful, precise,
> slightly poetic. No clocks with numbers, no text.

## 11 — The graph (the ReBAC idea) — abstract banner
**Use:** wide section divider / GitHub profile banner. **Shape:** `21:9`
(2560×1080), ultra-wide. Even composition, safe to crop either side.

> A constellation of relationships. **Layer 1:** deep space-indigo gradient, subtle
> falloff. **Layer 2:** an expansive, elegant field of nodes and edges spanning the
> full width — like a star map of who-relates-to-what — density varied, breathing
> room preserved. **Layer 3:** a few teal "hero" paths and one amber node draw the
> eye and give the field a center of gravity. **Layer 4:** faint dot-grid and a very
> soft depth blur at the extreme edges so any crop looks intentional. **Lighting:**
> cool ambient, selective teal glow, one warm point. **Feeling:** vastness made
> navigable — *complexity you can actually read.* Meditative, premium, infinite.
> Pure abstract data-art, no objects, no text.

## 12 — Terminal, beautifully lit
**Use:** "it's a joy to use" / developer-credibility shot. **Shape:** `16:10`
(1920×1200).

> A love letter to the command line. **Layer 1:** a dark desk scene, moody, shallow
> depth of field, warm ambient room light off-frame. **Layer 2:** a floating,
> frameless dark terminal panel (`#0D1117`) glowing softly, showing crisp,
> *plausible but non-literal* teal-and-white monospace output — an `allow` result and
> a small graph sketch — kept abstract enough that letterforms read as texture, not
> sentences. **Layer 3:** a faint reflection of a teal graph on the desk surface, as
> if the screen's content spills into the world. **Layer 4:** dust motes in the key
> light, a warm amber bokeh highlight. **Lighting:** screen as key light (teal),
> warm rim from the room. **Feeling:** craftsmanship and calm focus — *the quiet
> pleasure of a tool that just works.* Cinematic, tactile, aspirational. Avoid any
> full readable sentences.

## 13 — Playground / explore
**Use:** "poke around first" playground section. **Shape:** `16:9` (1920×1080).

> An org you can hold in your hands. **Layer 1:** dark studio void. **Layer 2:** a
> glowing tabletop *diorama* — a small organization rendered as a luminous
> model-village of nodes: teams, people, resources, edges of light between them,
> like an architect's illuminated maquette. **Layer 3:** a soft beam of light (the
> user's attention) resting on one node, its connected edges brightening in response
> — interactive, alive. **Layer 4:** faint floating labels as abstract glyphs, gentle
> particles. **Lighting:** teal key from within the model, warm rim, playful bloom.
> **Feeling:** curiosity and safety — *a sandbox where you can explore consequences
> without fear.* Inviting, wondrous, hands-on. No readable text.

## 14 — Trust / security (reimagined)
**Use:** SECURITY / trust section, footer. **Shape:** `1:1` (1024×1024).

> Security as warmth, not a cold vault. **Layer 1:** dark indigo field. **Layer 2:**
> a single elegant lock-form *made entirely of a closed relationship loop* — teal
> edges curving into a shackle, the keyhole an amber node — the lock IS the graph,
> not metal-on-circuitry. **Layer 3:** a soft protective aura, concentric faint
> rings, a sense of something valued being kept safe. **Layer 4:** the faintest human
> warmth — an amber glow suggesting trust rather than a fortress. **Lighting:** teal
> key, warm center, gentle bloom, no harsh edges. **Feeling:** *safe, cared-for,
> confident* — trust you can feel, not fear. Modern, humane, iconic. No literal
> padlock textures, no circuit boards, no text.

## 15 — Team / org hierarchy (living structure)
**Use:** "teams, orgs, inheritance" section. **Shape:** `4:5` (1080×1350),
portrait.

> Structure that breathes. **Layer 1:** dark scene, soft graph bokeh behind.
> **Layer 2:** a vertical, organic *branching tree of light* — an org hierarchy where
> an org-node at the base splits into teams, teams into people — rendered like a
> luminous bonsai of nodes and edges, balanced and calm. **Layer 3:** access
> *inheritance* shown as light flowing downward from parent to child nodes along the
> teal edges — permission cascading gracefully. **Layer 4:** one amber node lit at a
> leaf, showing an individual gaining access through the structure. **Lighting:**
> teal key, warm amber leaf-glow, upward soft light. **Feeling:** natural order —
> *the shape of a team made visible and fair.* Elegant, living, harmonious. No text,
> no org-chart boxes.

---

## Notes for the reshaper / checker
- Each prompt names one **target aspect ratio**; the hero element sits in a centered
  (or thirds-placed, where noted) safe zone, backgrounds bleed — so a center or
  content-aware crop to the target ratio never cuts the subject.
- Keep every image tonally identical (palette + dark-scene + one teal key light) so
  the 15 read as **one brand** on the repo and landing page.
- Prefer no text baked into images; add wordmarks/headlines in HTML/CSS overlay
  where the layout leaves negative space (prompts 1, 2, 11, 12 reserve it).
