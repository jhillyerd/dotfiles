import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Default the bifrost/smart model to medium thinking.
export default function (pi: ExtensionAPI) {
  pi.on("model_select", async (event) => {
    if (event.model.provider === "bifrost" && event.model.id === "smart") {
      if (pi.getThinkingLevel() !== "medium") {
        pi.setThinkingLevel("medium");
      }
    }
  });
}
