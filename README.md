# MAR Forge

Agent-first autonomous Handoff, admission, coordinated delivery, verification, and recovery for MAR-managed engineering work.

**Forge autonomy through automation, minimizing human attention while preserving human judgment.**

Strict admission enables bold autonomy: admitted Handoff proceeds to verified delivery unless cancelled, paused for human attention, or authorization is withdrawn.

[Chinese](README.zh-CN.md)

## What it provides

MAR Forge is a reusable autonomous Handoff protocol for MAR-managed Workspaces, covering admission, coordinated implementation, independent verification, recovery, and local integration. Forge Inspector workflows may supply evidence and candidate work into that Handoff lifecycle.

### Applicability

Forge is opt-in, not MAR's default development behavior. Load it only for an explicit Forge invocation, a natural-language repository/Workspace declaration that it uses Forge, or continuation of an existing Forge workflow or role Session. Ordinary code review, implementation, testing, planning, and local delivery without one of those signals stay outside Forge. Accidental loading does not enable Forge, and non-Forge projects need no negative declaration.

### Execution flow

```text
User / external / Inspector / other sources
                    │
                    ▼
                 Curator
                    │ accepted
                    ▼
                Gatekeeper
                    │ approved
                    ▼
                  ready
                    │
               Coordinator
                    │
                    ▼
             ┌──► Fixer ──► Verifier
             │                 │
             └── findings ─────┤
                               │ PASS
                               ▼
                   Authorized integration
```

Inspector is an optional source, not a mandatory entry. Coordinator mediates all post-admission execution and Fixer/Verifier loops; Workers never coordinate directly with each other. Curator is Forge's intake role, while admission is the combination of Curator acceptance and Gatekeeper approval.

Explicit work assigned to the current Session remains outside Forge Handoff:

```text
Explicit current-Session task ──► Continue ──► authorized delivery
```

Explicit current-Session work remains Continue under the host repository's normal development rules and outside Forge Handoff. Handoff must pass both admission gates before an unowned item becomes ready.

## Runtime boundaries and non-goals

```text
MAR Runtime
Sessions / Agent network / queue / steer / Runners
                    │
                    ▼
MAR Forge
Roles / admission / ownership / delivery / verification / recovery
                    │
                    ▼
Repository bindings
Commands / branches / tests / models / evidence / authorization
```

MAR is the target runtime for this Skill; standalone non-MAR runtimes are unsupported. Forge is not MAR's default engineering protocol and does not provide Session primitives, product requirements, repository engineering standards, tests, credentials, or new permissions. It does not replace authoritative design or make an Issue an authorization grant.

## Requirements

- A MAR-managed Workspace and MAR-hosted Runners.
- Repository instructions that bind the reusable roles and Work Item semantics to the project.

### Host bindings

| Binding      | Host-provided bindings                                                   |
| ------------ | ------------------------------------------------------------------------ |
| Eligibility  | Natural-language declaration of Forge use in root instructions           |
| Work Items   | Tracker, commands, state mapping, and Brief revision source              |
| Sessions     | Role identities, persistent prompts, schedules, models, and controls     |
| Repositories | Remotes, branches, dependency order, and pointer/content relationships   |
| Execution    | Workspace isolation, commit mechanism, and authorized delivery point     |
| Engineering  | Source routing, authoritative design, verification, and cleanup rules    |
| Evidence     | Ignored report, recovery, and Inspector checkpoint locations             |
| Decisions    | Notification recipient, authorized channel, and deduplication convention |

## Install with npx

```bash
npx skills add myagentroam/mar-forge --skill mar-forge -a universal --copy
```

The package is a root-level `SKILL.md` with focused references; no npm package, plugin, service, or runtime dependency is required.

## Use

After an explicit invocation, positive host binding, or existing Forge continuation establishes applicability, start with `SKILL.md` and load only the references needed by the task. Do not select Forge merely because an ordinary task mentions review, inspection, testing, implementation, or delivery:

| Task                         | References                                                                      |
| ---------------------------- | ------------------------------------------------------------------------------- |
| Inspector only               | `inspector.md`; add `protocol.md` only for transfer/recovery                    |
| Admission                    | `protocol.md` + `admission.md`                                                  |
| Fresh `ship forge`           | `protocol.md` + `admission.md`; add `delivery.md` after ready                   |
| Coordinator on admitted work | `protocol.md` + `delivery.md`; add admission for claimed Brief changes/recovery |
| Templates                    | `templates.md` only when a corresponding record is needed                       |

The references live under `references/`. `ship forge` means complete authorized local delivery: admission, implementation, verification, independent review, necessary task commits, and local integration of changed repositories. It does not authorize push, deployment, release, production changes, or external replies.

## Development

Keep tracked content and commit messages in English except for this README's Chinese companion. Reusable workflow rules belong in this Skill; repository-specific facts do not. Do not create a second local SOP that competes with these references.

### Protocol versioning

Forge is pre-release while `develop` is the only branch. Before stable publication, use `main` for reviewed stable releases, keep `develop` for integration, and tag protocol versions. Use semantic versioning: incompatible protocol behavior changes the major version, backward-compatible capabilities the minor version, and clarifications or corrections the patch version. A moving `develop` branch is not a stable protocol release.

## License

Apache License 2.0. See [LICENSE](LICENSE) and [NOTICE](NOTICE).
