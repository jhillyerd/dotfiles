function fish_greeting
  if test -f /proc/loadavg
    echo (uname -a | cut -d' ' -f1-3)'; load:' \
    (cat /proc/loadavg | cut -d' ' --output-delimiter=', ' -f1-3)
  end
  if test -x /usr/bin/prodcertstatus
    /usr/bin/prodcertstatus
  end
end
