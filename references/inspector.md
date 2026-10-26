# Inspector: evidence-driven code review

Use this reference for ad hoc code, architecture, or module reviews and continuous commit review. Inspector produces evidence and conclusions; it does not automatically fix, commit, notify, or deploy. Continuous commit review automatically transfers confirmed Findings to Curator for ordinary Handoff; independent ad hoc review does not transfer unless the user explicitly requests it.

## Scope and evidence discipline

Bind the repository, branch or baseline, requested target, actual scope, exclusions, and authorization before starting. Read current implementation, related tests, and authoritative design before judging. Do not presume a Bug or infer desired behavior solely from existing code.

Review the requested target and direct effects. Architecture review focuses on real ownership, dependency direction, state consistency, lifecycle, cohesion, and coupling. Without caller, state-flow, failure, or maintenance evidence, do not propose layering, abstraction unification, task graphs, or cosmetic restructuring.

Before calling code over-designed or over-defensive, prove that its guarded case is unsupported, the mechanism is genuinely duplicate, or its cost exceeds a demonstrated risk with a concrete replacement safeguard. Unfamiliar, currently untriggered, or lightly tested code is not thereby redundant.

## Fixed local checkpoints

Use the host's ignored evidence root. Unless it declares an equivalent, use:

| Path                                 | Purpose                                                                     |
| ------------------------------------ | --------------------------------------------------------------------------- |
| `.forge/inspector/commit.md`         | Continuous commit cursor, current target, and next action for this checkout |
| `.forge/inspector/topic.md`          | One ad hoc review's scope, coverage, and next action                        |
| `.forge/inspector/runs/<review-id>/` | Per-round reports, command logs, diagnostics, and sanitized evidence        |

New reviews use this layout. Finish an already-active legacy review in its recorded location; do not move or duplicate its checkpoint while active.

Use a distinguishable review ID such as `20261025T103000Z-eb06ac33` or `20261025T103000Z-agent-core`. Fixed files are current snapshots, not append-only logs; detailed evidence belongs in the run directory.

Update a checkpoint at the start, after a substantive phase or external side effect, on interruption, and at completion—not after every read or search. Commit and topic checkpoints are independent. Allow one active review per mode per checkout; inspect an existing owner before resuming or replacing an interrupted record. Use separate checkouts for genuinely parallel reviews.

Checkpoints are recovery aids, not tracked indexes, design facts, Work Items, or completion proof. An actual delivery receipt with `delivery=STARTED` or `delivery=QUEUED` means the input was accepted for processing, not that Curator accepted the Finding or implementation completed. Once Curator accepts a finding into a Work Item, that item owns subsequent state. Never record secrets, hidden reasoning, full conversations, or irrelevant personal data. Historical authorization in a checkpoint does not revive expired permission.

Keep only fields needed for recovery and omit empty sections:

```markdown
# Code Review Progress

status: in_progress | blocked | complete
updated_at: <absolute time with timezone>
mode: commit | topic
workspace: <absolute path>
owner_session: <current or interrupted Session ID>
authorization: <actual scope for this review>
run_dir: .forge/inspector/runs/<review-id>/

# Commit mode: branch, cursor, pending, base, head.

# Topic mode: topic, baseline.

scope: <actual scope and exclusions>
covered: <behaviors, modules, and evidence checked>
findings: <IDs, classifications, report links, and any Work Item URLs>
handoff: <none, or per-Finding pending or actual delivery receipt, with clientMessageId>
validation: <actual results and explicit gaps>
external_effects: <actual side effects and receipts; omit if none>
remaining: <unfinished review or validation>
next_action: <single next action on resume>
```

## Review loop

1. **Bind the candidate.** Record repository, base/HEAD or topic baseline, branch, and dirty state. Historical commits are reviewed from their objects and diffs, never represented by the current worktree. Do not switch, clean, or reset a shared checkout for read-only review.
2. **Build a minimal behavior map.** Locate public contracts, producers/consumers, state and resource owners, asynchronous boundaries, and related tests from the diff or topic entry. Recognize existing coverage instead of proposing it again.
3. **Validate concrete candidates.** Start with static inspection of code, design, existing tests, and recorded evidence; follow trigger order, actual reachability, impact, and safeguards. Do not execute tests merely because behavior looks suspicious or to explore possibilities. Only after a concrete candidate emerges, run the smallest focused test or diagnostic when static evidence is insufficient and execution can confirm or refute its trigger, impact, or classification. A statically proven conclusion needs no confirming test run. Classify any observed failure as regression, stale expectation, pre-existing behavior, or environment before assigning blame.
4. **Classify conclusions.** Separate confirmed defects, explicit verification gaps, unconfirmed candidates, and rejected candidates. Unconfirmed candidates are not formal Findings; if retained, name the missing evidence and decisive experiment. Architecture findings need the same evidence standard.
5. **Report and dispose only as authorized.** Order formal Findings by impact. Include path/location, trigger sequence, impact, evidence, and minimal repair direction. A verification gap names the missing behavior guarantee and smallest useful test. Exclude preferences, speculative risks, and combinatorial test matrices.
6. **Finish the round.** Record actual coverage, conclusions, commands/results, exclusions, and next action. If no confirmed issue exists, say so and list validation limits without running exploratory tests to make the review appear more verified. Re-review changed content against its new SHA while preserving old reports and rechecking only invalidated evidence.

`review fix loop` addresses current Findings when repair is authorized, then rechecks affected behavior. Static-first limits exploratory review; it does not waive post-fix verification required by host engineering rules. Without new code, evidence, or missed scope, do not mechanically repeat a full review.

## Continuous commit mode

Use `cursor` for the last completed full SHA on the named branch and `pending` for the active, unfinished full SHA; use `none` when absent. Record the real `base` and `head`. Do not infer a starting point from a date, "recent", or a branch name alone.

Advance by first-parent review units unless the user specifies otherwise. A normal commit is compared with its parent. A merge is one unit: inspect the full introduced diff and conflict handling relative to the first parent, reusing still-valid reviews of merged commits where appropriate. A batched report lists every SHA.

1. Resume non-empty `pending` before selecting another commit. Reconcile any `handoff: pending` Finding before selecting a new unit; do not resend a Finding whose delivery was already accepted (`STARTED` or `QUEUED`, including an existing queued record). Otherwise select the next unit after `cursor` and record its base/HEAD and run directory.
2. Inspect actual diff, design, tests, and direct effects. For a Gitlink change, resolve old/new submodule SHAs and review their diff; a missing object or unclear relationship is a blocker, not an empty change.
3. Give each confirmed Finding a stable local ID and transfer its evidence to Curator for normal reception, deduplication, and the two admission gates. Include repository, base/HEAD, report reference, and enough context to reproduce or assess it. Do not transfer hypotheses or verification-only gaps as defects. Inspector must not create or edit Work Items, choose `ready`, dispatch Workers, or fix the Finding.
4. Record `handoff: pending` with the stable Finding ID and `clientMessageId` before sending, then save the actual send/delivery receipt. Both `delivery=STARTED` (processing starts directly) and `delivery=QUEUED` (input is queued) replace pending as accepted delivery; neither requires the other. An unknown send result remains pending. On recovery, use the saved `clientMessageId` to reconcile against the recipient's actual received-input or queue records before considering a retry. If those records establish accepted delivery, save that evidence and do not resend; if the outcome is still unknown, retain pending rather than blindly retrying. Review completion and Handoff delivery are separate: the cursor may advance after the review and pending or actual receipt are recorded, but the next round reconciles pending delivery before new work.
5. Only after the scope, candidates, Findings, verification gaps, and report have conclusions may `cursor` advance to HEAD and `pending` clear. Review completion does not mean its Findings were fixed. Preserve `pending` on interruption or insufficient evidence.

New branch commits wait for later rounds. This automatic Curator handoff applies to both scheduled continuous review and user-requested sequential advancement through the same commit cursor. After accepted delivery (`STARTED` or `QUEUED`), stop tracking implementation locally; later Curator or Work Item state is not an Inspector completion condition.

## Ad hoc topic mode

Define falsifiable coverage rather than "look deeper." Record topic, baseline/current HEAD, behavioral or module scope, explicit exclusions, meaningful covered/remaining units, and a specific next action. A cross-end call chain proves only the path actually inspected; reviewing several components does not establish independent exhaustive protocol coverage.

Reuse confirmed conclusions and recheck only changes on resume. Do not let a topic grow into a whole-repository review without redefining scope. Mark complete only when all declared units have conclusions and `remaining` is empty; exclusions are removed from both scope and remaining. Sampling is never described as exhaustive coverage.

Ad hoc findings remain report-only unless the user explicitly asks to transfer them. Do not silently apply continuous-review handoff authorization to an independent topic, even when its target is a commit.

## Per-round report

Each run directory contains at least `report.md` with only relevant sections:

```markdown
# <Commit SHA or topic> review report

## Target and scope

<Repository, base/HEAD or baseline, coverage, and exclusions>

## Findings

<Evidence ordered by impact, or an explicit no-confirmed-findings result>

## Validation

<Commands, hit/pass/fail/skip results, logs, and unverified limits>

## Coverage and conclusion

<Covered, rejected candidates, blockers, and whether cursor may advance>

## Side effects and next action

<Actual Curator handoff, Work Item/fix effects and one next action; omit if none>
```

On resume, read the fixed checkpoint, latest report, and only cited evidence needed for the next decision. Verify candidate SHA, worktree, and prior side effects. Stop when necessary validation and records are complete.
