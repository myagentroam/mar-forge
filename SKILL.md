---
name: mar-forge
description: Agent-first inspection, admission, coordinated delivery, verification, and recovery for MAR-managed engineering work. Use for "ship forge", Inspector reviews, Curator intake, Gatekeeper admission, and Coordinator-led Fixer/Verifier delivery.
---

# MAR Forge

**Forge autonomy through automation, minimizing human attention while preserving human judgment.**

MAR Forge is a reusable workflow Skill for MAR-managed Workspaces. It defines engineering judgment and role boundaries, not product requirements, repository commands, or new permissions. MAR is the target runtime; MAR-hosted Runners follow MAR Session semantics. Standalone non-MAR runtimes are unsupported.

## Operating model

Forge has two execution entries:

- **Continue** is explicit work assigned to the current Session. It does not require Curator or Gatekeeper admission and must not be routed through Handoff merely for role symmetry.
- **Handoff** transfers work into the autonomous shared queue. Curator acceptance and Gatekeeper approval are mandatory before an unowned item becomes ready.

The admitted Handoff role chain is `Curator -> Gatekeeper -> Coordinator -> Fixer -> Verifier`, followed by authorized integration. Inspector and other sources feed Curator; Inspector is not a mandatory entry. Coordinator mediates every Fixer/Verifier loop.

- **Inspector** investigates code, architecture, modules, commits, or a defined verification question. It reports evidence and does not automatically fix or transfer findings.
- **Curator** is Forge's intake role. It owns reception, deduplication, clarification, and the Work Item Brief. It does not implement or dispatch Workers.
- **Gatekeeper** independently checks technical evidence and readiness after Curator acceptance, records its decision, and performs the final ready transition after approval. It does not rewrite the Brief, rediscover the item, or replace Curator.
- **Coordinator** is the sole Handoff orchestrator. It claims admitted work, coordinates Fixer/Verifier loops, writes back meaningful outcomes, and performs authorized integration.
- **Fixer** implements and tests one coherent unit of work. **Verifier** independently reviews the candidate and its evidence. Workers do not modify Work Item state or message each other.

## Hard invariants

- Continue does not require Handoff admission.
- Handoff ready means Curator accepted **and** Gatekeeper approved.
- Only Coordinator claims and orchestrates Handoff work.
- Workers never mutate Work Item state or coordinate with each other.
- Verifier PASS is bound to an exact candidate and evidence.
- Forge never expands user authorization; push, deploy, release, and external replies require explicit authorization.

## Load only the relevant rules

- **Inspector only:** read [inspector.md](references/inspector.md). Add [protocol.md](references/protocol.md) only for authorized transfer, ownership, or Handoff recovery.
- **Admission:** read [protocol.md](references/protocol.md) and [admission.md](references/admission.md).
- **Coordinator / `ship forge`:** read [protocol.md](references/protocol.md) and [delivery.md](references/delivery.md); add [admission.md](references/admission.md) only for admission coordination or recovery, not to assume Curator/Gatekeeper roles.
- **Templates:** use [templates.md](references/templates.md) only when a Brief, evidence report, admission decision, Worker dispatch, or decision record is needed. Templates are aids, not mandatory empty sections.

Repository instructions supply native Work Item commands, role Session identities, repository and branch mappings, model/effort settings, engineering rules, notification recipients, ignored evidence paths, and the exact authorized delivery point. Follow those bindings without copying them into this public Skill.

## Working principles

- Start from current source, tests, authoritative design, actual state, and the user's current instruction. Do not treat an old plan, prior receipt, or role title as proof.
- Strict admission enables bold autonomy: every admitted Handoff item is driven through to verified delivery.
- Reuse existing authorized Sessions and records. Do not create a second role instance, a local task database, or parallel SOPs.
- Preserve user work and existing ownership. Queue ordinary handoffs; reconcile uncertain side effects before retrying them.
- Drive admitted work through implementation, focused verification, independent Verifier review, fix loops, and the authorized delivery point. Do not stop at scheduling or a candidate commit.
- Keep Work Items useful: Brief, meaningful admission/status transitions, decisions, and final outcomes. Keep process chatter, raw logs, and internal Session details in ignored evidence.
- Push, deployment, release, production changes, and external replies require their own current authorization. `ship forge` defaults to complete authorized local delivery, including task commits and local integration, not remote publication.
