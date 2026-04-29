# 弥罗博客

极简新中式风格的Hugo静态博客网站。

## 功能特性

- ✅ 首页文章列表（仅显示文章）
- ✅ 文章摘要显示（非完整内容）
- ✅ 可配置分页功能
- ✅ 标签页和标签归档
- ✅ 搜索功能
- ✅ 黑白主题切换
- ✅ 一言API集成（显示诗词名言）
- ✅ 印章样式签名
- ✅ 响应式设计（适配手机端）
- ✅ 回到顶部按钮
- ✅ SEO优化
- ✅ RSS订阅支持

## 项目结构

```
miluoblog/
├── .hugo_build.lock                     # Hugo构建锁定文件（防止并发构建冲突）
├── archetypes/                          # 文章模板目录（hugo new时使用）
│   └── default.md
├── content/                             # 内容目录（存放所有文章和页面）
│   ├── post/                            # 文章目录
│   │   ├── hello-world.md
│   │   ├── post01.md
│   │   ├── post02.md
│   │   ├── post03.md
│   │   ├── ...
│   └── about.md                         # 关于页面
├── public/                              # Hugo构建输出的静态网站目录
│   ├── about/                           # 关于页面
│   │   └── index.html
│   ├── css/                             # 样式文件
│   │   └── style.css
│   ├── js/                              # JavaScript文件
│   │   └── search.js
│   ├── page/                            # 分页目录
│   │   └── ...
│   ├── post/                            # 文章目录
│   │   └── ...
│   ├── tags/                            # 标签目录
│   │   └── ...
│   ├── index.html                       # 首页
│   ├── index.xml                        # RSS订阅
│   ├── robots.txt                       # 搜索引擎爬虫配置
│   └── sitemap.xml                      # 站点地图
├── themes/                              # 主题目录
│   └── minimal-chinese/                 # 极简新中式主题
│       ├── layouts/                     # 模板文件目录
│       │   ├── _default/                # 默认模板
│       │   │   ├── baseof.html          # 基础模板（所有页面继承）
│       │   │   ├── list.html            # 列表页模板
│       │   │   └── single.html          # 单文章页模板
│       │   ├── partials/                # 可复用组件
│       │   │   ├── back-to-top.html     # 回到顶部按钮
│       │   │   ├── footer.html          # 页脚（含印章签名）
│       │   │   ├── head.html            # HTML头部（meta、favicon等）
│       │   │   ├── header.html          # 顶部导航栏
│       │   │   ├── pagination.html      # 分页组件
│       │   │   └── search-modal.html    # 搜索弹窗
│       │   ├── taxonomy/                # 分类归档模板
│       │   │   ├── tags/
│       │   │   │   └── list.html        # 标签文章列表页
│       │   │   ├── tags.terms.html      # 标签云页面
│       │   │   └── terms.html           # 通用分类云页面（暂未使用）
│       │   ├── index.html               # 首页模板
│       │   └── search.json              # 搜索索引生成模板
│       └── static/                      # 主题静态资源
│           ├── css/
│           │   └── style.css            # 主样式文件
│           └── js/
│               └── search.js            # 搜索功能脚本
├── hugo.toml                            # 网站配置文件
└── README.md                            # 项目说明文档
```

## 快速开始

### 1. 安装Hugo

从 [Hugo Releases](https://github.com/gohugoio/hugo/releases) 下载适合你系统的版本。

### 2. 本地预览

#### 添加Hugo到环境变量

将 `hugo_extended_0.161.0_windows-amd64` 目录添加到系统环境变量 PATH 后，直接使用：

```bash
# 进入项目目录
cd miluoblog

# 启动本地服务器
hugo server -D
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

[params]
  description = "极简，新中式，博客，技术，随想"  # 网站描述
  author = "太一"                                    # 作者名称
  paginate = 4                                      # 每页文章数量

[taxonomies]
  tag = "tags"    # 定义标签分类
```

### 文章Front Matter

Front Matter是文章开头的元数据区域，使用 `---` 包裹，支持YAML格式。

```yaml
---
title: "文章标题"
date: "2026-04-29T14:14:00+08:00"
tags: ["技术", "随笔"]
description: "文章描述"
draft: false
---
```

#### Front Matter字段说明

| 字段 | 必填 | 说明 | 示例 |
|------|------|------|------|
| `title` | ✅ 是 | 文章标题，显示在页面标题和列表中 | `title: "我的第一篇文章"` |
| `date` | ✅ 是 | 文章发布日期，支持多种格式 | `date: 2026-04-29`<br>`date: "2026-04-29T14:14:00+08:00"` |
| `tags` | ❌ 否 | 文章标签数组，用于分类和标签云 | `tags: ["技术", "生活", "随笔"]` |
| `description` | ❌ 否 | 文章描述，用于SEO和摘要显示 | `description: "这是文章的简短描述"` |
| `draft` | ❌ 否 | 草稿标记，`true` 为草稿，`false` 为发布状态 | `draft: false` |
| `author` | ❌ 否 | 文章作者，如未设置则使用站点配置 | `author: "作者名"` |
| `weight` | ❌ 否 | 文章权重，用于排序（数字越小越靠前） | `weight: 10` |
| `slug` | ❌ 否 | 文章URL别名，如未设置则使用文件名 | `slug: "my-article-url"` |

#### 特殊标记说明

| 标记 | 说明 | 用法 |
|------|------|------|
| `<!--more-->` | 摘要分割标记，分割线之前的内容作为首页摘要显示 | 在需要截断的位置添加 |

示例：
```markdown
---
title: "带摘要的文章"
date: 2026-04-29
tags: ["示例"]
draft: false
---

这是文章的摘要部分，会显示在首页。
<!--more-->

这是文章的完整内容，只有点击进入详情页才会看到。
```

## 主题定制

### 颜色主题

主题使用CSS变量定义颜色，修改 `themes/minimal-chinese/static/css/style.css` 中的变量：

```css
:root {
  --ink-black: #2c2c2c;      # 墨色
  --paper-white: #faf8f3;    # 纸白
  --vermillion-red: #c23b22; # 朱红
  --ink-gray: #666666;       # 墨灰
  --light-gray: #e8e6e1;    # 浅灰
  --gold-yellow: #c9a962;    # 金色
  --jade-green: #4a7c59;     # 玉绿
  --cerulean-blue: #3d6b8f;  # 靛蓝
  --rose-pink: #c97b7b;     # 玫红
  --lavender-purple: #8b7393;# 紫藤
  --cream-bg: #fdfbf7;       # 奶油色背景
  --warm-border: #d4c4a8;    # 暖色边框
}
```

### 颜色用途对照表

| 变量名 | 颜色 | 用途说明 |
|--------|------|----------|
| `--ink-black` | 墨色 | 正文文字、标题文字 |
| `--paper-white` | 纸白 | 页面背景、卡片背景 |
| `--vermillion-red` | 朱红 | 强调色、链接悬停、标签边框 |
| `--ink-gray` | 墨灰 | 次要文字、摘要文字 |
| `--light-gray` | 浅灰 | 分隔线、边框、输入框背景 |
| `--gold-yellow` | 金色 | 一言区域边框、印章装饰 |
| `--jade-green` | 玉绿 | 作者署名文字 |
| `--cerulean-blue` | 靛蓝 | 链接默认颜色、标签计数 |
| `--rose-pink` | 玫红 | 备用强调色 |
| `--lavender-purple` | 紫藤 | 引用块边框、主题切换悬停 |
| `--cream-bg` | 奶油色 | 渐变背景、卡片悬停效果 |
| `--warm-border` | 暖色边框 | 暖色调分隔线、引用块边框 |

### 深色模式颜色

深色模式使用 `[data-theme="dark"]` 选择器覆盖上述颜色变量，可在CSS中查看具体值。

### 分页数量

在 `hugo.toml` 中修改 `paginate` 值即可调整每页显示的文章数量。

## 模板说明

| 模板 | 说明 |
|------|------|
| `index.html` | 首页模板 |
| `single.html` | 文章详情页模板 |
| `list.html` | 列表页模板 |
| `tags/list.html` | 标签归档页模板 |

### 可复用组件

| 组件 | 说明 |
|------|------|
| `header.html` | 顶部导航栏 |
| `footer.html` | 页脚（含印章签名） |
| `pagination.html` | 分页组件 |
| `back-to-top.html` | 回到顶部按钮 |
| `search-modal.html` | 搜索弹窗 |
| `head.html` | HTML头部 |

## 技术栈

- **框架**: Hugo v0.161+
- **模板**: Go Templates
- **样式**: CSS3（Flexbox, CSS变量, 媒体查询）
- **交互**: Vanilla JavaScript
- **字体**: Noto Serif SC


## 部署

### GitHub Pages

1. 在GitHub创建仓库
2. 将项目推送到仓库
3. 配置GitHub Actions自动构建
4. 启用GitHub Pages

### 其他方式

将 `public/` 目录下的文件上传到任意静态托管服务即可。

## License

MIT License

## 致谢

- [Hugo](https://gohugo.io/) - 静态网站生成器
- [Noto Serif SC](https://fonts.google.com/) - 思源宋体字体
- [Hitokoto](https://hitokoto.cn/) - 一言API
