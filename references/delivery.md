# Delivery: Coordinator, Fixer, and Verifier

This reference governs Handoff and explicitly delegated coordination. It is not a mandatory gateway for a small Continue task. The Coordinator drives admitted work to its authorized delivery point; scheduling, a terminal Run, or a candidate commit is not completion.

## Coordinator work loop

There is one host-declared Handoff Coordinator. It orchestrates and integrates but does not take over implementation or create another Coordinator.

1. Reconcile all open in-progress Handoff items, recorded Sessions, candidates, and directories. Distinguish active work, interrupted recovery, and missed status updates. Do not skip, repeat, or take over a valid Continue/other owner.
2. Consume existing Verifier results, blockers, decisions, and delivery-ready candidates first. Resume the original stage rather than restarting implementation.
3. With available capacity, select independent Open + ready items by priority and dependencies. Read each latest item, verify both admission gates and the absence of a valid Claim, then claim before writes. A missing critical fact returns to Curator; a new tradeoff follows needs-decision.
4. Prepare isolated task directories and dispatch the minimum necessary Fixer and fresh Verifier work. Independent items may proceed concurrently; one item's wait or repair must not barrier unrelated items.
5. Wait through existing Session mechanisms with bounds, read actual final results and evidence, write meaningful outcomes to the Work Item, integrate only verified candidates, and clean up after the agreed delivery point.

Reuse still-valid evidence. A timer, role switch, commit, or advancing target branch does not itself invalidate tests or review. Recheck only changed content, dependencies, or real integration interactions.

## Work units and isolation

Default to one Fixer for one independently deliverable item. Split an item only when complete business modules can proceed independently with clear benefit, exclusive write scopes, dependencies, and an integrator. Never split by file, interface, or routine investigation step.

- Each engineering task uses its declared worktree and task branch, including serial work; do not implement Handoff directly in a shared integration checkout. A pure in-Session documentation Continue may remain in the current Workspace when repository rules allow.
- Sessions do not isolate directories. Before writes, verify absolute path, repository root, branch, and base HEAD. Use the assigned directory explicitly and report a blocker if isolation is impossible.
- Give concurrent items separate writable checkouts, indexes, test instances, evidence, and recovery records. Sharing a repository or subsystem alone is not a reason to serialize; real resource or write conflicts are.
- A new worktree does not automatically provide dependencies, nested submodules, ports, databases, or services. Prepare them according to host engineering rules and never reuse shared development/UAT instances for automated tests.
- Preserve unknown or another owner's changes. Do not reset, clean, stash a whole checkout, or overwrite work to make a task directory convenient.

Capacity considers active Runs/queues, machine resources, exclusive test resources, and the Coordinator's ability to follow through. Do not claim work that cannot actually be dispatched.

## Implementation and verification responsibility

Fixer reads the latest Brief and authoritative design, implements the coherent item, adds regression coverage that can detect the problem, and runs the required focused verification before handing off. Code completion, self-review, or a commit is not test evidence.

Verification is selected by actual behavior and risk: unit/Fake for local logic, integration/E2E for cross-layer behavior, and specifically authorized real-model or platform tests when required. Do not mechanically run everything or silently drop user-required validation. Test the exact candidate from isolated resources, not an old shared build. Record executed, failed, skipped, and unverified scopes with sanitized stable evidence.

Fixer may repair a clearly understood, locally fixable defect, stale fixture, or assertion within the current module or required verification, including a pre-existing failure directly affecting that validation. Preserve the confirmed contract and original risk coverage; never delete or weaken tests to obtain green. Scope expansion, product/architecture choices, and high-risk unrelated work are escalated rather than absorbed.

Verifier is the independent review and verification role, not a mandatory third Session or duplicate PASS. A fresh Verifier reviews substantive task commits; the same Verifier is reused for subsequent fix loops. A separate bounded validation Worker is justified only by a distinct platform/resource capability and explicit authorization; Verifier still owns the single independent conclusion.

Workers use the host-declared model and reasoning effort. Check actual runtime configuration, not just a title or prompt. A model change preserves the Claim, worktree, commits, changes, and valid evidence; stop the precise old writer before a replacement resumes the unfinished stage.

## Dispatch and directory ownership

Use [templates.md](templates.md) for the initial Fixer/Verifier dispatch. Supply the item URL, scope, exact repository/directory/branch/base, verification requirements, evidence paths, actual authorization, and candidate range. Workers read the latest Brief themselves; do not copy a complete conversation.

Handoff Workers are read-only on the Work Item. They save stable evidence and finish their Session turn with the result; they do not edit Briefs, labels, assignees, or comments, do not integrate, and do not message or wait for each other or Coordinator. Coordinator alone dispatches, waits across Sessions, and writes back verified outcomes.

Normal stage dispatches use non-interrupting queue semantics after checking the recipient, prior Run, queue, pause, and deduplication ID. Interrupt only a precise target when existing control authorization and an actual coordination need justify it. Acceptance, queueing, and terminal state are not business completion.

Directory use follows `Fixer -> Verifier -> Fixer` serially by default; independent judgment does not require a second checkout. Ownership of the Work Item Claim does not move with directory use.

- Fixer finishes commits/tests, stops writers, records HEAD/index/tracked state and artifacts, and explicitly releases the directory before Verifier starts.
- Verifier checks candidate and directory state, keeps tracked source read-only, and may install dependencies/build/test using isolated resources. Unknown changes or HEAD drift stop the review; Verifier never resets or cleans them.
- Before a result, Verifier stops its processes, confirms tracked state and HEAD, preserves evidence, and releases the directory. Any test-produced tracked change is reported as an abnormal dirty handoff, not silently repaired or passed.
- Only Coordinator confirms the prior Run, queued obligations, processes, and release before dispatching the next stage. Workers end after their result and never wait inside the directory for a downstream role.
- A genuinely parallel review requires a separate checkout and resources. Recovery records are not filesystem locks; inspect actual Runs, queues, and processes.

Where the host uses a one-time closing self-check after the first Fixer Run, queue it once and verify it actually executed before review. Do not append it after every repair or confuse the first Run's result with the final candidate.

## Independent Verifier and fix loop

Verifier checks acceptance, source and design boundaries, regression quality, and evidence against the exact candidate. It writes a new per-round report without overwriting earlier candidates.

- PASS binds repository, base/HEAD, Brief version, and actual verification scope. CI green, no findings, or insufficient evidence alone is not PASS.
- Findings have stable IDs, severity, path/behavior, evidence, impact, and blocking status. Preferences do not create endless repair rounds.
- Blocking Findings return once to the original Fixer, which repairs, retests, commits, and returns a new candidate. The original Verifier rechecks each Finding and affected behavior. Do not create a new implementation Session for a routine repair.
- New content requires a corresponding new conclusion. Target-branch movement alone does not invalidate an existing candidate review; changed Briefs, conflict resolutions, or behavior interactions require scoped revalidation.
- If the same blocking Finding remains unresolved after two complete repair + verification + re-review cycles, stop that loop and escalate with precise evidence. Real progress is not stopped by an arbitrary total round count, and renaming a Finding does not reset the count. Network/credential failures are blockers, not completed repair rounds.

Immediately escalate contradictory requirements, scope violations, or product/architecture tradeoffs. Ordinary repairable Findings continue automatically without human confirmation.

## Integration and authorized delivery

The default `ship forge` delivery sequence is task commits, independent Verifier conclusion or valid pointer-only verification, local integration for content repositories, then local integration for dependent/pointer repositories. Host instructions name the actual repositories, branches, dependency order, and commit mechanism.

Before integration, Coordinator verifies the exact repositories and candidate objects, latest Brief/Claim, open state, acceptance, required evidence, absence of cancellation/withdrawal, and a valid Verifier conclusion for the complete candidate. It then integrates directly within the existing mandate; no extra human merge confirmation is required. Push, deployment, release, production changes, and external replies are outside this default.

Fixer commits every changed repository and reports base/HEAD, scope, and evidence. For dependent Gitlink-style delivery, the content commit exists first and the pointer commit identifies that exact reviewed result. A pointer-only parent change may use a reduced verification path only when the entire range is the expected forward pointer, the exact content commit is locally reachable at the target integration branch, and no substantive parent changes are hidden. Otherwise use normal independent review.

Integrate into the host's existing target checkout, preserving its current work:

1. Check actual branch, HEAD, index, common ancestor, and complete task delta. Prefer fast-forward when possible. If diverged, merge the reviewed original task commit as authorized; do not make Fixer rebase or replay solely to chase the target branch.
2. Dirty files or overlapping paths are not automatic blockers. Use the host's locked, path/hunk-scoped commit and safe merge mechanisms to isolate only task content. Never include another owner's staged or unstaged hunks.
3. When a direct safe operation is blocked, coordinate only the precise affected paths or index window with the existing owner. Do not demand a whole Session pause. If temporary replacement is unavoidable, preserve and verify exact content/diffs/HEAD outside the repository, confirm exclusive access, integrate, and restore the original local delta. Never use broad reset/clean/stash or discard unknown content.
4. Automatic textual merging does not prove semantic correctness. Verify the committed integration result, not a worktree mixed with unrelated changes. Reuse candidate review for unchanged content and check only integration deltas; behavior-changing conflict resolution returns through focused Fixer/Verifier work.
5. For dependent pointers, read back the actual integrated content target before integrating the parent. Never overwrite other integrated content work with an older task pointer. Record integration evidence separately from the original candidate PASS.

At the authorized local delivery point, read back target reachability and actual integrated changes. Record one final outcome with delivered commits, acceptance/verification, and real remaining limitations. Close only when delivery and acceptance are complete; subsequent UAT or release work remains open as appropriate.

## Decisions and blockers

Pause only the affected item when unresolved compatibility/behavior, data/permission safety, cross-repository consistency, critical verification, or an actual product/architecture choice remains. Record needs-decision, owner, candidate, recovery point, options, and recommendation, then follow the host's authorized notification rule. Do not turn an ordinary environment failure into a human risk decision or stop unrelated Coordinator work.

A valid decision is written back with author, time, candidate/scope, and limitations. Resume the original stage after rechecking current content and remaining gates; do not restart or claim again. Acceptance of residual risk never replaces required verification.

## Worktree cleanup

Clean task-specific checkouts only after the agreed delivery and evidence preservation are complete. Pending integration, decision, validation, or recovery is not complete.

1. Read back delivered target SHAs and ensure every task commit and required artifact is recoverable. Confirm associated Runs/queues, tests, and directory users are finished.
2. Resolve registered worktrees and exact task paths. Inspect tracked, untracked, ignored, and nested-repository content. Preserve unknown changes, undelivered commits, user files, and active users.
3. Remove nested task worktrees/submodules in dependency order, then unregister only the exact task worktree and remove its empty container. Do not delete shared checkouts, object databases, branches, or Sessions.
4. A forced removal is never a response to dirty/unknown content. If a host Git limitation requires it for an exact clean nested-submodule case, first prove the sole reason, clean deinitialization, no saved content/activity/locks, recoverability, and no shared object borrowing; otherwise preserve and report the blocker.
5. Read back registrations and paths. Partial cleanup is reported as partial, not success.

## Session control

Use MAR Session tools according to the host bindings and native IDs. Watch exact Runs with bounded waits; do not poll conversation bodies or invent another timer/queue. Correlate deduplication IDs with actual execution and reconcile uncertain results before resending. A timeout is not termination.

When recovering legacy direct Worker-to-Worker waits, inspect both sides and stop only a precise read-only waiting Run within existing authorization. Preserve candidates and evidence, invalidate stale direct inputs, and continue the original stage through Coordinator. Never batch-cancel Workers or skip Verifier.
