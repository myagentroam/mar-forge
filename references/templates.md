# Forge templates

Use only fields that carry real information. Delete placeholders and unused headings; never submit empty sections. These templates do not grant implementation, commit, integration, communication, real-model, deployment, or external-reply permission.

## Work Item Brief

Simple items may combine this into one paragraph.

```markdown
## Problem and expected behavior

<Observed problem or user goal, expected result, and only necessary reproduction/environment evidence.>

## Brief analysis

<One to three useful mechanism/impact conclusions. Distinguish confirmed facts, hypotheses, and unknowns.>

## Completion and verification

<Observable completion conditions and minimum appropriate verification. Add priority, risk, dependencies, or a concrete decision only when they affect execution.>
```

Do not include deduplication logs, Session/Run/queue IDs, worktree paths, dispatch narration, notification receipts, raw commands, or an implementation diary. Pure questions need only the question and answer.

## Admission decisions

Curator acceptance:

```text
Forge admission — Curator accepted. Brief revision <logical revision>; Brief and Handoff scope checked; submitted for independent Gatekeeper fact check. Not ready yet.
```

Gatekeeper decision:

```text
Forge admission — Gatekeeper approved | needs evidence | needs decision | not confirmed.
Checked: Brief revision <native revision or logical marker>; evidence <decisive source or reproduction references>.
Basis: <concise technical judgment and any exact gap>.
Next: ready if unowned and otherwise eligible | Curator correction | human decision | no Bug admission.
```

Only meaningful gate transitions are recorded. Do not turn technical review into an investigation diary or duplicate the Brief.

## Gatekeeper urgent handoff to Coordinator

Use only for explicitly authorized urgent delivery after Gatekeeper has recorded approval and ready is visible. Curator does not send a duplicate dispatch.

```text
<Work Item URL> is Curator-accepted, Gatekeeper-approved, ready, and unowned.
Urgency: <user-authorized reason and deadline>.
Please claim and deliver within the existing mandate. Re-read the latest Brief and verify the Claim; queue receipt is not completion.
```

## Fixer initial dispatch

```text
You are the Fixer for <Work Item URL>. Read the latest Brief and follow repository engineering rules and Forge delivery.
Scope: <necessary boundaries and exclusions; reference the Brief when already clear>
Directories and bases: <absolute host-declared task workspace, repository, branch where applicable, base SHA for each repository>
Verification: <minimum behaviors and test levels; real environment/authorization limits if any>
Evidence: <Fixer report and raw result directory>
Authorization: <actual implementation, task commit, and special validation scope>
Coordinator: <native Session ID>

Deliver base/HEAD, changes, actual verification and evidence, remaining limits, and directory-release state. Do not edit the Work Item, integrate, message other Sessions, or wait for downstream work. Finish your turn after saving the result.
```

If the host uses a one-time closing self-check, Coordinator queues its exact configured message once after the first Fixer Run starts and waits for its actual execution before Verifier dispatch.

## Verifier initial dispatch

```text
You are the independent Verifier for <Work Item URL>. Review <repository base/HEAD and complete candidate range> in the released task directory.
Fixer evidence: <report/result references and known gaps>
Verification: <required behaviors and authorized focused reruns>
Report: <new per-round report path; do not overwrite old reports>
Coordinator: <native Session ID>
Authorization: <review and isolated verification scope>

Keep source and Work Item read-only. Check acceptance, regression, design boundaries, and evidence. Stop on unexpected HEAD/tracked changes; do not reset or clean. End tests, release the directory, save Findings or candidate-bound PASS, and finish your turn. Do not message or wait for other Sessions.
```

## Fix and re-review handoffs

Coordinator to Fixer:

```text
<Work Item URL>, candidate <repository/SHA>: blocking <Finding IDs>, evidence <Verifier report>.
Repair, rerun affected verification, commit, and return the new SHA with per-Finding results and directory release. Do not repeat a one-time closing queue.
```

Coordinator to Verifier:

```text
<Work Item URL>, new candidate <repository/SHA>: fixes <Finding IDs>, implementation/verification evidence <references>, new report <path>.
Review this delta and affected behavior, preserve prior reports, and return a new candidate-bound conclusion with directory release.
```

Worker final response (not a Session message):

```text
<Work Item URL>, <repository/SHA>: <repair complete, PASS, blocker, or decision needed>; evidence <reference>; directory <released or exact blocker>; next <re-review, integration, or recovery>.
```

## Verifier report

```markdown
# Verifier report: <Work Item or candidate>

## Candidate and scope

<Repository, base/HEAD, Brief revision, complete range, exclusions>

## Findings

<Stable ID, severity, path/behavior, trigger/evidence, impact, blocking status; or none>

## Verification

<Executed/hit/passed/failed/skipped results, evidence paths, and unverified limits>

## Conclusion and handoff

<PASS bound to exact candidate and evidence, repair required, or blocker; directory state>
```

## Human attention or decision record

```text
Attention needed: <human-owned decision or blocker persisting after bounded autonomous recovery>.
Stage and candidate: <current stage and exact candidate, if any>.
Impact: <why execution cannot safely continue>.
Options: <bounded feasible choices and consequences>.
Recommendation: <one recommendation with basis>.
Owner/recovery: <preserved owner and resume point>.
```

Record the resulting author, time, choice or resolution, scope/candidate, and limitations. Notification receipts belong in minimal private recovery records, not the user-facing Brief.
