---
name: mar-forge
description: Opt-in MAR Forge autonomous Handoff protocol. Load only when the user explicitly invokes Forge (for example "ship forge"), the current repository or Workspace explicitly declares MAR Forge enabled, or an existing Forge workflow/role is being resumed. Do not load for ordinary code review, implementation, bug fixing, testing, planning, or delivery in projects that do not explicitly use MAR Forge.
---

# MAR Forge

## Applicability

MAR Forge is opt-in, not MAR's default development behavior. Use this Skill only when at least one is true:

- The user explicitly invokes Forge, such as `ship forge`, `use mar-forge`, or `send this through Forge`.
- The current repository or Workspace explicitly states in natural language that it uses MAR Forge for the relevant workflow.
- The current task belongs to an existing Forge workflow, Forge-tracked Work Item, recovery state, or Forge role Session, including an explicitly configured Forge Inspector Session.

Otherwise, stop using this Skill and do not load its references. Do not apply Forge roles, admission gates, Work Item semantics, Handoff rules, or delivery rules; follow the repository's ordinary instructions. No negative declaration is required—absence of opt-in already means Forge is not applicable.

**Forge autonomy through automation, minimizing human attention while preserving human judgment.**

For MAR-managed Workspaces, Forge defines workflow judgment and role boundaries—not product requirements, repository commands, or new permissions. MAR-hosted Runners follow MAR Session semantics; standalone non-MAR runtimes are unsupported.

## Hard invariants

- Handoff ready means Curator accepted **and** Gatekeeper approved.
- Only Coordinator claims and orchestrates Handoff; Workers never mutate Work Item state or coordinate with each other.
- Verifier PASS is bound to an exact candidate and evidence.
- Forge never expands user authorization; push, deploy, release, and external replies require explicit authorization.

## Scope

Forge's delivery workflow governs autonomous Handoff. Explicitly configured Inspector Sessions may review independently and supply evidence without entering Handoff. Other explicit current-Session work remains Continue under host development rules and outside Forge; do not apply admission or delegation for symmetry.

The admitted chain is `Curator -> Gatekeeper -> Coordinator -> Fixer -> Verifier`, then authorized integration. Inspector and other sources feed Curator but are not mandatory; Coordinator mediates every Fixer/Verifier loop.

## Load only the relevant rules

- **Inspector only:** read [inspector.md](references/inspector.md). Add [protocol.md](references/protocol.md) only for authorized transfer, ownership, or Handoff recovery.
- **Admission:** read [protocol.md](references/protocol.md) and [admission.md](references/admission.md).
- **Fresh `ship forge`:** read [protocol.md](references/protocol.md) and [admission.md](references/admission.md); after ready, add [delivery.md](references/delivery.md).
- **Coordinator on admitted work:** read [protocol.md](references/protocol.md) and [delivery.md](references/delivery.md); add [admission.md](references/admission.md) only for a claimed Brief change or admission recovery, not to assume Curator/Gatekeeper roles.
- **Templates:** use [templates.md](references/templates.md) only when a Brief, evidence report, admission decision, Worker dispatch, or decision record is needed. Templates are aids, not mandatory empty sections.

Host instructions bind Work Items, Sessions, repositories, models, engineering rules, notifications, evidence paths, and the delivery point. Follow these bindings without copying them into this Skill.

## Working principles

- Start from current source, tests, authoritative design, actual state, and the user's current instruction. Do not treat an old plan, prior receipt, or role title as proof.
- Reuse authorized Sessions and records; preserve user work and ownership, and reconcile uncertain side effects before retrying. Do not create parallel role instances, task databases, or SOPs.
- Drive admitted work to verified authorized delivery unless cancelled, paused for human attention, or authorization is withdrawn; preserve recovery instead of forcing completion. Keep Work Items to Briefs, meaningful transitions, decisions, and outcomes; retain process chatter and raw evidence outside user-facing records.
