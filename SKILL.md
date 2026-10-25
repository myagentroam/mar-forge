---
name: mar-forge
description: Agent-first planning, admission, code inspection, verified delivery, and recovery for MAR-managed engineering work. Use for "ship forge", Inspector reviews, Curator intake, Gatekeeper admission, and Coordinator-led Fixer/Verifier delivery.
---

# MAR Forge

**Strict admission enables bold autonomy: every task that enters Forge is driven through to verified delivery.**

MAR Forge is a generic workflow Skill for MAR-managed Workspaces. It defines engineering judgment and role boundaries, not product requirements, repository commands, or new permissions. MAR is its primary user; MAR-hosted Runners follow MAR Session semantics. Standalone non-MAR runtimes are unsupported.

## Operating model

The canonical Handoff chain is:

`Inspector -> Curator -> Gatekeeper -> Coordinator -> Fixer -> Verifier`

Not every task enters through Inspector, and small tasks explicitly assigned to the current Session may use Continue instead of the queue. Admission still requires an executable Brief and the applicable authorization. Never turn a direct implementation request into a queue item merely to make the flow look uniform.

- **Inspector** investigates code, architecture, modules, commits, or a defined verification question. It reports evidence and does not automatically fix or transfer findings.
- **Curator** owns reception, deduplication, clarification, and the Work Item Brief. It does not implement or dispatch Workers.
- **Gatekeeper** independently checks technical evidence and readiness after Curator acceptance, records its decision, and performs the final ready transition after approval. It does not rewrite the Brief, rediscover the item, or replace Curator.
- **Coordinator** is the sole Handoff orchestrator. It claims admitted work, coordinates Fixer/Verifier loops, writes back meaningful outcomes, and performs authorized integration.
- **Fixer** implements and tests one coherent unit of work. **Verifier** independently reviews the candidate and its evidence. Workers do not modify Work Item state or message each other.

Curator acceptance and Gatekeeper approval are separate admission gates. Only their successful completion makes an unowned Handoff item ready. Readiness enables execution only within the user's actual authorization; neither this Skill nor a Work Item grants permission.

## Load only the relevant rules

1. Read [protocol.md](references/protocol.md) for Work Item semantics, entry selection, ownership, evidence, and recovery.
2. For a code or architecture review, read [inspector.md](references/inspector.md).
3. For intake, transfer, or admission, read [admission.md](references/admission.md).
4. For implementation, Worker coordination, review/fix loops, or integration, read [delivery.md](references/delivery.md).
5. Use [templates.md](references/templates.md) when a Brief, evidence report, admission decision, Worker dispatch, or decision record is needed. Templates are aids, not mandatory empty sections.

Repository instructions supply native Work Item commands, role Session identities, repository and branch mappings, model/effort settings, engineering rules, notification recipients, ignored evidence paths, and the exact authorized delivery point. Follow those bindings without copying them into this public Skill.

## Working principles

- Start from current source, tests, authoritative design, actual state, and the user's current instruction. Do not treat an old plan, prior receipt, or role title as proof.
- Reuse existing authorized Sessions and records. Do not create a second role instance, a local task database, or parallel SOPs.
- Preserve user work and existing ownership. Queue ordinary handoffs; reconcile uncertain side effects before retrying them.
- Drive admitted work through implementation, focused verification, independent Verifier review, fix loops, and the authorized delivery point. Do not stop at scheduling or a candidate commit.
- Keep Work Items useful: Brief, meaningful admission/status transitions, decisions, and final outcomes. Keep process chatter, raw logs, and internal Session details in ignored evidence.
- Push, deployment, release, production changes, and external replies require their own current authorization. `ship forge` defaults to complete authorized local delivery, including task commits and local integration, not remote publication.
