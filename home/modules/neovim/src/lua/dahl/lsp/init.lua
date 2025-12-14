local folder = debug.getinfo(1).source:sub(2):match("(.*/)")

for name in vim.fs.dir(folder) do
	name = name:match("([^/]+)%.lua$")

	if name ~= "init" then
		require("dahl.lsp." .. name)
	end
end
