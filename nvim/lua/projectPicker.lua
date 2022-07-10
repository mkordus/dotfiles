local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local function run_selection(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    vim.cmd(string.format("silent lcd ~/projects/%s", selection[1]))
  end)
  return true
end

local function projectPicker()
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "projects",
    finder = finders.new_table {
      results = (function () 
        local results = vim.fn['FindProjectRoots']()
        local lines = {}
        for s in results:gmatch("[^\r\n]+") do
            table.insert(lines, s)
        end
        return lines
      end)()
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = run_selection
  }):find()
end

vim.keymap.set('n', '<leader>p', projectPicker)
