# Notify when specific long-running tasks exit.
#
# It is invoked by the fish shell automatically using its event system.
function __postexec_notify_on_long_running_commands --on-event fish_postexec
  # Must be first to not overwrite $status.
  if test $status -eq 0
    set --function label Success
  else
    set --function label Failed
  end

  set --function monitor_commands cargo go make
  set --function command (string split ' ' $argv[1])

  if test -z "$DISPLAY"
    return
  end

  if not contains $command $monitor_commands
    return
  end

  if test $CMD_DURATION -gt 5000
    notify-send --expire-time=10000 "$label: $argv"
  end
end
