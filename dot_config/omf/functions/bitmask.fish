function bitmask -a input_value -d "Decomposes bitmask values"
  set rem $input_value # Remainder of input_value
  set index 0 # Index of current bit
  set value 1 # Value of current bit

  while [ $rem != 0 ]
    if [ (math "bitand($rem, 1)") = 1 ]
      # Bit is set
      set rem (math "$rem - 1")
      echo "[$index] $value (remainder: $rem)"
    end

    # Move to next bit
    set rem (math "$rem / 2")
    set index (math "$index + 1")
    set value (math "$value * 2")
  end
end

