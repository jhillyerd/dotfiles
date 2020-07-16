function epoch -d "Displays several resolution of timestamp"
  set -l nanos (date +%s%N)
  set -l micros (math -s0 $nanos / 1000)
  set -l millis (math -s0 $micros / 1000)
  set -l seconds (math -s0 $millis / 1000)

  echo "Nanos:  " $nanos
  echo "Micros: " $micros
  echo "Millis: " $millis
  echo "Seconds:" $seconds
end
