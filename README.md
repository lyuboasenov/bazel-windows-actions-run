# Problem definition

When running an action from a custom bazel rule on Windows. The execution root path is contained in the subcommand. This makes remote cache sharing impossible if the repository is not cloned at the same path.

```powershell

PS C:\Users\lasenov\git\bazel-windows-actions-run> bazel build //package:run
INFO: Analyzed target //package:run (1 packages loaded, 2 targets configured).
INFO: Found 1 target...
SUBCOMMAND: # //package:run [action 'Action package/logs/package.log', configuration: f6d2379e6d32ace3209294617f515fb6db597da05c6fef8607024221c1b5f9b1, execution platform: @local_config_platform//:host]
cd /d C:/users/lasenov/_bazel_lasenov/uiggnarq/execroot/__main__
powershell.exe -ExecutionPolicy Bypass -NonInteractive -NoProfile -Command & ./package/build.ps1 *>&1 | tee bazel-out/x64_windows-fastbuild/bin/package/logs/package.log -append
# Configuration: f6d2379e6d32ace3209294617f515fb6db597da05c6fef8607024221c1b5f9b1
# Execution platform: @local_config_platform//:host
INFO: From Action package/logs/package.log:
Hello world
Target //package:run up-to-date:
  bazel-bin/package/logs/package.log
INFO: Elapsed time: 0.842s, Critical Path: 0.55s
INFO: 2 processes: 1 internal, 1 local.
INFO: Build completed successfully, 2 total actions

```