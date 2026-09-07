import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Default the dgx1 qwen model to medium thinking.
export default function (pi: ExtensionAPI) {
  pi.on("model_select", async (event) => {
    if (event.model.provider === "dgx1" && event.model.id === "qwen") {
      if (pi.getThinkingLevel() !== "medium") {
        pi.setThinkingLevel("medium");
      }
    }
  });
}
