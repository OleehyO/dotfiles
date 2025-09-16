# Universe Engineering Guideline

## Environment & Dependencies
- Use Python 3.11 and manage the toolchain with [`uv`](https://github.com/astral-sh/uv).
- Install and sync dependencies via `uv sync`; avoid `pip install` so the environment stays locked to `uv.lock`.
- When a new dependency is needed, add it to `pyproject.toml`, run `uv sync`, and document the change in your pull request or review notes.
- Execute ad-hoc scripts with `uv run <command>` (for example, `uv run python examples/demo_toolset.py`) to ensure they run inside the managed environment.

## Running & Testing Projects
- Interactive demos: `uv run python examples/demo_toolset.py` or specify a demo such as `uv run python examples/demo_webpage_runtime.py`.
- Automated tests: run the full suite with `uv run pytest`; use `uv run pytest --maxfail=1 -q` for fast feedback during development.
- Packaging / release validation: run `uv build` before tagging or publishing.
- New features must ship with pytest cases under `tests/`, following the `test_*.py` naming convention and mirroring the module structure.
- Async runtimes and gameplay integrations should include scenario-driven tests covering registry hooks, observation models, and reload/teardown paths (see `tests/test_demo_toolset.py` for patterns).
- Update fixtures, snapshots, or assets (e.g., under `output/`) whenever behavior changes to keep expectations aligned.

## Coding Standards
- Follow Python 3.11 syntax with four-space indentation and type hints on public functions.
- Default to double-quoted strings and keep lines under 120 characters.
- Run `uv run ruff check .` and `uv run ruff format webgame tests` before pushing to satisfy linters and formatters.
- Organize modules according to the repository structure documented in `AGENTS.md`: core logic in `webgame/`, games under `webgame/games/`, wrappers in `webgame/wrappers/`, etc.

## Commit Crafting
- Write commit messages in English using the format `✨ [feat]: Short summary`—emoji + space + bracketed tag + colon + sentence-case summary under 72 characters.
- Choose tags that match the intent (`🐛 [fix]`, `📝 [docs]`, `♻️ [refactor]`, `🔧 [chore]`, etc.); reference `.claude/agents/commit-crafter.md` for the full catalog.
- Favor atomic commits that each compile, pass tests, and address a single logical concern. If the diff spans multiple concerns, split it before committing.
- Include optional body text explaining motivation or follow-up steps when the change warrants extra context.
- Rebase or squash fix-up commits locally so the published history remains clean and review-friendly.