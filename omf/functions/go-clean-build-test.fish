function go-clean-build-test -d "go clean, build, test"
  echo "## Clean"
  if go clean ./...
    echo "## Build"
    if go build ./...
      echo "## Test"
      go test ./...
    end
  end
end
