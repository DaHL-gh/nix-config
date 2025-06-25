local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- map("n", "<leader>s")

-- NeoTree
map("n", "<leader><Tab>", ":Neotree toggle <CR>", opts)

-- LSP
map("n", "<leader>f", vim.lsp.buf.format)
map("n", "<leader>r", vim.lsp.buf.rename)
map("n", "<leader>a", vim.lsp.buf.code_action)

-- Device	S-state	 Status   Sysfs node
-- GP12	 S4	*enabled   pci:0000:00:07.1
-- GP13	 S4	*enabled   pci:0000:00:08.1
-- XHC0	 S4	*disabled  pci:0000:09:00.3
-- GP30	 S4	*disabled
-- GP31	 S4	*disabled
-- PS2K	 S3	*disabled
-- GPP0	 S4	*enabled   pci:0000:00:01.1
-- GPP8	 S4	*enabled   pci:0000:00:03.1
-- SWUS	 S4	*enabled   pci:0000:05:00.0
-- SWDS	 S4	*enabled   pci:0000:06:00.0
-- PTXH	 S4	*enabled   pci:0000:02:00.0
-- PT20	 S4	*disabled
-- PT21	 S4	*disabled
-- PT22	 S4	*disabled
-- PT23	 S4	*disabled
-- PT24	 S4	*disabled
-- PT26	 S4	*disabled
-- PT27	 S4	*disabled
-- PT28	 S4	*disabled
-- PT29	 S4	*enabled   pci:0000:03:09.0
