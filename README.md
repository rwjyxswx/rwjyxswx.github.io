# 弥罗

极简新中式风格的Hugo静态博客网站。

## 功能特性

- ✅ 首页文章列表（仅显示文章）
- ✅ 文章摘要显示（非完整内容）
- ✅ 可配置分页功能
- ✅ 标签页和标签归档
- ✅ 搜索功能
- ✅ 黑白主题切换
- ✅ 一言API集成
- ✅ 印章样式签名
- ✅ 响应式设计（适配手机端）
- ✅ 回到顶部按钮
- ✅ SEO优化
- ✅ RSS订阅支持
- ✅ 完全去中心化部署支持

## 项目结构

```
miluoblog/
├── .github/
│   └── workflows/
│       └── deploy.yml                  # GitHub Actions自动部署配置
├── .hugo_build.lock                    # Hugo构建锁定文件（自动生成）
├── archetypes/                         # 文章模板目录
│   └── default.md                      # 默认文章模板
├── content/                            # 内容目录
│   ├── post/                           # 文章目录
│   │   ├── hello-world.md              # 示例文章
│   │   ├── reading-notes.md            # 示例文章
│   │   └── tech-intro.md               # 示例文章
│   └── about.md                        # 关于页面
├── public/                             # Hugo构建输出的静态网站目录（自动生成）
│   ├── about/                          # 关于页面
│   ├── css/                            # 样式文件
│   ├── js/                             # JavaScript文件
│   ├── post/                           # 文章页面
│   ├── tags/                           # 标签页面
│   ├── index.html                      # 首页
│   ├── index.xml                       # RSS订阅
│   ├── sitemap.xml                     # 网站地图
│   └── robots.txt                      # 爬虫规则
├── themes/                             # 主题目录
│   └── minimal-chinese/                # 极简新中式主题
│       ├── layouts/                    # 模板文件
│       │   ├── _default/               # 默认模板
│       │   │   ├── baseof.html         # 基础模板
│       │   │   ├── list.html           # 列表页模板
│       │   │   └── single.html         # 单文章页模板
│       │   ├── partials/               # 可复用组件
│       │   │   ├── back-to-top.html    # 回到顶部按钮
│       │   │   ├── footer.html         # 页脚
│       │   │   ├── head.html           # HTML头部
│       │   │   ├── header.html         # 顶部导航
│       │   │   ├── pagination.html     # 分页组件
│       │   │   └── search-modal.html   # 搜索弹窗
│       │   ├── taxonomy/               # 分类模板
│       │   │   └── tags/
│       │   │       └── list.html       # 标签归档页
│       │   ├── index.html              # 首页模板
│       │   └── search.json             # 搜索索引模板
│       └── static/                     # 静态资源
│           ├── css/
│           │   └── style.css           # 主样式文件
│           │   └── js/
│               ├── hitokoto-data.js    # 本地一言数据（8888条名言）
│               └── search.js           # 搜索功能
├── hugo.toml                           # 网站配置文件
├── LICENSE                             # 许可证文件
└── README.md                           # 项目文档
```

### Hugo标准目录说明

以下目录是Hugo的标准目录，本项目已使用：

| 目录/文件 | 说明 | 状态 | 用途 |
|-----------|------|------|------|
| `data/` | 数据目录 | ✅ 已使用 | 存放一言数据库JSON文件 |
| `i18n/` | 国际化目录 | ❌ 未使用 | 用于多语言网站支持 |
| `layouts/` | 根布局目录 | ❌ 未使用 | 项目级别的布局文件（优先级高于theme） |
| `resources/` | 资源缓存 | ⚙️ 自动生成 | Hugo处理资源后的缓存目录 |
| `static/` | 静态目录 | ❌ 未使用 | 存放直接复制的静态文件 |
| `assets/` | 资源目录 | ❌ 未使用 | 存放需要Hugo处理的文件 |

## 快速开始

### 1. 安装Hugo

从 [Hugo Releases](https://github.com/gohugoio/hugo/releases) 下载适合你系统的版本。

**注意**：需要下载 `extended` 版本（如 `hugo_extended_0.161.0_windows-amd64.zip`）。

### 2. 本地预览

#### 方式一：添加Hugo到环境变量

将 `hugo_extended_0.161.0_windows-amd64` 目录添加到系统环境变量 PATH 后：

```bash
# 进入项目目录
cd miluoblog

# 启动本地服务器（忽略缓存）
hugo server -D --ignoreCache
```

#### 方式二：直接使用Hugo程序

```bash
# 进入项目目录
cd miluoblog

# 使用相对路径启动服务器
.\hugo_extended_0.161.0_windows-amd64\hugo.exe server -D --ignoreCache
```

访问 `http://localhost:1313` 查看网站。

### 3. 创建新文章

```bash
hugo new post/my-new-post.md
```

### 4. 构建静态文件

```bash
hugo
```

生成的静态文件位于 `public/` 目录。

## 配置说明

### 站点配置 (hugo.toml)

```toml
baseURL = "https://example.com/"    # 你的网站地址
languageCode = "zh-CN"             # 语言代码
title = "弥罗"                      # 网站标题
theme = "minimal-chinese"          # 主题名称
defaultContentLanguage = "zh-cn"   # 默认语言
enableRobotsTXT = true             # 启用robots.txt生成
googleAnalytics = ""               # Google Analytics ID（可选）

[params]
  description = "极简，新中式，博客，技术，随想"  # 网站描述
  author = "太一"                                # 作者名称
  paginate = 4                                   # 每页文章数
  keywords = ["博客", "技术", "极简", "新中式"]  # SEO关键词

[taxonomies]
  tag = "tags"                     # 标签分类

[permalinks]
  post = "/post/:year/:month/:day/:slug/"  # 文章URL格式

[outputs]
  home = ["HTML", "RSS"]           # 首页输出格式
  page = ["HTML"]                  # 页面输出格式
  section = ["HTML", "RSS"]        # 分类页输出格式

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = false               # 安全模式（禁止HTML）
```

#### 配置项详细说明

| 配置项 | 说明 | 示例值 |
|--------|------|--------|
| `baseURL` | 网站基础URL | `https://miluo.xyz/` |
| `languageCode` | 语言代码 | `zh-CN` |
| `title` | 网站标题 | `弥罗` |
| `theme` | 主题名称 | `minimal-chinese` |
| `defaultContentLanguage` | 默认内容语言 | `zh-cn` |
| `enableRobotsTXT` | 启用robots.txt | `true` |
| `googleAnalytics` | Google Analytics ID | `G-XXXXXXXXXX` |
| `[params]` | 自定义参数区块 | - |
| `description` | 网站描述 | `极简，新中式，博客` |
| `author` | 作者名称 | `太一` |
| `paginate` | 每页文章数 | `4` |
| `keywords` | SEO关键词 | `["博客", "技术"]` |
| `[taxonomies]` | 分类配置区块 | - |
| `tag` | 标签分类 | `tags` |
| `[permalinks]` | 永久链接配置 | - |
| `post` | 文章URL格式 | `/post/:year/:month/:day/:slug/` |
| `[outputs]` | 输出格式配置 | - |
| `[markup]` | Markdown渲染配置 | - |

### 文章Front Matter

```yaml
---
title: "文章标题"
date: "2026-04-29T14:14:00+08:00"
lastmod: "2026-04-30T10:00:00+08:00"
tags: ["技术", "随笔"]
categories: ["编程"]
description: "文章描述"
author: "太一"
draft: false
weight: 100
slug: "my-post-url"
---
```

#### Front Matter字段说明

| 字段 | 必填 | 类型 | 说明 | 示例 |
|------|------|------|------|------|
| `title` | ✅ 是 | string | 文章标题 | `title: "我的第一篇文章"` |
| `date` | ✅ 是 | datetime | 发布日期 | `date: 2026-04-29T14:14:00+08:00` |
| `lastmod` | ❌ 否 | datetime | 最后修改日期 | `lastmod: 2026-04-30T10:00:00+08:00` |
| `tags` | ❌ 否 | array | 标签数组 | `tags: ["技术", "生活"]` |
| `categories` | ❌ 否 | array | 分类数组 | `categories: ["编程"]` |
| `description` | ❌ 否 | string | 文章描述 | `description: "简短描述"` |
| `author` | ❌ 否 | string | 作者（覆盖全局） | `author: "太一"` |
| `draft` | ❌ 否 | boolean | 草稿状态 | `draft: false` |
| `weight` | ❌ 否 | int | 排序权重 | `weight: 100` |
| `slug` | ❌ 否 | string | URL别名 | `slug: "my-post-url"` |
| `image` | ❌ 否 | string | 封面图片 | `image: "/images/cover.jpg"` |

#### 特殊标记

| 标记 | 说明 | 示例 |
|------|------|------|
| `<!--more-->` | 摘要分割标记，之前内容显示在首页 | `摘要内容<!--more-->正文内容` |

#### 完整文章示例

```markdown
---
title: "如何使用Hugo搭建博客"
date: "2026-04-29T14:14:00+08:00"
lastmod: "2026-04-30T10:00:00+08:00"
tags: ["技术", "Hugo", "博客"]
categories: ["教程"]
description: "本文介绍如何使用Hugo快速搭建一个极简风格的个人博客"
author: "太一"
draft: false
slug: "hugo-blog-tutorial"
---

这是文章的摘要部分，会显示在首页列表中。

<!--more-->

这是文章的正文部分，点击"阅读更多"后才会显示。

## 一级标题

正文内容...

### 二级标题

更多内容...
```

## 主题定制

### 颜色主题

修改 `themes/minimal-chinese/static/css/style.css` 中的CSS变量。

### 颜色对照表

| 变量 | 颜色 | 用途 |
|------|------|------|
| `--ink-black` | 墨色 (#2c2c2c) | 正文、标题 |
| `--paper-white` | 纸白 (#faf8f3) | 背景 |
| `--vermillion-red` | 朱红 (#c23b22) | 强调、链接悬停、标签边框 |
| `--ink-gray` | 墨灰 (#666666) | 次要文字、摘要 |
| `--light-gray` | 浅灰 (#e8e6e1) | 分隔线、边框 |
| `--gold-yellow` | 金色 (#c9a962) | 一言边框、印章装饰 |
| `--jade-green` | 玉绿 (#4a7c59) | 作者署名 |
| `--cerulean-blue` | 靛蓝 (#3d6b8f) | 链接默认色、标签计数 |
| `--rose-pink` | 玫红 (#c97b7b) | 备用强调色 |
| `--lavender-purple` | 紫藤 (#8b7393) | 引用块边框、主题切换悬停 |
| `--cream-bg` | 奶油色 (#fdfbf7) | 渐变背景、卡片悬停效果 |
| `--warm-border` | 暖色边框 (#d4c4a8) | 暖色调分隔线 |

### 分页数量

在 `hugo.toml` 中修改 `paginate` 值：

```toml
[params]
  paginate = 10  # 每页显示10篇文章
```

### 字体配置

项目使用系统字体栈，确保跨平台兼容性：

```css
font-family: system-ui, -apple-system, BlinkMacSystemFont,
             'Noto Serif SC', 'Source Han Serif SC', 'Source Han Serif CN',
             'PingFang SC', 'Microsoft YaHei', 'Hiragino Sans GB',
             'WenQuanYi Micro Hei', 'SimSun', 'STSong',
             'Times New Roman', serif;
```

| 系统 | 优先使用字体 |
|------|-------------|
| macOS/iOS | PingFang SC, Noto Serif SC |
| Windows | Microsoft YaHei, SimSun |
| Linux | WenQuanYi Micro Hei, Noto Serif SC |
| Android | Noto Serif SC |

## 模板说明

### 页面模板

| 模板 | 文件路径 | 说明 |
|------|----------|------|
| 首页 | `layouts/index.html` | 网站首页，显示文章列表 |
| 文章详情 | `layouts/_default/single.html` | 单篇文章页面 |
| 列表页 | `layouts/_default/list.html` | 分类列表页面 |
| 标签归档 | `layouts/taxonomy/tags/list.html` | 标签下的文章列表 |
| 基础模板 | `layouts/_default/baseof.html` | 所有页面的基础框架 |

### 组件模板

| 组件 | 文件路径 | 说明 |
|------|----------|------|
| 导航栏 | `layouts/partials/header.html` | 顶部导航、搜索按钮、主题切换 |
| 页脚 | `layouts/partials/footer.html` | 页脚、印章签名、JavaScript |
| HTML头部 | `layouts/partials/head.html` | meta标签、CSS引入 |
| 分页 | `layouts/partials/pagination.html` | 分页导航组件 |
| 回到顶部 | `layouts/partials/back-to-top.html` | 回到顶部按钮 |
| 搜索弹窗 | `layouts/partials/search-modal.html` | 搜索功能界面 |

## 技术栈

| 类别 | 技术 | 版本 | 说明 |
|------|------|------|------|
| **框架** | Hugo | v0.161.0+ | 静态网站生成器 |
| **模板引擎** | Go Templates | - | Hugo内置模板引擎 |
| **样式** | CSS3 | - | Flexbox、CSS变量、媒体查询 |
| **交互** | Vanilla JavaScript | ES6+ | 无框架原生JavaScript |
| **字体** | 系统字体栈 | - | 跨平台兼容，无需加载外部字体 |
| **一言数据** | 本地JSON | 8888条 | 经典名言，离线可用，支持自动更新 |
| **构建工具** | Hugo CLI | - | 命令行构建工具 |
| **部署** | GitHub Actions | - | 自动化CI/CD |
| **托管** | GitHub Pages | - | 静态网站托管 |
| **去中心化** | IPFS/Filecoin | - | 可选的去中心化部署 |

### 技术特点

- **零外部依赖**：所有资源本地化，无需加载外部API或CDN
- **响应式设计**：适配桌面、平板、手机等各种设备
- **SEO友好**：语义化HTML、完整的meta标签、sitemap、robots.txt
- **高性能**：纯静态文件，加载速度快
- **主题切换**：支持明暗主题，自动保存用户偏好
- **离线可用**：一言数据本地化，断网也能正常显示

## 项目部署

### GitHub Actions

在 `.github/workflows/` 中添加IPFS部署工作流。

## 部署

### GitHub Pages

#### 步骤1：创建GitHub仓库

1. 登录GitHub
2. 创建新仓库，命名为 `username.github.io`（替换 `username` 为你的用户名）
3. 选择 Public（公开仓库）

#### 步骤2：推送代码

```bash
# 初始化Git
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/username/username.github.io.git
git push -u origin main
```

#### 步骤3：配置GitHub Pages

1. 进入仓库 → Settings → Pages
2. Source 选择 `GitHub Actions`
3. 等待自动部署完成

#### 步骤4：访问网站

访问 `https://username.github.io` 查看你的博客！

### 自定义域名

#### 步骤1：配置DNS记录

在域名注册商处添加以下记录：

| 类型 | 主机 | 值 |
|------|------|-----|
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | username.github.io |

#### 步骤2：在GitHub中配置域名

1. 进入仓库 → Settings → Pages
2. 在 Custom domain 中输入你的域名
3. 点击 Save
4. 等待DNS验证通过
5. 勾选 Enforce HTTPS

#### 步骤3：更新网站配置

修改 `hugo.toml` 中的 `baseURL`：

```toml
baseURL = "https://yourdomain.com/"
```

### 其他托管平台

| 平台 | 说明 |
|------|------|
| Vercel | 支持Hugo，自动部署 |
| Netlify | 支持Hugo，功能丰富 |
| Cloudflare Pages | 免费额度大，全球CDN |
| IPFS/Filecoin | 去中心化部署 |

## 常用命令

| 命令 | 说明 |
|------|------|
| `hugo server -D` | 启动开发服务器（包含草稿） |
| `hugo server -D --ignoreCache` | 启动服务器（忽略缓存） |
| `hugo new post/xxx.md` | 创建新文章 |
| `hugo` | 构建静态网站 |
| `hugo --minify` | 构建并压缩 |
| `hugo --cleanCache` | 清理缓存后构建 |
| `hugo version` | 查看Hugo版本 |

## 更新文章流程

```bash
# 1. 创建新文章
hugo new post/my-new-post.md

# 2. 编辑文章
code content/post/my-new-post.md

# 3. 本地预览
hugo server -D --ignoreCache

# 4. 构建测试
hugo

# 5. 提交更改
git add .
git commit -m "Add new post: my-new-post"

# 6. 推送到GitHub
git push origin main

# 7. 等待自动部署（约1分钟）
```

## 一言数据库更新

本博客使用本地化的一言数据库，无需依赖外部API。

### 数据来源

- **官方仓库**: [hitokoto-osc/sentences-bundle](https://github.com/hitokoto-osc/sentences-bundle)
- **数据类型**: 动画、漫画、游戏、文学、原创、网络、影视、诗词、哲学、抖机灵等
- **开源协议**: AGPL License（使用本数据需遵守开源协议）

### 跨平台脚本支持

本项目提供三种跨平台脚本支持一键更新：

| 操作系统 | 下载脚本 | 合并脚本 | 说明 |
|---------|---------|---------|------|
| Windows | `update-hitokoto.ps1` | `merge-data.ps1` | PowerShell脚本 |
| macOS/Linux | `update-hitokoto.sh` | `merge-data.sh` | Bash脚本（需要Python） |
| 跨平台 | - | `merge-data.py` | Python脚本（推荐） |

### 更新数据库

#### 方式一：PowerShell（Windows，推荐）

```powershell
# 进入更新脚本目录
cd data/sentences

# 下载最新数据库并自动合并
.\update-hitokoto.ps1

# 或只运行合并脚本
.\merge-data.ps1
```

#### 方式二：Bash（macOS/Linux）

```bash
# 进入更新脚本目录
cd data/sentences

# 下载最新数据库并自动合并
bash update-hitokoto.sh

# 或只运行合并脚本
bash merge-data.sh
```

#### 方式三：Python（跨平台，推荐）

```bash
# 进入更新脚本目录
cd data/sentences

# 运行Python合并脚本
python merge-data.py
```

#### 步骤2：重新构建网站

```bash
# 回到项目根目录
cd ../..

# 清理缓存并构建
hugo --cleanCache

# 或直接预览
hugo server -D --ignoreCache
```

### 脚本说明

| 脚本 | 功能 | 依赖 |
|------|------|------|
| `update-hitokoto.ps1` | 从GitHub下载最新一言数据库并自动合并 | PowerShell + 网络 |
| `merge-data.ps1` | 将JSON文件合并为hitokoto-data.js | PowerShell |
| `update-hitokoto.sh` | 从GitHub下载最新一言数据库并自动合并 | Bash + curl + Python |
| `merge-data.sh` | 将JSON文件合并为hitokoto-data.js | Bash + Python |
| `merge-data.py` | 将JSON文件合并为hitokoto-data.js | Python 3.6+ |

### 数据目录结构

```
data/
└── sentences/
    ├── sentences/           # 一言官方JSON数据
    │   ├── a.json          # 动画
    │   ├── b.json          # 漫画
    │   ├── c.json          # 游戏
    │   ├── d.json          # 文学
    │   ├── e.json          # 原创
    │   ├── f.json          # 网络
    │   ├── g.json          # 其他
    │   ├── h.json          # 影视
    │   ├── i.json          # 诗词
    │   ├── j.json          # 网易云
    │   ├── k.json          # 哲学
    │   └── l.json          # 抖机灵
    ├── update-hitokoto.ps1  # PowerShell下载脚本
    ├── update-hitokoto.sh   # Bash下载脚本
    ├── merge-data.ps1       # PowerShell合并脚本
    ├── merge-data.sh        # Bash合并脚本
    └── merge-data.py        # Python合并脚本（推荐）
```

### 注意事项

- ⚠️ 一言数据库采用 **AGPL 开源协议**，修改和分发需开源
- 💡 本博客直接使用本地数据，调用时无需开放源代码
- 🔄 建议定期更新数据库以获取最新语句
- 📦 数据库文件较大（约2-3MB），请注意网络下载时间
- ✅ 所有脚本已针对特殊字符进行安全转义处理

## License

MIT License

## 致谢

### 技术框架
- [Hugo](https://gohugo.io/) - 世界上最快的静态网站生成器
- [Go Templates](https://golang.org/pkg/text/template/) - 强大的模板引擎

### 设计灵感
- 中国传统书法与篆刻艺术
- 极简主义设计理念
- 新中式美学风格

### 数据来源
- [hitokoto-osc/sentences-bundle](https://github.com/hitokoto-osc/sentences-bundle) - 一言开源数据库
- 本地一言数据涵盖动画、漫画、游戏、文学、诗词、哲学等多种类型

### 部署平台
- [GitHub Pages](https://pages.github.com/) - 免费静态网站托管
- [GitHub Actions](https://github.com/features/actions) - 自动化CI/CD

### 开源社区
- 感谢所有开源贡献者
- 感谢Hugo社区的持续支持

---

**弥罗** - 路漫漫其修远兮，吾将上下而求索。
