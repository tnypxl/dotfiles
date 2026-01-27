local opt = vim.opt

vim.g.autoformat = false
opt.relativenumber = false

-- Add undercurl for all diagnostics and with relavant colors
vim.cmd.highlight('DiagnosticUnderlineError gui=undercurl guisp=red')
vim.cmd.highlight('DiagnosticUnderlineWarn gui=undercurl guisp=yellow')
vim.cmd.highlight('DiagnosticUnderlineInfo gui=undercurl guisp=cyan')
