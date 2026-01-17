When updating individual tool installer in @.config/zsh/install/, remember to also update @.config/zsh/install/install_all.zsh if the tool details (name or script path) have changed.

**CRITICAL**: Never stage or commit private files (@.private.zsh, @.config/zsh/install/install_private.zsh) - they contain sensitive information and are commonly kept in modified state by the user. Do NOT perform any git operations that might affect these files (reset, stash, etc.) without explicit user permission.

Workflow preference: Use branchless workflow - do not checkout or switch branches. All work should be based directly on PRs without creating/switching branches.