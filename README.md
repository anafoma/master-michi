# Stormwake

An evidence-based gym coach plugin for Claude, inspired by Jeff Nippard's science-based approach to hypertrophy and strength. Your coach is **Vis**, an old fisherman who runs your intake, designs programmes, reads your Hevy logs to plan progression, swaps exercises and covers nutrition basics.

> Stormwake is an independent personal project. It is not affiliated with or endorsed by Jeff Nippard, Hevy or any other service it can work with.

## What's inside

| Part | Purpose |
| --- | --- |
| `skills/vis` | Coach persona, core principles, routing to the other skills |
| `skills/intake` | Nine-question intake → confirmed training card |
| `skills/programme-design` | Split, weekly sets per muscle, exercise picks, Hevy routines |
| `skills/specialisation` | Prioritise lagging muscles for a block |
| `skills/progression` | Double progression, stall detection, deloads from Hevy history |
| `skills/exercise-swaps` | Like-for-like replacements; rate any exercise |
| `skills/nutrition` | Protein, bulking and cutting rates, supplements |
| `agents/vis.md` | Multi-step coaching agent |
| `knowledge/` | Single source of truth for the knowledge base (paraphrased, with links; no transcripts or book text) |
| `tools/vis_calc.py` | Deterministic calculator (sets, pace and budget, macros, estimated 1RM, evidence window), copied into each skill's `scripts/` by the sync script |
| `evals/scenarios.json` | Test prompts with expected behaviour |

## Requirements

- **Hevy connector** in your Claude account. Each person connects their own Hevy account. Free accounts work, with limits on routines and custom exercises (see `knowledge/hevy.md`, "Account limits").
- **Nutrition tracker** (optional, recommended): any nutrition connector you already use. If you have none, Vis can point you to one, and otherwise gives targets in chat.
- **Wearable** (optional): any watch or ring with a Claude connector, for sleep, HRV and resting heart rate. See `knowledge/connections.md`.

## What Stormwake does with your data

Stormwake itself has no server, no account and no analytics, and it does not send your data anywhere.

- **What it reads:** the workouts, routines and exercise history in your Hevy account, and, if you connect them, your nutrition-tracker and wearable data. It reads only the data of the person in the current conversation.
- **What it writes:** routines in your Hevy account (only after you confirm, unless you asked for exactly that change) and, if a nutrition tracker is connected, your targets and the meals you ask it to log.
- **What it runs:** `vis_calc.py`, a short Python script that does the coaching arithmetic locally. It makes no network requests and uses only Python's standard library.
- **What it stores:** nothing of its own. Your training card lives in your conversation and in the services you connect.
- **Connected services** are separate products with their own privacy policies, and they handle the data you share with them.

## Who it's for and what it isn't

Stormwake is a general fitness tool for adults. It is not medical advice and does not diagnose anything. For users under 18, or anyone who mentions pain, a medical condition, medication, pregnancy or disordered eating, it drops numeric diet targets and points to a doctor or other professional (see `knowledge/intake.md`).

## Editing the knowledge

1. Edit the files in `knowledge/` (they open cleanly as an Obsidian vault).
2. Run `./scripts/sync-knowledge.sh` to copy them into each skill's `references/` and the calculator into each skill's `scripts/`.
3. Rerun the evals, bump the version in `.claude-plugin/plugin.json`, then rebuild.

## Build and install

```bash
./scripts/sync-knowledge.sh
./scripts/build.sh          # writes dist/stormwake.plugin
```

Upload `dist/stormwake.plugin` in Claude's plugin settings, or add this repository as a plugin marketplace in Claude Code.

## Calculator tests

```bash
python3 -m unittest discover -s tests -v
```

Edit only `tools/vis_calc.py`, then run `./scripts/sync-knowledge.sh`; a test fails if a skill's copy is stale. CI runs both on every push.

## Running evals

Open a fresh chat with the plugin installed, paste each scenario's `prompt`, and check every line in `expect`. Note failures, fix the skill or knowledge file, and rerun.

## License

MIT. See `LICENSE`.
