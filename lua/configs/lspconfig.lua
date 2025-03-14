-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require 'lspconfig.util'


-- EXAMPLE
local servers = { "html", "cssls", "taplo", "docker_compose_language_service", "ansiblels" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ansiblels.setup {
  cmd = { "ansible-language-server", "--stdio" },
  filetypes = { "yaml", "yml", "ansible" },
  settings = {
    ansible = {
      ansible = {
        path = "ansible",
      },
      executionEnvironment = {
        enabled = false,
      },
      python = {
        interpreterPath = "python",
      },
      validation = {
        enabled = true,
        lint = {
          enabled = true,
          path = "ansible-lint",
        },
      },
    },
  },
  root_dir = util.root_pattern("ansible.cfg", ".ansible-lint"),
  single_file_support = false,
}

lspconfig.jsonls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
}

lspconfig.gopls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

lspconfig.pylsp.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { "W391" },
          maxLineLength = 100,
          convention = "google",
        },
        pylsp_black = {
          enabled = true,
          line_length = 100,
        },
        pylint = {
          enabled = true,
          executable = "pylint",
          args = {
            "--load-plugins=pylint_celery,pylint_django",
            "--django-settings-module=hopofy.settings",
            "--suggestion-mode=yes",
            "--function-naming-style=snake_case",
            "--include-naming-hint=yes",
          },
        },
        rope_autoimport = {
          enabled = true,
        },
        rope_completion = {
          enabled = true,
        },
        autopep8 = {
          enabled = true,
        },
        pylsp_mypy = { enabled = true },
      },
    },
  },
}

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "python" },
  settings = {
    pyright = {
      disableOrganizeImports = true, -- using Ruff instead
    },
    python = {
      analysis = {
        -- ignore = { '*' }, -- using Ruff instead
        -- typeCheckingMode = 'off', -- using Mypy instead
      },
    },
  },
}

lspconfig.ruff.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = {
    settings = {
      -- Any extra cli args for ruff go here
      args = { "--line-length=100" },
      lint = {
        run = "onType", -- other option is 'onType'
      },
    },
  },
}

-- lspconfig.pylsp_mypy.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      function()
        local params = {
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
        vim.lsp.buf.execute_command(params)
      end,
      description = "Organize Imports",
    },
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "literal",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

lspconfig.docker_compose_language_service.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose", "yml.docker-compose" },
  -- root_dir = root_pattern("docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml"),
  -- root_dir = "docker-compose.yaml", "docker-compose.yml", "compose.yaml", "compose.yml",
  single_file_support = true,
}

-- configuring single server, example: typescript
-- lspconfig.tsserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
--
-- lspconfig.gopls.setup {
--   on_attach = nvlsp.on_attach,
--   capabilities = nvlsp.capabilities,
--   cmd = {"gopls"},
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = nvlsp.util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       }
--     }
--   }
-- }
