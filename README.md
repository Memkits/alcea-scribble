
Alcea Scribble
----

scribe shapes...

### Usage

_TODO_

### Workflow

https://github.com/Phlox-GL/phlox-workflow

### Development

使用者注意：CLI / procs 必须配对为已发布的 **0.30.1-alpha.4**，不是尚未发布的
0.30.1 稳定版。依赖 Phlox 0.7.14 及其正式模块依赖；螺旋坐标、绘图命令、
状态 Map、字体与生产路径不变。移除旧 Unit 占位类型，组件直接返回实际
`phlox.schema/PhloxElement`；开放操作的 payload 按实际使用处检查，不新增强转。

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
