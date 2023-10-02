# Problem definition

When running an action from a custom bazel rule on Windows. The WORKSPACE root path is contained in the subcommand. This makes remote cache sharing impossible if the repository is not cloned at the same path.