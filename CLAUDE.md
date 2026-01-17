When updating individual tool installer in @.config/zsh/install/, remember to also update @.config/zsh/install/install_all.zsh if the tool details (name or script path) have changed.

Never stage private files (@.private.zsh, @.config/zsh/install/install_private.zsh) for commit - they contain sensitive information that should not be committed.

Workflow preference: Use branchless workflow - do not checkout or switch branches. All work should be based directly on PRs without creating/switching branches.