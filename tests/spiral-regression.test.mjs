import assert from "node:assert/strict";
import { test } from "node:test";
import * as c from "../js-out/calcit.core.mjs";
import { store } from "../js-out/app.schema.mjs";
import { updater } from "../js-out/app.updater.mjs";
// Published Phlox initializes browser input state during import. Provide host
// fixtures only; use the actual generated application and Phlox modules.
globalThis.window = { navigator: { userAgent: "Node regression fixture" }, innerWidth: 800, innerHeight: 600, addEventListener() {} };
const { gen_spiral_trail, comp_spiral, comp_cloud, comp_container } = await import("../js-out/app.comp.container.mjs");
const t = c.init_tags(["keyboard-on?", "counted", "x", "states", "editor", "data", "tab", "props", "ops", "children", "position", "alpha", "move-to", "line-to", "toggle-keyboard", "add-x", "hydrate-storage"]);
const get = (x, key) => c.option_$o_unwrap(c.get(x, key));
const nth = (x, i) => c.option_$o_unwrap(c.nth(x, i));
const op = (tag, ...args) => c._$o__$o_(tag, ...args);
test("generated spiral trail preserves exact finite coordinates and bounds", () => {
  const trail = gen_spiral_trail(20, 600);
  assert.equal(c.count(trail), 580);
  assert.equal(c.count(gen_spiral_trail(4, 4)), 0);
  for (const [index, i] of [[0, 20], [579, 599]]) {
    const p = nth(trail, index);
    assert.equal(c.count(p), 2);
    assert.ok(Math.abs(nth(p, 0) - (i * 0.6 * Math.cos(i * 0.03) + 60 * Math.cos(i * 0.18))) < 1e-9);
    assert.ok(Math.abs(nth(p, 1) - (i * 0.6 * Math.sin(i * 0.03) + 60 * Math.sin(i * 0.18))) < 1e-9);
  }
});
test("spiral drawing commands pass coordinate Lists, not Options", () => {
  const node = comp_spiral(c._$n__$M_(t.position, c._$L_(10, 20)));
  const props = get(node, t.props);
  const ops = get(props, t.ops);
  assert.equal(c.count(ops), 581);
  assert.equal(nth(nth(ops, 1), 0), t["move-to"]);
  assert.ok(c._$e_(nth(nth(ops, 1), 1), nth(gen_spiral_trail(20, 600), 0)));
  for (const item of ops.toArray().slice(1)) {
    assert.ok(c.list_$q_(nth(item, 1)));
    assert.equal(c.count(nth(item, 1)), 2);
  }
  assert.ok(c._$e_(get(props, t.position), c._$L_(10, 20)));
  assert.equal(get(props, t.alpha), 0.2);
  assert.ok(c.count(get(get(comp_cloud(c._$n__$M_(t.position, c._$L_(0, 0))), t.props), t.ops)) > 2);
  assert.equal(c.count(get(comp_container(store), t.children)), 1);
});
test("keyboard toggling and counter retain update raw-payload semantics", () => {
  let next = updater(store, op(t["toggle-keyboard"], null), "fixture", 0);
  assert.equal(get(next, t["keyboard-on?"]), true);
  next = updater(next, op(t["toggle-keyboard"], null), "fixture", 0);
  assert.equal(get(next, t["keyboard-on?"]), false);
  next = updater(next, op(t.counted, null), "fixture", 0);
  next = updater(next, op(t.counted, null), "fixture", 0);
  assert.equal(get(next, t.counted), 2);
});
test("x wraps at its existing boundary and nested state retains store", () => {
  let next = c.assoc(store, t.x, 10);
  next = updater(next, op(t["add-x"], null), "fixture", 0);
  assert.equal(get(next, t.x), 11);
  next = updater(next, op(t["add-x"], null), "fixture", 0);
  assert.equal(get(next, t.x), 0);
  next = updater(next, op(t.states, c._$L_(t.editor), "draft"), "fixture", 0);
  assert.equal(get(next, t.x), 0);
  assert.equal(get(get(get(next, t.states), t.editor), t.data), "draft");
  assert.ok(c._$e_(updater(store, op(t["hydrate-storage"], next), "fixture", 0), next));
});
