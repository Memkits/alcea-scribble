import assert from "node:assert/strict";
import { test } from "node:test";
import { checkCdnPath } from "./check-cdn-path.mjs";
const base = "https://cos-sh.tiye.me/Memkits/alcea-scribble/pr/";
const entry = `<script src="${base}assets/main.js"></script>`;
test("accepts generated JS/CSS and existing fonts", () => {
  checkCdnPath(`${entry}<link href="${base}assets/main.css"><link href="https://cdn.tiye.me/favored-fonts/main-fonts.css">`, base);
});
test("rejects relative, production and unrelated script paths", () => {
  for (const url of ["./assets/main.js", "https://cos-sh.tiye.me/Memkits/alcea-scribble/assets/main.js", "https://example.com/js"]) assert.throws(() => checkCdnPath(`${entry}<script src="${url}"></script>`, base));
});
test("requires entry and HTTPS base, ignores development comments", () => {
  assert.throws(() => checkCdnPath("", base));
  assert.throws(() => checkCdnPath(entry, "./"));
  checkCdnPath(`${entry}<!-- <link href="http://localhost:8100/main-fonts.css"> -->`, base);
});
