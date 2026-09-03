# zzb — Brand Image Prompts (v2 · cute cartoon)

Same 15 images, re-imagined in a **cute cartoon** style — think *Japanese kawaii
meets American corporate product-launch key art*: friendly, rounded, flat simple
colors, minimal detail, lots of clean whitespace, polished and confident like a
Notion / Slack / Duolingo launch illustration. Written as direction to a human
artist, in Photoshop **layers**, with the **feeling** and an **ideal shape** for
each. A downstream checker reshapes/crops to the target aspect ratio, so keep the
hero (usually our mascot) in a centered safe zone and let the flat background bleed
to the edges.

> v1 (cinematic / dark data-art) lives in `IMAGE_PROMPTS.md`. This v2 is the cute,
> approachable line. Pick one line per surface — don't mix them in the same view.

---

## The brand — read this first (applies to ALL 15)

**Who we're for.** Developers and platform/security engineers — smart and busy, but
they still smile at a well-made mascot. This line makes authorization feel
*friendly and human* without feeling childish or unserious. Cute, but clean and
premium — a product you'd trust *and* enjoy.

**The one feeling.** *Warm, calm confidence with a little joy.* "This is going to be
easy, and I'm in good hands." Approachable, tidy, optimistic. The emotional register
of a beloved product's launch-day hero image.

**The mascot — "Zee."** A single recurring character ties the set together: a
**rounded, glowing little node-orb** named Zee — a soft teal circle with two simple
dot eyes and a tiny gentle smile, no nose, no limbs by default (sprout small
rounded arms only when a scene needs an action). Zee often holds or is connected by
**"light-edges"** — friendly glowing strings/threads that represent relationships.
Other nodes are the same simple orb shape in amber or navy, some with dot-faces.
Keep Zee's proportions consistent: big round body, tiny features, chibi-cute.

**Style rules (keep it consistent).**
- **Flat cartoon.** Solid fills, soft rounded shapes, no gradients except one very
  soft background wash. Optional clean 2–3px rounded outline in deep navy, used
  consistently (either all images have outlines or none do — default: subtle
  outlines).
- **Minimal detail.** Simplify everything. One soft drop shadow per object max.
  Cheeks: a tiny flat blush oval on Zee when it fits. No textures, no gritty noise,
  no realistic lighting.
- **Generous whitespace.** Corporate-clean composition, one clear hero, calm layout.

**Palette (simple, ~4 colors + background).**
- Background: warm off-white / cream `#FAF7F0` (default), or a soft mint `#E8F7F3`
  or pale sky `#EAF2FB` for variety — always light and airy.
- Primary (Zee, "yes," signal): friendly teal `#2DD4BF`.
- Warm accent (energy, highlights, a second happy node): amber `#FBBF24`.
- Gentle alert (deny / a fixable oops), used *sparingly* and never scary: soft coral
  `#FB7185`.
- Ink (outlines, dot-eyes, any text): deep navy `#1E293B`.

**Typography (only when text appears).** A rounded, friendly geometric sans
(bouba, not kiki). Prefer *no* text baked in — models render it poorly; add
headlines in HTML/CSS overlay instead.

**Always avoid:** photorealism, dark/gritty scenes, gradients-heavy 3D, scary
security clichés (padlocks, hooded figures, red alarms), busy detail, cluttered fake
UI, sharp edgy shapes, and any garbled letterforms. Keep it cute, simple, and clean.

**Shape legend** (target the checker enforces): `2:1` 1280×640 · `16:9` 1920×1080 ·
`21:9` 2560×1080 · `1:1` 1024×1024 · `4:5` 1080×1350 · `3:2` 1620×1080 ·
`16:10` 1920×1200.

---

## 1 — Repo social preview (og:image)
**Use:** GitHub repo card. **Shape:** `2:1` (1280×640). Mascot centered, props bleed
off the edges.

> A cheerful product-launch card on a warm cream background (`#FAF7F0`). **Layer 1
> (background):** a big soft off-white field with a couple of pale, oversized rounded
> "confetti" dots (teal + amber) drifting at the corners, very minimal. **Layer 2
> (mid):** three simple orb-nodes joined by friendly glowing teal light-edges,
> arranged in a gentle arc. **Layer 3 (hero):** Zee — a round teal node with two dot
> eyes, a tiny smile, and small blush cheeks — centered, holding one light-edge like
> a little balloon string, looking proud and welcoming. **Layer 4 (foreground):** a
> clean flat drop shadow beneath each node, and calm negative space for a wordmark.
> **Colors:** flat teal/amber/navy on cream, no gradients. **Feeling:** "welcome —
> this is going to be friendly." Polished, adorable, corporate-clean. No text.

## 2 — Landing hero (wide)
**Use:** landing page top, headline overlaid left. **Shape:** `16:9` (1920×1080).
Mascot + scene on the **right third**; leave left third empty for the headline.

> A bright, airy launch scene. **Layer 1:** soft pale-mint (`#E8F7F3`) background,
> mostly empty on the left. **Layer 2 (right):** a tidy little cartoon "graph
> village" — 5–6 rounded orb-nodes in teal/amber/navy connected by clean glowing
> light-edges, laid out like a friendly constellation, simple and uncluttered.
> **Layer 3:** Zee stands (small rounded arms) beside the graph, one arm raised in a
> cheerful little wave, presenting it. **Layer 4:** flat soft shadows, one or two
> pale floating dots for life. **Feeling:** calm, optimistic, "come on in." Clean
> corporate composition with a kawaii heart. Simple flat colors, big whitespace,
> no text on the left.

## 3 — Logo mark / mascot avatar
**Use:** org avatar, favicon, profile. **Shape:** `1:1` (1024×1024). Single centered
mascot, generous padding, must read at 32px.

> Zee as a clean app-icon mascot. **Layer 1:** flat rounded-square background in soft
> teal-tinted cream (or a subtle teal). **Layer 2:** Zee centered — a perfectly round
> teal orb, two navy dot eyes, a tiny smile, small blush — with a single little
> light-edge curling beside it ending in one amber mini-node (its friend). **Layer 3:**
> one soft flat drop shadow. **Colors:** 3 flats max. **Feeling:** instantly likeable,
> trustworthy, memorable at any size — a mascot you'd put on a sticker. Symmetrical,
> balanced, ultra-simple. No text.

## 4 — The money question (check → allow / deny)
**Use:** "instant answers." **Shape:** `16:9` (1920×1080). Centered, one clear beat.

> A gentle yes/no moment. **Layer 1:** cream background. **Layer 2:** a simple, cute
> rounded **gate/doorway** in teal, wide open and glowing softly (ALLOW); far to one
> side, small and dimmed, a closed coral gate with a tiny "zzz"/sleepy look (DENY) —
> never scary, teal dominant. **Layer 3:** Zee cheerfully walking through the open
> teal gate, tiny arms mid-step, a small sparkle of approval above it. **Layer 4:**
> flat shadows, one amber sparkle. **Feeling:** "easy yes." Reassuring, satisfying,
> friendly. Simple flats, minimal detail. No checkmarks, no text.

## 5 — Who can access this? (list-users)
**Use:** "know exactly who." **Shape:** `4:5` (1080×1350), portrait.

> A friendly little roll-call. **Layer 1:** pale sky background. **Layer 2:** one
> bright object-node in the center — a cute rounded "document" orb with a tiny face.
> **Layer 3:** light-edges reach out to a small, tidy group of 3–4 person-nodes
> (rounded orbs with simple dot-faces, one amber), each connected and smiling;
> everyone else is simply absent (clean, not hidden-in-shadow). **Layer 4:** Zee to
> the side pointing helpfully at the group, flat shadows. **Feeling:** clarity and
> reassurance — "these few, and that's it." Warm, tidy, simple. No text.

## 6 — Audit: catch the little oopsie
**Use:** "audit / lint your model." **Shape:** `3:2` (1620×1080). Focal find slightly
right of center.

> A helpful check-up, not an alarm. **Layer 1:** cream background. **Layer 2:** a neat
> little row/cluster of happy teal nodes, all connected tidily. **Layer 3:** Zee in a
> cute "inspector" pose (holding a simple round magnifier prop) spots one node whose
> light-edge droops the wrong way in soft coral — a tiny fixable oops, the node
> looking a little sheepish (small sweat-drop). **Layer 4:** a gentle amber "!" bubble
> above the oops, flat shadows. **Feeling:** "found it — no big deal, let's fix it."
> Protective but friendly, calm, simple flats. No scary red, no text.

## 7 — Access review / certification
**Use:** "reviews without a spreadsheet." **Shape:** `4:5` (1080×1350).

> A tidy little approval line. **Layer 1:** soft mint background. **Layer 2:** a neat
> vertical stack of 3–4 rounded person-nodes, each linked by a light-edge to a small
> "why" tag (a tiny badge shape). **Layer 3:** Zee gently placing a cute round "OK"
> stamp/sticker (teal) next to each approved one; one row wears a small amber flag
> ("take a look") — attention, not alarm. **Layer 4:** flat shadows, one sparkle.
> **Feeling:** calm stewardship — "all handled." Orderly, warm, simple. Abstract tags
> only, no readable text.

## 8 — What-if diff (preview before you apply)
**Use:** "see the blast radius." **Shape:** `16:9` (1920×1080). Fork centered.

> A friendly peek at two futures. **Layer 1:** cream background. **Layer 2:** a simple
> path of light-edges splits at a glowing pivot node into two little branches: the
> left branch faint/ghosted (before), the right crisp (after). **Layer 3:** on the
> "after" branch, one node pops happily teal (GAINED, tiny sparkle) and one gives a
> gentle coral "bye!" wave as it fades (LOST) — cute, not sad. **Layer 4:** Zee in the
> middle peeking at the two branches with curious dot-eyes, flat shadows. **Feeling:**
> foresight made fun — "I can see what'll happen first." Playful, safe, simple flats.
> No text.

## 9 — Templates / init (zero to a working model)
**Use:** "one command to a real model." **Shape:** `1:1` (1024×1024).

> Instant build, cutely. **Layer 1:** soft cream background. **Layer 2:** a simple flat
> teal "blueprint card" on the ground. **Layer 3:** it pops up into a tiny, tidy 3-node
> structure of orb-nodes and light-edges — like a little pop-up book unfolding — with
> an amber "seed" node glowing at the base. **Layer 4:** Zee doing a happy tiny jump
> beside it with a sparkle, flat shadows. **Feeling:** delight and momentum — "from
> nothing to something, instantly!" Optimistic, generative, super clean. No text.

## 10 — Time-bound / break-glass grant (--expires)
**Use:** "grants that clean up after themselves." **Shape:** `3:2` (1620×1080).

> A key that tidies itself. **Layer 1:** pale sky background. **Layer 2:** Zee holds a
> cute rounded **key made of light** (shaped like a little edge), handing it to a
> small amber door-node that lights up happily. **Layer 3:** the far end of the key
> gently dissolves into a few soft teal sparkle-dots (temporary!), with a tiny cute
> hourglass floating nearby. **Layer 4:** flat shadows, a soft sparkle trail.
> **Feeling:** trust and tidiness — "opens just long enough, then poofs away."
> Gentle, charming, simple flats. No numbers, no text.

## 11 — The graph (the ReBAC idea) — cute banner
**Use:** wide section divider / profile banner. **Shape:** `21:9` (2560×1080),
ultra-wide. Even, safe to crop either side.

> A happy little network across the width. **Layer 1:** warm cream background.
> **Layer 2:** a tidy horizontal spread of simple orb-nodes (teal/amber/navy, a few
> with tiny dot-faces) joined by clean glowing light-edges — evenly spaced, breezy,
> not crowded. **Layer 3:** Zee sits cheerfully near the center as the friendly hub,
> a couple of edges glowing a touch brighter around it. **Layer 4:** a few pale
> floating confetti-dots, flat shadows, calm edges so any crop feels intentional.
> **Feeling:** "a network you'd actually enjoy looking at." Light, friendly, minimal.
> No text.

## 12 — Terminal, but adorable
**Use:** "it's a joy to use" / dev credibility. **Shape:** `16:10` (1920×1200).

> The command line, made cute. **Layer 1:** soft cream background. **Layer 2:** a big
> rounded, friendly "terminal card" with a pale teal-tinted screen, rounded corners,
> three little window dots — clean and toy-like, NOT dark or gritty. **Layer 3:** on
> the screen, a simple cartoon "allow" result and a tiny 3-node graph doodle in flat
> teal (abstract shapes, no real sentences). **Layer 4:** Zee popping up from behind
> the terminal's top edge, peeking over with a happy smile and tiny arms resting on
> the frame. **Layer 5:** one soft flat shadow, an amber sparkle. **Feeling:** "this
> tool is friendly and fun." Approachable, polished, simple. Avoid readable text.

## 13 — Playground / explore
**Use:** playground section. **Shape:** `16:9` (1920×1080).

> A little sandbox to play in. **Layer 1:** soft mint background. **Layer 2:** a cute
> rounded "tabletop" holding a tiny toy-town of orb-nodes and light-edges — a small
> org rendered like friendly building blocks. **Layer 3:** Zee gently boops one node
> with a tiny arm; its connected edges light up teal in response (interactive!).
> **Layer 4:** a couple of floating sparkle-dots, flat shadows. **Feeling:** curiosity
> and safety — "poke around, nothing breaks." Playful, inviting, simple flats. No text.

## 14 — Trust / security (warm, not scary)
**Use:** SECURITY / trust section, footer. **Shape:** `1:1` (1024×1024).

> Safety as a hug, not a vault. **Layer 1:** soft cream (or gentle teal) background.
> **Layer 2:** a cute rounded lock-shape made entirely of a **closed loop of
> light-edge** — teal curve as the shackle, a small amber node as the keyhole — the
> lock IS the friendly graph, soft and huggable. **Layer 3:** Zee gives the little
> lock a gentle hug (tiny arms wrapped around it), content and safe, eyes closed
> smiling. **Layer 4:** a soft flat aura ring, one drop shadow. **Feeling:** "your
> stuff is safe and cared for." Warm, humane, reassuring. No metal, no circuits, no
> text.

## 15 — Team / org hierarchy (cute tree)
**Use:** "teams, orgs, inheritance." **Shape:** `4:5` (1080×1350), portrait.

> A friendly family tree of nodes. **Layer 1:** pale sky background. **Layer 2:** a
> simple vertical **tree of orb-nodes**: one navy org-node at the base, branching by
> light-edges up into a couple of teal team-nodes, then into small amber person-nodes
> — balanced and tidy, like a cute mobile. **Layer 3:** soft glowing light flows
> gently downward along the edges (inheritance), a tiny sparkle where it reaches a
> leaf person-node. **Layer 4:** Zee perched happily at the top like a little topper,
> flat shadows. **Feeling:** natural order, fair and friendly — "this is how the team
> fits together." Elegant, simple, warm. No org-chart boxes, no text.

---

## Notes for the reshaper / checker
- Each prompt names one **target aspect ratio**; keep Zee/the hero in a centered (or
  thirds-placed, where noted) safe zone with the flat background bleeding to the
  edges, so a center or content-aware crop never clips the mascot.
- Lock the look across all 15: **flat cartoon, ~4 simple colors on a light
  background, minimal detail, one mascot (Zee), consistent outline choice** — so the
  set reads as one cute brand.
- Prefer no baked-in text; add wordmarks/headlines in HTML/CSS overlay where the
  layout reserves whitespace (prompts 1, 2, 11, 12).
```
