def ps_run_impl(ctx):
   """Implementation of the Bazel - PowerCLI build adapter rule.

   This rule invokes the "script" attribute in a PowerShell session
   passing the "srcs" attribute and transitive output files as inputs
   to an action run (ctx.action.run).

   Args:
      ctx: https://bazel.build/rules/lib/builtins/ctx

   Returns:
      A collection of transitive output files.
   """

   output_log = ctx.actions.declare_file("logs/%s.log" % ctx.label.package)

   command_args = "& ./%s *>&1 | tee %s -append" % (
         ctx.file.script.path,
         output_log.path
         )

   args = ctx.actions.args()
   args.add('-ExecutionPolicy', 'Bypass')
   args.add('-NonInteractive')
   args.add('-NoProfile')
   args.add('-Command', '%s' % command_args)

   ctx.actions.run(
      inputs =  depset(ctx.files.srcs),
      outputs = [output_log],
      executable = "powershell.exe",
      arguments = [args],
   )

   return [DefaultInfo(files = depset([output_log]))]

ps_run = rule(
   implementation = ps_run_impl,
   attrs = {
      "script": attr.label (
         allow_single_file = [".ps1"],
         mandatory = True,
         ),
      "deps": attr.label_list(allow_files = False),
      "srcs": attr.label_list(allow_files = True),
   },
)