function noplan -a job -d "Run nomad plan and if confirmed, run with check-index"
  set nomad_args "-hcl2-strict=false"

  if test -z "$job"
    echo "Usage: noplan <job-file>"
    return 1
  end

  if not test -f "$job"
    echo "Error: $job is not a file"
    return 1
  end

  set -l tmpfile (mktemp)
  nomad plan -force-color $nomad_args $job | tee $tmpfile

  set -l index (string match -r "Job Modify Index: [0-9]+" < $tmpfile | string match -r "[0-9]+" | head -1)
  rm $tmpfile

  if test -z "$index"
    echo "Could not find Job Modify Index"
    return 1
  end

  echo ""
  echo "Detected modify index: $index"
  read -P "Apply? (y/n): " confirm

  if test "$confirm" = "y"
    nomad job run -check-index $index $nomad_args $job
  else
    echo "Cancelled"
  end
end
