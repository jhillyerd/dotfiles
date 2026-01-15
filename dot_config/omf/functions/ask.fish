function ask -d "Get quick help from local llama.cpp"
  set -l endpoint "https://llm.bytemonkey.org/v1/chat/completions"
  set -l system_prompt "You are a helpful command-line assistant. Provide brief, practical answers focused on shell commands and terminal usage. Prefer showing example commands over lengthy explanations. Be concise."

  if test (count $argv) -eq 0
    read -P "ask: " prompt
    if test -z "$prompt"
      return 1
    end
  else
    set prompt (string join " " $argv)
  end

  # Read from stdin if no arguments or if - is passed
  if test "$prompt" = "-"
    set prompt (cat)
  end

  set -l payload (jq -n \
    --arg system "$system_prompt" \
    --arg prompt "$prompt" \
    '{
      messages: [
        {role: "system", content: $system},
        {role: "user", content: $prompt}
      ],
      temperature: 0.6
    }')

  curl -s "$endpoint" \
    -H "Content-Type: application/json" \
    -d "$payload" \
    | jq -r '.choices[0].message.content' \
    | glow
end
