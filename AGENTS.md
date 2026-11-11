# posthog-axi — project agent memory

This file is the project's committed home for project-intrinsic agent knowledge.

## GitHub credentials (captain order)

Every GitHub operation on this repo uses the **masculinecache** account only — never global personal credentials.

- `gh`/`gh-axi` calls: export `GH_CONFIG_DIR=$HOME/.config/gh-masculinecache` first; never rely on ambient gh config.
- The committed `.mise.toml` carries this rule for mise-driven shells: `GH_REPO=masculinecache/posthog-axi`, `GH_CONFIG_DIR=$HOME/.config/gh-masculinecache`. If mise is not active, export them by hand.
- `git push` already works as masculinecache via the repo-local credential helper — do not alter it.
- On gh auth failure (403/wrong account): stop and report blocked; never retry with different credentials.

## Architecture

`posthog-axi` is a bash wrapper around `@posthog/cli` (installed separately). It adds:
- TOON-formatted output for list/detail views
- Minimal default schemas (3-4 fields)
- Structured errors on stdout with actionable suggestions
- Convenience commands (`flags`, `insights`) that compose multiple API calls

The `@posthog/cli` binary (`posthog-cli`) is the sole runtime dependency.

## Build / test / package

- Tests: `./tests/run.sh` (stub — asserts help output + version + TOON structure)
- Lint: `shellcheck -S error ./posthog-axi ./tests/run.sh`
- Package: `npm publish --dry-run` verifies tarball contents
- **Version lives in three places**: `POSTHOG_AXI_VERSION` in `./posthog-axi`, `version` in `package.json`, and the assertion in `ci.yml`.
- `npm publish` itself is intentionally never run by agents — publishing is a human/captain action.

## Environment

- `POSTHOG_CLI_API_KEY` (or `POSTHOG_PERSONAL_API_KEY`): required for API calls
- `POSTHOG_CLI_PROJECT_ID` (or `POSTHOG_PROJECT_ID`): required for API calls
- `POSTHOG_CLI_HOST`: optional, defaults to US region
- `POSTHOG_AXI_CLI`: override the posthog-cli binary path

## Maintaining this file

Keep this file for knowledge useful to almost every future agent session in this project.
Do not repeat what the codebase already shows; point to the authoritative file or command instead.
Prefer rewriting or pruning existing entries over appending new ones.

## Git commit identity

Committing agents set `GIT_AUTHOR_NAME`/`GIT_COMMITTER_NAME` to `<model>@<hostname -s>` at commit time.
