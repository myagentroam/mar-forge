# MAR Forge

Agent-first planning, admission, code inspection, verified delivery, and recovery for MAR-managed engineering work.

**Strict admission enables bold autonomy: every task that enters Forge is driven through to verified delivery.**

[Chinese](README.zh-CN.md)

## What it provides

MAR Forge is a reusable Agent Skill for MAR-managed Workspaces. It supplies a single workflow for ad hoc code review, continuous commit review, issue admission, coordinated implementation, independent verification, fix loops, local integration, and interruption recovery.

Its canonical Handoff chain is:

`Inspector -> Curator -> Gatekeeper -> Coordinator -> Fixer -> Verifier`

Curator acceptance and Gatekeeper approval are independent admission gates. Both must succeed before an unowned item becomes ready. Gatekeeper performs a focused technical fact check; it does not rewrite the Brief or add another coordination layer.

The Skill defines roles and engineering judgment. The consuming repository keeps only its native issue tracker commands, Session bindings, repository/branch mappings, engineering and test rules, notification recipients, evidence paths, and actual user authorization.

## Requirements

- A MAR-managed Workspace and MAR-hosted Runners.
- Repository instructions that bind the generic roles and Work Item semantics to the project.

MAR is the primary user of this Skill. Standalone non-MAR runtimes are not supported. Forge does not replace product design, engineering standards, tests, or user authorization.

## Install with npx

```bash
npx skills add myagentroam/mar-forge --skill mar-forge -a universal --copy
```

The package is a root-level `SKILL.md` with focused references; no npm package, plugin, service, or runtime dependency is required.

## Use

Load `mar-forge` for `ship forge`, Inspector reviews, Curator intake, Gatekeeper admission, or Coordinator-led delivery. Start with `SKILL.md`, then load only the relevant reference:

| Reference                 | Responsibility                                                              |
| ------------------------- | --------------------------------------------------------------------------- |
| `references/protocol.md`  | Entry points, Work Item state, ownership, evidence, recovery, and decisions |
| `references/inspector.md` | Ad hoc and continuous commit review, local checkpoints, and finding quality |
| `references/admission.md` | Curator reception and independent Gatekeeper technical admission            |
| `references/delivery.md`  | Coordinator orchestration, Fixer/Verifier loops, integration, and cleanup   |
| `references/templates.md` | Optional Brief, admission, dispatch, review, and decision formats           |

`ship forge` means complete authorized local delivery: admission, implementation, verification, independent review, necessary task commits, and local integration of changed repositories. It does not authorize push, deployment, release, production changes, or external replies.

## Development

Keep tracked content and commit messages in English except for this README's Chinese companion. Generic workflow rules belong in this Skill; repository-specific facts do not. Do not create a second local SOP that competes with these references.

## License

Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
