Make a standardized commit with detailed messages for staged changes.

# Commit Message Convention
## Format Structure

```
[tag] Brief description (max 50 chars)

Optional detailed description (wrap at 72 chars)

Optional footer with issue references, breaking changes, etc.
```

## Tags

### Core Tags
- **[feat]** - New feature or enhancement
- **[fix]** - Bug fix
- **[refactor]** - Code refactoring without changing behavior
- **[docs]** - Documentation updates
- **[test]** - Adding or updating tests
- **[style]** - Code style changes (formatting, semicolons, etc.)
- **[perf]** - Performance improvements
- **[chore]** - Build process, tooling, or auxiliary changes
- **[misc]** - Miscellaneous changes that don't fit other categories

### Specialized Tags
- **[config]** - Configuration file changes
- **[deps]** - Dependency updates (package.json, requirements, etc.)
- **[security]** - Security-related fixes or improvements
- **[hotfix]** - Critical bug fixes requiring immediate deployment
- **[revert]** - Reverting previous commits
- **[merge]** - Merge commits
- **[release]** - Release version updates

## Examples

### Good Examples
```
[feat] Add fuzzy finder integration for file navigation

Implement fzf-based file and directory jumping with
Ctrl+T keybinding for quick access across the filesystem.

Closes #42
```

```
[fix] Resolve alias conflict with system find command

Remove 'find' alias to fd to prevent compatibility issues
when system scripts expect standard find behavior.

Fixes #15
```

```
[refactor] Simplify proxy management functions

Consolidate set_proxy, unset_proxy, and show_proxy into
a single proxy command with subcommands for better UX.

BREAKING CHANGE: Old proxy functions removed, use new
proxy command instead.
```

```
[docs] Update macOS installation instructions

Add detailed steps for iTerm2 setup and font configuration
for Nerd Font compatibility.
```

### Bad Examples
```
update stuff
```

```
fixed bug
```

```
WIP: working on things
```

## Guidelines

### Subject Line
- Use imperative mood ("Add feature" not "Added feature")
- Capitalize first letter after the tag
- Keep under 50 characters
- No period at the end

### Body
- Separate from subject with blank line
- Wrap at 72 characters
- Explain what and why, not how
- Use bullet points for multiple changes

### Footer
- Reference issues with "Closes #123" or "Fixes #456"
- Mark breaking changes with "BREAKING CHANGE:"
- Add co-authors with "Co-authored-by:"

## Special Cases

### Breaking Changes
```
[feat] Change default shell theme configuration

Switch from powerlevel10k to starship for cross-platform
consistency and better performance.

BREAKING CHANGE: Users must install starship and run
`starship preset plain-text-symbols` to maintain prompt
appearance. Old powerlevel10k configuration will be ignored.
```

### Reverts
```
[revert] Revert "[feat] Add experimental zsh plugin"

This reverts commit abc123def456, which introduced
performance issues with large repositories.
```

### Multi-tag Commits
For changes spanning multiple categories, use the primary impact:
- Code changes take precedence over documentation
- User-facing changes take precedence over internal changes
- Breaking changes should use the most relevant tag

## Tools Integration

### Git Hooks
Consider using commit hooks to validate format:
```bash
#!/bin/sh
# .git/hooks/commit-msg
if ! grep -qE '^\[([^\]]+)\] .{1,50}$' "$1"; then
    echo "Invalid commit format. Use: [tag] Brief description"
    exit 1
fi
```

### VS Code Integration
Add to `.vscode/settings.json`:
```json
{
  "git.inputValidation": true,
  "git.inputValidationSubjectLength": 50,
  "git.inputValidationLength": 72
}
```

## Common Patterns

### Package Management
```
[deps] Update fzf to version 0.45.0
[chore] Add pre-commit hooks for code formatting
[config] Modify starship.toml for new prompt style
```

### Platform-Specific
```
[feat] Add Linux-specific package manager detection
[fix] Resolve macOS Homebrew path issues on Apple Silicon
[config] Update install scripts for Ubuntu 22.04 compatibility
```

### Documentation
```
[docs] Add troubleshooting guide for proxy configuration
[docs] Update README with new installation steps
[docs] Fix typos in function descriptions
```