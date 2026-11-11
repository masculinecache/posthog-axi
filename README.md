# posthog-axi

Agent-ergonomic PostHog CLI wrapper with TOON output — feature flags, experiments, analytics, and insights.

Wraps [`@posthog/cli`](https://www.npmjs.com/package/@posthog/cli) in an AXI-compliant interface: TOON-formatted output, minimal default schemas, content truncation, structured errors, and no interactive prompts.

## Install

```bash
npm i -g @masculinecache/posthog-axi
```

Requires `@posthog/cli` on PATH:

```bash
npm i -g @posthog/cli
```

## Setup

```bash
export POSTHOG_CLI_API_KEY="phx_..."      # or POSTHOG_PERSONAL_API_KEY
export POSTHOG_CLI_PROJECT_ID="12345"      # or POSTHOG_PROJECT_ID
export POSTHOG_CLI_HOST="https://us.posthog.com"  # optional, defaults to US
```

## Usage

```
$ posthog-axi
bin: ~/.local/bin/posthog-axi
description: Agent-ergonomic PostHog CLI wrapper with TOON output
version: 0.1.0

commands[7]{command,description}:
  tools,List available PostHog API tools
  search <pattern>,Search tools by name or description
  info <tool>,Show tool description and input schema
  schema <tool> [path],Drill into a nested schema field
  call <tool> '<json>',Execute a tool with JSON input
  flags,Manage feature flags (list, get, toggle)
  insights,List and inspect insights and dashboards
```

### Feature flags

```bash
posthog-axi flags list
posthog-axi flags get my-flag-key
posthog-axi flags toggle my-flag-key on
posthog-axi flags toggle my-flag-key off
```

### Insights

```bash
posthog-axi insights
```

### Direct API

```bash
posthog-axi tools
posthog-axi search "feature flag"
posthog-axi info listFeatureFlags
posthog-axi schema listFeatureFlags
posthog-axi call listFeatureFlags '{}'
```

## AXI compliance

- TOON output on stdout
- Minimal default schemas (3-4 fields in lists)
- Structured errors with actionable suggestions on stdout
- No interactive prompts
- Content-first home view
- `--help` on every subcommand

## License

MIT
