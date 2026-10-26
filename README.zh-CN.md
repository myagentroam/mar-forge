# MAR Forge

面向 MAR 托管工程工作的 Agent-first 审查、准入、协同交付、验证与恢复 Skill。

**Forge autonomy through automation, minimizing human attention while preserving human judgment.**

严格准入支撑大胆自治：每个已准入的 Handoff 工作项都应被推进到经过验证的交付。

[English](README.md)

## 能力

MAR Forge 是用于 MAR 托管 Workspace 的可复用 Agent Skill，以一套协议覆盖临时专项审查、连续 Commit 审查、Issue 准入、协同实现、独立验证、Fix Loop、本地集成和中断恢复。

### 适用条件

Forge 采用显式 opt-in，不是 MAR 的默认开发行为。只有用户显式调用 Forge、仓库／Workspace 以自然语言明确声明使用 Forge，或续作既有 Forge 工作流／角色 Session 时才加载。没有这些信号的普通代码审查、实现、测试、规划和本地交付不进入 Forge。误加载不代表启用 Forge，非 Forge 项目也无需增加反向声明。

### 执行流程

```text
用户 / 外部来源 / Inspector / 其他来源
                    │
                    ▼
                 Curator
                    │ 接收
                    ▼
                Gatekeeper
                    │ 批准
                    ▼
                  ready
                    │
               Coordinator
                    │
                    ▼
             ┌──► Fixer ──► Verifier
             │                 │
             └── 阻断发现 ─────┤
                               │ PASS
                               ▼
                         授权内集成
```

Inspector 是可选来源，不是必经入口。Coordinator 协调每个阶段和 Fix Loop，Worker 之间不直接协调。Curator 是 Forge 的接收角色，admission 由 Curator 接收与 Gatekeeper 批准两道门禁组成。

明确交给当前 Session 的工作使用独立入口：

```text
明确的当前 Session 任务 ──► Continue ──► 授权内交付
```

Continue 不经过 Curator 或 Gatekeeper；Handoff 必须通过两道准入门禁，无 owner 的工作项才能进入 ready。

## Runtime 边界与非目标

```text
MAR Runtime
Session / Agent 网络 / queue / steer / Runner
                    │
                    ▼
MAR Forge
角色 / 准入 / ownership / 交付 / 验证 / 恢复
                    │
                    ▼
仓库绑定
命令 / 分支 / 测试 / 模型 / 证据 / 授权
```

MAR 是本 Skill 的目标 Runtime，不支持独立非 MAR Runtime。Forge 不是 MAR 的默认工程协议，不提供 Session 原语、产品需求、仓库工程规范、测试、凭据或新权限，也不替代权威设计；Issue 本身不构成授权。

## 环境要求

- MAR 托管的 Workspace 与 MAR-hosted Runner。
- 使用仓提供可复用角色及 Work Item 语义到本项目的绑定。

### 宿主绑定

| 绑定      | 仓库维护的事实                                 |
| --------- | ---------------------------------------------- |
| 适用性    | 根指令中使用 Forge 的自然语言声明              |
| Work Item | 跟踪器、仓库、命令、labels 与原生状态映射      |
| Session   | 角色身份、Runner 模型/effort 与 queue/控制语义 |
| 仓库      | 远端、分支、依赖顺序及指针/内容关系            |
| 执行      | Workspace 隔离、commit 机制与授权交付点        |
| 工程      | 源码路由、权威设计、验证与清理规则             |
| 证据      | 被忽略的报告、恢复记录与 Inspector 断点位置    |
| 决策      | 通知接收人、授权渠道与去重约定                 |

## 使用 npx 安装

```bash
npx skills add myagentroam/mar-forge --skill mar-forge -a universal --copy
```

分发内容是根级 `SKILL.md` 与按需读取的 references，不需要 npm 包、插件、服务或运行时依赖。

## 使用方式

显式调用、正向宿主绑定或既有 Forge 续作确认适用后，先读 `SKILL.md`，再只加载当前任务需要的 references。不要仅因普通任务提到 review、inspection、测试、实现或交付就选择 Forge：

| 任务                       | References                                                    |
| -------------------------- | ------------------------------------------------------------- |
| 仅 Inspector               | `inspector.md`；仅转交/恢复时增加 `protocol.md`               |
| 准入                       | `protocol.md` + `admission.md`                                |
| Coordinator / `ship forge` | `protocol.md` + `delivery.md`；仅准入协调或恢复时加 admission |
| 模板                       | 需要对应记录时才读取 `templates.md`                           |

References 位于 `references/`。`ship forge` 默认表示完整授权的本地交付：准入、实现、验证、独立审查、必要任务 commit 和变更仓库的本地集成；不包含 push、部署、发布、生产变更或外部回复。

## 维护

除中文 README 外，受跟踪内容与 commit message 使用英文。可复用工作流只在本 Skill 维护，不写入具体仓库事实，也不在使用仓另建平行 SOP。

### 协议版本化

只有 `develop` 分支时，Forge 仍处于预发布状态。稳定发布前应使用 `main` 保存经过审查的稳定版本、`develop` 继续集成，并为协议版本打 tag。采用语义化版本：不兼容的协议行为变更提升 major，向后兼容的能力新增提升 minor，澄清与修正提升 patch。持续移动的 `develop` 不是稳定协议版本。

## 许可

Apache License 2.0，详见 [LICENSE](LICENSE) 与 [NOTICE](NOTICE)。
