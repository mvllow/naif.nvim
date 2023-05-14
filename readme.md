# naïf.nvim

> Naïve syntax highlighting

**This plugin is experimental and a work-in-progress. Neovim nightly is recommended, as a currently unreleased [pull request](https://github.com/neovim/neovim/pull/22693) is utilised.**

## Introduction

_[On the design of text editors](https://arxiv.org/pdf/2008.06030.pdf)_ by Nicolas P. Rougier—as the title suggests—discusses the design of text editors, including the lack of evidence supporting the utility of syntax highlighting for code comprehension. Naïf reduces your current theme's palette while applying opinionated design principals regarding typography and colour. Try naïf with your favourite theme and enjoy the labours of a well-crafted interface and elegant syntax highlighting.

Naïf tries not to interfere with plugins, diagnostics, or other non-syntax related highlighting.

## Usage

Install naïf via your favourite plugin manager, then initialise the plugin.

```lua
require("naif").setup()
```

## Gallery

**Rosé Pine without naïf**

<img width="705" alt="Rosé Pine without naïf" src="https://github.com/mvllow/naif.nvim/assets/1474821/dea6914c-c063-465a-ab62-0855402e0762">

**Rosé Pine with naïf**

<img width="705" alt="Rosé Pine with naïf" src="https://github.com/mvllow/naif.nvim/assets/1474821/0ad68ce2-ab5e-4043-8656-a2e10e23830c">

## Options

Naïf is intended to work without any extra configuration. Options should be considered a method for fixing undesirable or broken defaults.

**disable_extra_highlights**

Naïf manages basic syntax groups only, disabling treesitter highlights and semantic tokens by default. Changing this option from the default value will introduce a more colourful (less naïf) syntax.

```lua
disable_extra_highlights = true
```

**palette**

Please note that the API for overriding palette values may change and is still considered experimental. Try naïf with your existing theme before overriding colours and please create an issue if something seems off.

```lua
palette = {
    strong = { fg = "#2d2d2d", bold = true },
    normal = { fg = "#2d2d2d", bg = "#ffffff" },
    critical = { fg = "#ffffff", bg = "#ff0000" },
    popout = { fg = "#ff9301" },
    salient = { fg = "#5856d7" },
    faded = { fg = "#999999" },
    subtle = { fg = "#2d2d2d", bg = "#f0f0f0" },
}
```
