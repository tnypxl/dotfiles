return {
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      dim_inactive = true,
      overrides = function(colors)
        local theme = colors.theme
        local tab = theme.ui.tabline
        return {
          LazyButtonActive = { fg = colors.palette.sumiInk0, bg = colors.palette.carpYellow, bold = true },

          -- Snacks explorer: darker sidebar
          SnacksPickerNormalFloat = { bg = colors.palette.sumiInk1 },

          -- Subtler window separators
          WinSeparator = { fg = colors.palette.sumiInk4 },

          -- Bufferline: fix missing bg on selected-state groups (upstream issue)
          BufferlineIndicatorSelected = { fg = tab.indicator, bg = tab.bg_selected },
          BufferlineCloseButtonSelected = { fg = theme.ui.picker, bg = tab.bg_selected, bold = true },
          BufferlineNumbersSelected = { fg = tab.indicator, bg = tab.bg_selected, bold = true },

          -- Bufferline: diagnostic highlights
          BufferlineError = { fg = theme.diag.error, bg = tab.bg },
          BufferlineErrorVisible = { fg = theme.diag.error, bg = tab.bg_inactive },
          BufferlineErrorSelected = { fg = theme.diag.error, bg = tab.bg_selected, bold = true },
          BufferlineErrorDiagnostic = { fg = theme.diag.error, bg = tab.bg },
          BufferlineErrorDiagnosticVisible = { fg = theme.diag.error, bg = tab.bg_inactive },
          BufferlineErrorDiagnosticSelected = { fg = theme.diag.error, bg = tab.bg_selected, bold = true },
          BufferlineWarning = { fg = theme.diag.warning, bg = tab.bg },
          BufferlineWarningVisible = { fg = theme.diag.warning, bg = tab.bg_inactive },
          BufferlineWarningSelected = { fg = theme.diag.warning, bg = tab.bg_selected, bold = true },
          BufferlineWarningDiagnostic = { fg = theme.diag.warning, bg = tab.bg },
          BufferlineWarningDiagnosticVisible = { fg = theme.diag.warning, bg = tab.bg_inactive },
          BufferlineWarningDiagnosticSelected = { fg = theme.diag.warning, bg = tab.bg_selected, bold = true },
          BufferlineInfo = { fg = theme.diag.info, bg = tab.bg },
          BufferlineInfoVisible = { fg = theme.diag.info, bg = tab.bg_inactive },
          BufferlineInfoSelected = { fg = theme.diag.info, bg = tab.bg_selected, bold = true },
          BufferlineInfoDiagnostic = { fg = theme.diag.info, bg = tab.bg },
          BufferlineInfoDiagnosticVisible = { fg = theme.diag.info, bg = tab.bg_inactive },
          BufferlineInfoDiagnosticSelected = { fg = theme.diag.info, bg = tab.bg_selected, bold = true },
          BufferlineHint = { fg = theme.diag.hint, bg = tab.bg },
          BufferlineHintVisible = { fg = theme.diag.hint, bg = tab.bg_inactive },
          BufferlineHintSelected = { fg = theme.diag.hint, bg = tab.bg_selected, bold = true },
          BufferlineHintDiagnostic = { fg = theme.diag.hint, bg = tab.bg },
          BufferlineHintDiagnosticVisible = { fg = theme.diag.hint, bg = tab.bg_inactive },
          BufferlineHintDiagnosticSelected = { fg = theme.diag.hint, bg = tab.bg_selected, bold = true },

          -- Bufferline: visible (unfocused window) buffer states
          BufferlineBufferVisible = { fg = tab.fg_inactive, bg = tab.bg_inactive },
          BufferlineIndicatorVisible = { fg = tab.bg_inactive, bg = tab.bg_inactive },
          BufferlineSeparatorVisible = { fg = tab.bg, bg = tab.bg_inactive },
          BufferlineModifiedVisible = { fg = theme.vcs.changed, bg = tab.bg_inactive },
          BufferlineCloseButtonVisible = { fg = theme.ui.fg_dimmer, bg = tab.bg_inactive },
          BufferlineNumbersVisible = { fg = theme.ui.fg_dimmer, bg = tab.bg_inactive },
          BufferlineDuplicate = { fg = theme.ui.fg_dimmer, bg = tab.bg, italic = true },
          BufferlineDuplicateSelected = { fg = theme.ui.fg_dim, bg = tab.bg_selected, italic = true },
          BufferlineDuplicateVisible = { fg = theme.ui.fg_dimmer, bg = tab.bg_inactive, italic = true },
          BufferlineDiagnostic = { fg = theme.ui.fg_dimmer, bg = tab.bg },
          BufferlineDiagnosticVisible = { fg = theme.ui.fg_dimmer, bg = tab.bg_inactive },
          BufferlineDiagnosticSelected = { fg = theme.ui.fg_dim, bg = tab.bg_selected, bold = true },
        }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-paper-ink",
    },
  },
}
