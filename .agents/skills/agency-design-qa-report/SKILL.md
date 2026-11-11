---
name: agency-design-qa-report
description: >
  Agency SOP for an HTML QA report of an app or site: compare real screens against
  designs when they exist, or test logically when they don't. Use when the user asks
  for a design comparison, design QA, Figma vs app, visual audit, UI test report, or
  "does the app match the design", with or without a design file. Asks about the design
  source when it is unknown. Do NOT use to design or redesign screens (agency-ui-pipeline),
  for architecture diagrams (agency-archify), or for backend-only testing.
disable-model-invocation: false
---

# Agency design QA report

Produces one self-contained HTML report a designer, PM or engineer can act on. Every
finding must be true, sourced, and owned by the right team.

## 1. Settle the design source first

| Situation | Do this |
|-----------|---------|
| Design file, link or page provided | Use it. Don't ask again. |
| Design may exist but none was given | Ask once: is there a design? Which file, page and version is the source of truth? |
| User says there is no design | Run **logical testing** (section 4). Don't invent a design to compare against. |

Also ask, only if you can't find out yourself:
- Which build, environment and test account to use.
- Which screens are in scope.

**One source of truth.** When the user names a page or version, compare against that alone
and confirm every frame really belongs to it. Ignore other pages, even newer-looking ones.
Check saved memory and the repo docs for a recorded source before asking.

**Choose frames by looking, not by name.** One page can hold several versions of a screen, old
frames parked outside its sections, and misnamed frames. Render the whole page into a labelled
contact sheet, pair each app screen with a frame by eye, and show the frame ID in the report.

## 2. Capture evidence

- Use a current build. Check `git log` since the capture date; mark anything changed since
  then "Recapture" and treat those findings as provisional.
- Use a realistic test account with complete data. An empty account creates false findings
  (no name, no points), so test with populated data before reporting a blank state.
- Note device, build and capture time. Capture the top and bottom of long screens, and
  every language the product ships in.
- Ignore debug overlays (network inspectors, leak tools) and say so in the method notes.

## 3. Compare, and verify before reporting

Check each difference in this order. Most false findings die here.

1. **Is the design image right?** Local renderers clip scaled instances, drop blurs, substitute
   fonts and can miss component overrides, which shows placeholder text and hidden layers as if
   they were real. Before reporting a design difference, and before changing code to match one,
   check the design data itself (overrides, node name, size, constraints, fills). Prefer an
   official export where available. Placeholder text in a render is a warning sign.
2. **Same state?** Compare empty with empty and loaded with loaded. If the states differ,
   the verdict is "Not comparable", not a gap.
3. **Who controls it?** Trace the value to its source (next table). Read the real API response
   before calling something Data: if the backend sends it and the app drops it, it is an App bug.
4. **Still true?** Read the current code for anything you are about to call a bug.

### Classify every finding

Keep these apart in the report. Never present a data issue as an app issue.

| Label | Meaning | Examples | Owner |
|-------|---------|----------|-------|
| **App** | Client code or assets can fix it | Layout, spacing, type, client-side crop or zoom, hardcoded copy, permissions | Client engineer |
| **Data** | Comes from the backend, CMS or config | Image files, flag URLs, survey copy, per-language content, option sets | Backend, CMS |
| **Account** | Comes from the test account | Missing name, zero points | QA: retest |
| **Blocked** | Needs an API or a feature that is off | Ordering off, no favorites API | Product, Backend |
| **Design** | The design itself is unfinished or inconsistent | Lorem ipsum, wrong button copy, missing states | Design |
| **Platform** | OS limit, can't be matched | System splash icon size, iOS-only prompts | None: note it |

Rules:
- **Dynamic content is not a finding.** If categories, products or banners come from the
  CMS, don't report that they differ from the design's sample content. Compare how they are
  presented, not what they contain.
- **Crop and zoom are App issues** when the client controls them. Fix or report them.
- Say how each finding was checked: measured, read from design data, read from code, seen
  in a capture, or tested on a device.

## 4. Logical testing (no design available)

Don't report "differs from design". Test whether the screen works and is coherent:

- **Consistency:** same component, icon, format, casing and spacing across screens.
- **States:** empty, loading, error, disabled, long text, missing data.
- **Function:** tap every control. Check back, keyboard, validation, permissions and links.
- **Text:** truncation, overlap, typos, brand name casing, date and phone formats.
- **Localization:** right-to-left mirroring, untranslated strings, number formats.
- **Accessibility:** contrast, touch target size, screen reader labels, text scaling.
- **Layout:** small and large screens, safe areas, system bars.

Label these findings by the same owner table, without a design column.

## 5. Build the report

One HTML file with images embedded as data URIs (WebP, about 620px wide), so it opens anywhere.
Start from `assets/report.css` and `assets/report.js`; swap the color tokens at the top of the
CSS for the product's brand.

In this order:
1. **Where it stands:** a two or three sentence verdict, then counts by verdict
   (Matches / Minor / Major / Not comparable, or Pass / Issue / Not tested without a design).
   State what to fix first.
2. **Fix first:** open App issues by priority, with where, owner and how checked.
3. **Data and blocked:** a separate table, clearly not app bugs.
4. **Screen by screen:** design and app side by side, with filters, enlarge and an overlay
   slider. Each finding is tagged with its label.
5. **For design:** what the design still needs.
6. **How this was checked:** source, build, account, scope, limits, and what changed since
   the previous report, including any findings withdrawn.

Report only what was run. Mark anything not retested. If a fix is uncommitted, say so.

## 6. If asked to fix findings

- Fix App items only. Hand Data, Design and Blocked items to their owners; don't hardcode
  around them, and don't invent copy, URLs or legal text.
- Work on a branch. Don't commit or push unless asked. Respect permission denials: if a path
  is refused, move the work somewhere allowed instead of writing there another way.
- Check each fix on a device, recapture, and regenerate the report from the new captures.

## 7. Deliver

Publish the report as a private Artifact when that tool is available, and keep the local file.
Remind the user that others can't open the link until it is shared.
