return {
  {
    "thesimonho/kanagawa-paper.nvim",
    opts = {
      overrides = function(colors)
        local theme = colors.theme
        local tab = theme.ui.tabline
        return {
          LazyButtonActive = { fg = colors.palette.sumiInk0, bg = colors.palette.carpYellow, bold = true },

          -- Snacks: core window styling (darker floats)
          SnacksNormal = { fg = theme.ui.fg, bg = colors.palette.sumiInk2 },
          SnacksNormalNC = { fg = theme.ui.fg_dim, bg = colors.palette.sumiInk2 },
          SnacksWinBar = { fg = theme.ui.fg_dim, bg = colors.palette.sumiInk2 },
          SnacksWinBarNC = { fg = theme.ui.fg_dimmer, bg = colors.palette.sumiInk2 },

          -- Snacks: picker - unified float backgrounds
          SnacksPickerNormalFloat = { bg = colors.palette.sumiInk2 },
          SnacksPickerInput = { bg = colors.palette.sumiInk2 },
          SnacksPickerInputBorder = { fg = colors.palette.sumiInk6, bg = colors.palette.sumiInk2 },
          SnacksPickerInputTitle = { fg = colors.palette.dragonYellow, bg = colors.palette.sumiInk2, bold = true },
          SnacksPickerList = { bg = colors.palette.sumiInk2 },
          SnacksPickerPreview = { bg = colors.palette.sumiInk2 },
          SnacksPickerBox = { bg = colors.palette.sumiInk2 },
          SnacksPickerPrompt = { fg = colors.palette.dragonBlue2 },
          SnacksPickerToggle = { fg = colors.palette.sumiInk0, bg = colors.palette.dragonBlue, bold = true },
          SnacksPickerSelected = { fg = colors.palette.dragonYellow, bold = true },
          SnacksPickerSpinner = { fg = colors.palette.dragonAqua },
          SnacksPickerTree = { fg = colors.palette.sumiInk6 },
          SnacksPickerDimmed = { fg = colors.palette.dragonBlack5 },

          -- Snacks: picker - git status colors
          SnacksPickerGitStatusAdded = { fg = theme.vcs.added },
          SnacksPickerGitStatusModified = { fg = theme.vcs.changed },
          SnacksPickerGitStatusDeleted = { fg = theme.vcs.removed },
          SnacksPickerGitStatusRenamed = { fg = theme.vcs.changed },
          SnacksPickerGitStatusUntracked = { fg = colors.palette.dragonAqua },
          SnacksPickerGitStatusStaged = { fg = theme.vcs.added, bold = true },
          SnacksPickerGitBranch = { fg = colors.palette.dragonViolet },
          SnacksPickerGitBranchCurrent = { fg = colors.palette.dragonViolet, bold = true },

          -- Snacks: dashboard
          SnacksDashboardNormal = { fg = theme.ui.fg, bg = colors.palette.sumiInk2 },
          SnacksDashboardIcon = { fg = colors.palette.dragonBlue },
          SnacksDashboardKey = { fg = colors.palette.dragonYellow },
          SnacksDashboardTitle = { fg = colors.palette.dragonViolet, bold = true },
          SnacksDashboardSpecial = { fg = colors.palette.dragonAqua },

          -- Snacks: notifier (match diagnostic palette)
          SnacksNotifierIconError = { fg = theme.diag.error },
          SnacksNotifierIconWarn = { fg = theme.diag.warning },
          SnacksNotifierIconInfo = { fg = theme.diag.info },
          SnacksNotifierIconDebug = { fg = theme.diag.hint },
          SnacksNotifierIconTrace = { fg = colors.palette.dragonGray2 },
          SnacksNotifierBorderError = { fg = theme.diag.error },
          SnacksNotifierBorderWarn = { fg = theme.diag.warning },
          SnacksNotifierBorderInfo = { fg = theme.diag.info },
          SnacksNotifierBorderDebug = { fg = theme.diag.hint },
          SnacksNotifierBorderTrace = { fg = colors.palette.dragonGray2 },
          SnacksNotifierTitleError = { fg = theme.diag.error, bold = true },
          SnacksNotifierTitleWarn = { fg = theme.diag.warning, bold = true },
          SnacksNotifierTitleInfo = { fg = theme.diag.info, bold = true },
          SnacksNotifierTitleDebug = { fg = theme.diag.hint, bold = true },
          SnacksNotifierTitleTrace = { fg = colors.palette.dragonGray2, bold = true },

          -- Snacks: input dialog
          SnacksInputNormal = { fg = theme.ui.fg, bg = colors.palette.sumiInk4 },
          SnacksInputBorder = { fg = colors.palette.sumiInk6, bg = colors.palette.sumiInk4 },
          SnacksInputTitle = { fg = colors.palette.dragonYellow, bg = colors.palette.sumiInk4, bold = true },
          SnacksInputIcon = { fg = colors.palette.dragonBlue },
          SnacksInputPrompt = { fg = colors.palette.dragonBlue2 },

          -- Snacks: dim and zen
          SnacksDim = { fg = colors.palette.dragonBlack5 },
          SnacksZenIcon = { fg = colors.palette.dragonAqua },

          -- Float backgrounds: match Snacks picker/explorer
          NormalFloat = { fg = theme.ui.fg, bg = colors.palette.sumiInk2 },
          FloatBorder = { fg = colors.palette.sumiInk6, bg = colors.palette.sumiInk2 },
          FloatTitle = { fg = colors.palette.dragonYellow, bg = colors.palette.sumiInk2, bold = true },

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
      colorscheme = "kanagawa-paper",
    },
  },
}
