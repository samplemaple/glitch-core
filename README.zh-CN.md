# glitch-core

[English](README.md)

> 跨平台故障艺术 shader 核心 — 19 个 GLSL 效果。
> MIT 开源，随意使用。

## 这是什么？

19 个生产级 GLSL 片元着色器，用于实时故障艺术效果——
像素排序、RGB 通道偏移、扫描线、VHS、CRT、数据损坏模拟等。

为 **[GlitchForge / 噪点实验室](https://glitchforge.pages.dev)** 构建——
一个免费的在线故障艺术工具。本仓库是从中提取的 shader 引擎，
可用于任何平台。

## 效果列表

| # | 效果 | Key | 动画 |
|---|------|-----|:--:|
| 1 | 像素排序 | `pixel-sort` | |
| 2 | RGB 偏移 | `rgb-shift` | |
| 3 | 扫描线 | `scanlines` | |
| 4 | 万花筒 | `kaleidoscope` | |
| 5 | 波浪 | `wave` | |
| 6 | 镜像 | `mirror` | |
| 7 | 双色调 | `duotone` | |
| 8 | 通道反转 | `channel-invert` | |
| 9 | 色相偏移 | `hue-shift` | |
| 10 | 噪点 | `grain` | ✅ |
| 11 | 半色调 | `halftone` | |
| 12 | 像素化 | `pixelate` | |
| 13 | VHS | `vhs` | ✅ |
| 14 | CRT | `crt` | ✅ |
| 15 | 8-Bit | `8bit` | |
| 16 | 边缘检测 | `edge-detect` | |
| 17 | 亮度/对比度/饱和度 | `brightness` | |
| 18 | 数据损坏 | `data-glitch` | |
| 19 | 拉伸撕裂 | `stretch` | |

## 快速开始

```bash
git clone https://github.com/samplemaple/glitch-core.git
cd glitch-core/web/demos
# 用浏览器直接打开任意 .html 文件——无需构建，无需服务器
open 01-pixel-sort-rgb-shift-scanlines.html
```

每个 demo 是独立的 HTML 文件，内嵌 WebGL 样板代码。
上传图片、切换效果、拖动滑块——即时预览。

## 仓库结构

```
glitch-core/
├── shaders/          ← 19 个 GLSL 片元着色器 + 1 个顶点着色器
│                      与平台无关，被下方所有平台共用
├── SPEC.md           ← 效果规格文档 — uniform、类型、范围
├── web/              ← 平台：Web
│   ├── README.md
│   └── demos/        ← 6 个独立 HTML demo（浏览器直接打开）
├── android/          ← 平台：Android（GLES2/GLES3）
├── ios/              ← 平台：iOS（Metal/GLES）
└── cli/              ← 平台：CLI / headless（CPU fallback）
```

**一个平台一个文件夹。** 新增平台就加一个文件夹。

## 平台支持

| 平台 | 状态 | 后端 |
|------|:--:|------|
| Web（浏览器） | ✅ demo 就绪 | WebGL 1.0 |
| Web（GlitchForge） | ✅ [已上线](https://glitchforge.pages.dev) | WebGL + Next.js |
| Android | 📋 规划中 | GLES 2.0 / GLES 3.0 |
| iOS | 📋 规划中 | Metal / GLES |
| CLI / Server | 📋 规划中 | Headless GL / CPU fallback |

## 架构

```
                    ┌──────────────────────┐
                    │    shaders/*.glsl     │
                    │     （唯一真源）        │
                    └──────┬───────────────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
     ┌────▼────┐     ┌────▼────┐     ┌─────▼─────┐
     │   Web   │     │ Android │     │    iOS    │
     │ WebGL   │     │  GLES   │     │  Metal    │
     └─────────┘     └─────────┘     └───────────┘
```

所有平台共享同一套 GLSL shader。
平台包装层负责纹理 I/O、上下文管理和 uniform 绑定——
但视觉逻辑在这里。

## 开发流程

新效果的开发路径：

```
glitch-core                        GlitchForge (code-sail)
─────────                          ──────────────────────
1. 写 shader 并放入 shaders/  →   4. 集成到 effects.ts
2. 用 demo HTML 实时测试           5. 配 i18n + UI 组件
3. 更新 SPEC.md                   6. build + Playwright 测试
                                  7. 部署上线
```

**shader 在 glitch-core 里开发和验证，产品集成在 GlitchForge 里完成。**

## 开源协议

MIT — 可用于开源项目、商业产品、移动 App、CLI 工具。
无需署名（但感谢署名）。

---

**由 [GlitchForge](https://glitchforge.pages.dev) 用 ❤️ 构建**
— 免费在线故障艺术工具，无水印，全分辨率。
