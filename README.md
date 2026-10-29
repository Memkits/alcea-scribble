
Alcea Scribble
----

scribe shapes...

### Usage

_TODO_

### Workflow

https://github.com/Phlox-GL/phlox-workflow

### Development

使用者注意：CLI / procs 必须配对正式 **0.32.1**，重新安装依赖、重启开发服务并刷新页面。
正式依赖图为 Phlox 0.8.0，传递 Touch Control 0.0.35 / JS FFI 0.2.9 /
Pointed Prompt 0.0.24。Pixi 仍为 7.4.3，bottom-tip 仍为正式 0.1.5。
13 个定义的代码、schema、测试和示例与迁移前相同；只由官方 CLI 规范 Snapshot
存储格式，不重复改写类型。螺旋坐标、绘图命令、状态 Map、字体和两处 `hud!` 保留。

本轮真实 Caps strict、工具链配对、168 个全定义、13 个公开定义、完整 strict
（diagnostics=[]）、原四项 Node 业务测试、canonical、不可变安装与前端构建通过。
实际 IAB 初次绘制和刷新后的螺旋正常，warn/error 为空；视口顶部仍裁切部分线条。
HMR、窗口缩放、移动端和其他浏览器未复验，不把本轮结果用于声明 Phlox #71 已修复。
Yarn 使用统一 60 分钟依赖年龄门禁，移除过时 procs 0.27.0 豁免。
COS 与 rsync action 使用已核对指向原提交的精确正式 tag；tag 可移动，沿用已接受的风险。
只改 action 引用，不改变上传条件、目录、权限或服务器路径。

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
