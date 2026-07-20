-- C# / ASP.NET Core via the official Roslyn language server.
-- Install the 'roslyn' package from the Crashdummyy Mason registry
-- (mason-tool-installer handles it). Do NOT install the official-registry
-- 'roslyn-language-server' package: it auto-enables a competing roslyn_ls client.
return {
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    opts = {
        broad_search = true,
    },
    init = function()
        vim.lsp.config('roslyn', {
            settings = {
                ['csharp|inlay_hints'] = {
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                },
                ['csharp|completion'] = {
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                },
                ['csharp|background_analysis'] = {
                    dotnet_analyzer_diagnostics_scope = 'openFiles',
                    dotnet_compiler_diagnostics_scope = 'openFiles',
                },
            },
        })
    end,
}
