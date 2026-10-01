
Alcea Scribble
----

scribe shapes...

### Usage

_TODO_

### Workflow

https://github.com/Phlox-GL/phlox-workflow

### Development

Use Calcit/procs 0.27.0, `caps --ci`, `yarn install --immutable`,
`yarn build`, and `node --test tests/*.test.mjs`. Only `calcit.cirru` and
`deps.cirru` are canonical; CI rejects retired `compact.cirru` / `package.cirru`.
The published Phlox dependency graph still requests conflicting js-ffi versions,
so strict Caps resolution is pending upstream alignment, not claimed complete
([Phlox #62](https://github.com/Phlox-GL/phlox/issues/62)).
HTML reference and public upload verification use the released v1.2.0 cos-upload-action's built-in verify settings,
with no extra CDN checker. Original server deployment
paths, external fonts and the actual spiral drawing remain unchanged.

`yarn dev` compiles Calcit once before starting Vite. For live Calcit edits, run
`calcit calcit.cirru -w` in another terminal; no process manager is needed.
Builds use `VITE_BASE_URL`, defaulting to relative URLs locally. PR previews use
`pr/<number>/<run-id>/<attempt>/` to isolate uploads, while the production prefix
stays unchanged. The COS action's built-in verification replaces the standalone
CDN build test; all spiral, drawing-command and updater business tests remain.

### License

MIT
