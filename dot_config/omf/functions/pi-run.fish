function pi-run -a binary -d "Copy binary to pi and run it"
  if test -z "$binary" -o -z "$PI_SSH_HOST" -o -z "$PI_BIN_DIR"
    echo "Usage: pi-run <binary> [arg-1 .. [arg-N]]"
    echo "  will scp <binary> into \$PI_BIN_DIR on \$PI_SSH_HOST and run it with sudo."
    echo "  Above env variables must be set, or you'll see this message."
    return 1
  end
  scp $binary $PI_SSH_HOST:$PI_BIN_DIR/
  ssh -t $PI_SSH_HOST sudo $PI_BIN_DIR/$binary $argv[2..-1]
end
