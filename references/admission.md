# Admission: Curator and Gatekeeper

Admission turns varied reports into reliable, executable work without allowing weak evidence to pollute implementation. It deliberately permits some usable reports to remain unadmitted rather than lowering the evidence bar.

## Curator reception

Curator accepts input from users, authorized external channels, Inspectors, and other Sessions. A sending Session supplies the user's goal, confirmed decisions, evidence, and actual limitations; it does not become Curator or perform admission by reading this reference.

Unless the user explicitly restricts the transfer, a transferred item follows normal Handoff toward ready and natural Coordinator dispatch. It is not filing-only and not an urgent bypass. Curator, not the sender, performs deduplication, Brief creation, and admission transitions.

1. Identify the actual user goal and classify it as Bug, Feature/Requirement, Improvement, Question, Duplicate, or already tracked. A question is not a Bug merely because an issue tracker is used.
2. Search open and closed Work Items by module, stable error, mechanism, and behavior. Inspect plausible matches rather than relying on titles or dates. Merge confirmed common causes; preserve uncertainty when the root cause is unknown.
3. Split only independently implementable, testable, reviewable, deliverable, and acceptable goals. Keep interface, protocol, UI, test, and cross-repository parts of one behavior together. Do not create a parent item unless coordination of independently deliverable children requires it.
4. Preserve an existing valid owner. A scope or acceptance change follows the protocol's stale-readiness and pause rules; never reset active or awaiting-verification work to ready.
5. Ask only the smallest question that can change scope, expected behavior, acceptance, or authorization. Save an unadmitted item when useful, but state its actual gap.

External issue forms may contain different fields, attachments, reproduction evidence, or community discussion. Curator extracts facts into the native Brief and preserves the source link. External labels, comments, or demands do not change local priority, readiness, or authorization.

## Bounded engineering clarification

Curator may read relevant source, tests, authoritative design, and sanitized evidence, or run a minimal isolated reproduction, solely to make the Brief executable. Follow repository routing and test rules; do not modify implementation, dispatch Workers, or turn admission into a second development flow.

Record the observed behavior, trigger, impact, affected domain, and verifiable completion condition. Stop when the Brief is sufficient. Mark reproducibility honestly when a credible observation cannot yet be reproduced.

## Brief and readiness judgment

Use the host's native template and [templates.md](templates.md) as writing aids, not mandatory empty headings. Curator delivers an executable Brief rather than leaving clarification to Coordinator.

- **Bug:** expected behavior and repair boundary must be clear. Restore already confirmed behavior without asking again merely because the fix changes the current faulty behavior. Record credible but unreproduced observations and their evidence limitations.
- **Feature/Requirement/Improvement:** an authorized user must have confirmed the goal and decision to enter development. A mentioned implementation idea is not a confirmed design. Important unresolved tradeoffs use needs-attention with reason `decision`.
- **Question:** record the question and answer when tracking is useful; do not manufacture engineering scope or ready state.
- **Duplicate/already tracked:** update the canonical item with substantive new evidence and preserve its current owner, state, and notification history.

Curator checks that expected behavior, scope, acceptance, and minimum verification are clear and proportionate. Do not require E2E or real-model tests for every item, and do not reduce a complex stateful task to "tests pass." Note real environment or authorization gaps. Priority reflects impact and deadline; risk reflects failure consequences; neither replaces verification.

When these conditions are met, Curator assigns or advances the host-declared Brief revision, records **Curator accepted** through the host's admission mapping, and requests Gatekeeper review. Material Brief changes require a new revision and acceptance before resubmission; editorial changes preserve the current revision. Curator acceptance alone never sets ready. Include any explicitly authorized urgency and the existing Coordinator contact in that request. When a human decision is missing, use needs-attention with reason `decision` and the protocol's notification rules instead of requesting Gatekeeper approval as a substitute.

## Gatekeeper technical fact check

Gatekeeper receives the Curator-accepted item, independently reads its latest Brief and source evidence, and checks only what is needed to validate readiness. It does not rediscover the item, broaden scope, rewrite the Brief, or repeat Curator's editorial work.

The fact check must answer:

1. Is the claimed behavior actually supported by current source, tests, reproduction, or explicitly identified verification gaps?
2. Are confirmed facts, hypotheses, and unknowns distinguished? Is the evidence current and relevant to the candidate behavior?
3. Are the affected domain, ownership boundary, expected behavior, and proposed repair direction consistent with authoritative design?
4. Is the item a coherent deliverable without hidden dependencies, overlapping owners, or an unverified root-cause merge?
5. Are acceptance and minimum verification concrete, proportionate, and capable of detecting the reported failure?
6. Is execution authorized, with no unresolved product/architecture decision or external-side-effect assumption hidden in readiness?

Gatekeeper runs only a focused check that can change its decision. It does not repeat an already reliable full test suite or perform implementation. Its conclusion uses one of these outcomes:

- **Approved:** evidence and readiness are sufficient. Gatekeeper records approval and, if the item remains unowned and otherwise eligible, performs the native ready transition. Do not send it back for a redundant Curator state update.
- **Needs evidence:** a specific fact, reproduction, source reference, or verification condition is missing. Identify the smallest decisive evidence and leave the item unready.
- **Needs attention:** a human decision, authorization, resource action, or persistent blocker remains. Curator records the reason and notification; Gatekeeper does not choose or invent technical facts.
- **Not confirmed:** the alleged defect or premise is not supported. Do not admit it as a Bug; Curator may retain a question/investigation item or close it with evidence as authorized.

Approval records the checked Brief revision and decisive evidence. After a material Brief change, Curator advances the revision and reaccepts the Brief, staling that approval; Gatekeeper then rechecks only the changed readiness judgment and its effects, without rediscovering unchanged facts. Gatekeeper returns the actual decision to the original Curator for the user-facing receipt; rejection includes the precise reason so Curator can correct or clarify and resubmit. Do not create a replacement role or reset the item's ownership history.

## Existing ready items and dispatch

Items admitted before this two-gate protocol must be rechecked by Curator and then Gatekeeper before new Coordinator claims. Do not treat legacy ready state as a skipped first gate. Already claimed or in-progress work remains with its valid owner and is checked only when its actual stage requires it.

For explicitly authorized urgent Handoff, Gatekeeper queues the item reference once to the existing Coordinator only after recording approval, setting ready, and confirming no valid Claim. Check the exact Session and use a non-interrupting, deduplicated handoff. Queue acceptance is not delivery. Curator does not also dispatch the same item. Never bypass admission, create another Coordinator, or interrupt a paused Session.

Curator's normal response is a concise item link, goal, and actual state. Report a real blocker or decision only when one remains; do not reproduce the Brief or investigation log.
