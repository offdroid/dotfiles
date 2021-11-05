-- { 'impatient', 'packer_compiled', }
local modules = {
    'options', 'plugins', 'plugins.lspconfig', 'plugins.treesitter', 'mappings',
    'plugins.telescope', 'plugins.misc'
}

for i = 1, #modules do
    local ok, res = pcall(require, modules[i])
    if not (ok) then
        if modules[i] == 'impatient' then
            -- Plugins aren't installed yet. Cancel further config loading.
            require 'plugins'
            break
        end
        print('Error loading module: ' .. modules[i])
        print(res)
    end
end
