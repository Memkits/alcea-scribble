
Alcea Scribble
----

scribe shapes...

### Usage

_TODO_

### Workflow

https://github.com/Phlox-GL/phlox-workflow

### Development

本地开发使用正式 Calcit 和 `@calcit/procs` **0.40.0**。升级后请重装依赖、重建并刷新。螺旋绘图、字体等待、页面错误 HUD 和前端部署路径保持原行为。

正式模块为 Phlox 0.9.3、Touch Control 0.0.39、JS FFI 0.2.13 和 Pointed Prompt 0.0.27。应用内部通过具名 `Store` 和 `Op` 更新状态，渲染直接使用具名派发。未传入绘图位置时由 Pixi 使用默认原点。

Chrome 隔离预览已验证螺旋绘图、刷新和窗口缩放，字体使用本地替身。其他浏览器的显示差异见 [Phlox #71](https://github.com/Phlox-GL/phlox/issues/71)。

Use `caps --strict --ci`, `yarn install --immutable`, `caps verify --toolchain`,
`yarn build`, and `node --test tests/*.test.mjs`. Only `calcit.cirru` and
`deps.cirru` are canonical; CI rejects retired `compact.cirru` / `package.cirru`.
完整 strict、原有五个 namespace 的公开定义检查与原四项 Node 业务测试都保留。
旧 Phlox 的依赖冲突由新正式依赖图解决（[Phlox #62](https://github.com/Phlox-GL/phlox/issues/62)）；
本地候选链接不等同正式依赖解析，合并前以最新 CI 的 fresh Caps strict 为准。
HTML reference and public upload verification use the released v1.2.0 cos-upload-action's built-in verify settings,
with no extra CDN checker. Original server deployment
paths, external fonts and the actual spiral drawing remain unchanged.

`yarn dev` compiles Calcit once before starting Vite. For live Calcit edits, run
`calcit calcit.cirru js -w` in another terminal; no process manager is needed.
Builds use `VITE_BASE_URL`, defaulting to relative URLs locally. PR previews use
`pr/<number>/<run-id>/<attempt>/` to isolate uploads, while the production prefix
stays unchanged. The COS action's built-in verification replaces the standalone
CDN build test; all spiral, drawing-command and updater business tests remain.

### License

MIT
