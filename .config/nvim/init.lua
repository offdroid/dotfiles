local modules = {
    'options', 'plugins', 'plugins.lspconfig', 'plugins.treesitter', 'mappings',
    'plugins.telescope', 'plugins.misc'
}

for i = 1, #modules do
    local ok, res = pcall(require, modules[i])
    if not (ok) then
        print('Error loading module : ' .. modules[i])
        print(res)
    end
end
