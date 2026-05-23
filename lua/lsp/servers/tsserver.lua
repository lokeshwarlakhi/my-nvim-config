-- ============================================================================
-- TSSERVER LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for TypeScript and JavaScript
-- Server: tsserver (https://www.typescriptlang.org/)
--
-- tsserver is the official TypeScript Language Server from Microsoft.
--
-- ============================================================================

return {
  settings = {
    typescript = {
      -- TypeScript-specific settings
      inlayHints = {
        includeInlayParameterNameHints = "all",  -- Always show parameter names
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
      },
      
      -- Suggest settings
      suggest = {
        autoImports = true,           -- Auto-import on completion
        autoImportFileExcludePatterns = {},
        completeJSDocs = true,        -- Complete JSDoc comments
        enabled = true,
        includeAutomaticOptionalChainCompletions = true,
        includeCompletionsForImportStatements = true,
        includeCompletionsForModuleExports = true,
        includeCompletionsWithClassMemberSnippets = true,
        includeCompletionsWithObjectLiteralMethodSnippets = true,
        includeCompletionsWithInsertText = true,
      },
      
      -- Diagnostics
      diagnostics = {
        ignoredCodes = {},
      },
      
      -- JavaScript settings
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
        
        suggest = {
          autoImports = true,
          completeJSDocs = true,
          enabled = true,
          includeAutomaticOptionalChainCompletions = true,
          includeCompletionsForImportStatements = true,
          includeCompletionsForModuleExports = true,
          includeCompletionsWithClassMemberSnippets = true,
          includeCompletionsWithObjectLiteralMethodSnippets = true,
          includeCompletionsWithInsertText = true,
        },
      },
      
      -- Code lens
      enablePromptUseWorkspaceTsdk = false,
      
      -- Localization
      locale = "en",
      
      -- Update imports on rename
      updateImportsOnFileMove = {
        enabled = "always",
      },
      
      -- Implicit project config
      implicitProjectConfig = {
        checkJs = false,
        experimentalDecorators = false,
        strictNullChecks = true,
        strictFunctionTypes = true,
        strictBindCallApply = true,
        strictPropertyInitialization = true,
        noImplicitAny = true,
        noImplicitThis = true,
        alwaysStrict = true,
        noUnusedLocals = true,
        noUnusedParameters = true,
        noImplicitReturns = true,
        noFallthroughCasesInSwitch = true,
      },
    },
    
    -- JavaScript specific settings
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
      },
    },
  },
}
