# MAR Forge

面向 MAR 托管工程工作的 Agent-first 规划、准入、代码审查、验证交付与恢复 Skill。

**Strict admission enables bold autonomy: every task that enters Forge is driven through to verified delivery.**

[English](README.md)

## 能力

MAR Forge 是用于 MAR 托管 Workspace 的通用 Agent Skill，覆盖临时专项审查、连续 Commit 审查、Issue 准入、协同实现、独立验证、Fix Loop、本地集成和中断恢复。

标准 Handoff 链路：

`Inspector -> Curator -> Gatekeeper -> Coordinator -> Fixer -> Verifier`

Curator 接收与 Gatekeeper 批准是两道独立门禁，均通过后才允许无 owner 的工作项进入 ready。Gatekeeper 只做有边界的技术事实核查，不重写 Brief，也不增加新的协调层。

Skill 维护通用角色与工程判断；使用仓仅保留 Issue 命令、Session 绑定、仓库/分支映射、工程与测试规则、通知接收人、证据路径和实际用户授权。

## 环境要求

- MAR 托管的 Workspace 与 MAR-hosted Runner。
- 使用仓提供通用角色及 Work Item 语义到本项目的绑定。

MAR 是本 Skill 的头号用户，不支持独立非 MAR Runtime。Forge 不替代产品设计、工程规范、测试或用户授权。

## 使用 npx 安装

```bash
npx skills add myagentroam/mar-forge --skill mar-forge -a universal --copy
```

分发内容是根级 `SKILL.md` 与按需读取的 references，不需要 npm 包、插件、服务或运行时依赖。

## 使用方式

在 `ship forge`、Inspector 审查、Curator 接收、Gatekeeper 准入或 Coordinator 交付时加载 `mar-forge`。先读 `SKILL.md`，再按任务选择 reference：

| Reference                 | 职责                                            |
| ------------------------- | ----------------------------------------------- |
| `references/protocol.md`  | 入口、工作项状态、ownership、证据、恢复与决策   |
| `references/inspector.md` | 专项与连续 Commit 审查、本地断点及 Finding 质量 |
| `references/admission.md` | Curator 接收与 Gatekeeper 独立技术准入          |
| `references/delivery.md`  | Coordinator 编排、Fixer/Verifier、集成与清理    |
| `references/templates.md` | 可选 Brief、准入、派发、审查与决策模板          |

`ship forge` 默认表示完整授权的本地交付：准入、实现、验证、独立审查、必要任务 commit 和变更仓库的本地集成；不包含 push、部署、发布、生产变更或外部回复。

## 维护

除中文 README 外，受跟踪内容与 commit message 使用英文。通用工作流只在本 Skill 维护，不写入具体仓库事实，也不在使用仓另建平行 SOP。

## 许可

Apache License 2.0，详见 [LICENSE](LICENSE) 与 [NOTICE](NOTICE)。
