vim.cmd [[
    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocActionAsync('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
]]


vim.cmd [[
    " Remap <C-f> and <C-b> for scroll float windows/popups.
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif

    " Do default action for next item.
    nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
]]

-- Completion ###############################################################

vim.cmd [[
    inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(0):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"

    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]]

--vim.cmd [[ inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>" ]]
-- vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : \"<CR>\"", { noremap = true, silent = true, expr = true })
--
-- vim.cmd [[
--     inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(0): CheckBackspace() ? "\<Tab>" : coc#refresh()
--     inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(0) : "\<C-h>"
-- ]]

-- vim.keymap.set("i", "<C-n>", "coc#pum#next(0)", { noremap = true, silent = true, expr = true })
-- vim.keymap.set("i", "<C-p>", "coc#pum#prev(0)", { noremap = true, silent = true, expr = true })
  
vim.cmd [[
    inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(0) : "\<C-n>"
    inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(0) : "\<C-p>"
]]

-- vim.keymap.set("i", "<C-j>", "coc#pum#confirm()", { noremap = true, silent = true, expr = true })
-- vim.keymap.set("i", "<C-c>", "coc#pum#cancel()", { noremap = true, silent = true, expr = true })

vim.cmd [[
    inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
    inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#confirm() : "\<C-j>"
]]

-- MAPS #####################################################################

-- " Use <c-space> to trigger completion.
vim.keymap.set("i", "<C-Space>", "coc#refresh()", { noremap = true, silent = true, expr = true })

-- " Remap keys for applying codeAction to the current buffer.
vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", { noremap = true })
-- " Apply AutoFix to problem on the current line.
vim.keymap.set("n", "<leader>cf", "<Plug>(coc-fix-current)", { noremap = true })

-- " Run the Code Lens action on the current line.
vim.keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", { noremap = true })

-- " Symbol renaming.
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { noremap = true })
-- " CocRefactor
vim.keymap.set("n", "<leader>rf", "<Plug>(coc-refactor)", { noremap = true })

-- Use K to show documentation in preview window.
vim.keymap.set("n", "K", ":call ShowDocumentation()<CR>", { noremap = true, silent = true })
-- Highlight the symbol and its references when holding the cursor.
vim.cmd [[ autocmd CursorHold * silent call CocActionAsync('highlight') ]]

-- GoTo code navigation.
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { noremap = true, silent = true })
vim.keymap.set("n", "gt", "<Plug>(coc-type-definition)", { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { noremap = true, silent = true })

-- " Show all diagnostics.
vim.keymap.set("n", "g]", "<Plug>(coc-diagnostic-prev)", { noremap = true, silent = true })
vim.keymap.set("n", "g[", "<Plug>(coc-diagnostic-next)", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ld", ":<C-u>CocList diagnostics<Enter>", { noremap = true, silent = true, nowait = true })
vim.keymap.set("n", "<leader>cd", "<cmd>CocDiagnostics<Enter>", { noremap = true, silent = true })

-- Hide Popups
vim.keymap.set("n", "<leader>h", "<Plug>(coc-float-hide)", {})

-- CocList <args>
vim.keymap.set("n", "<leader>ll", ":<C-u>CocList ", { noremap = true, nowait = true })
-- Show commands.
vim.keymap.set("n", "<leader>lc", ":<C-u>CocList commands<Enter>", { noremap = true, silent = true, nowait = true })
-- Find symbol of current document.
vim.keymap.set("n", "<leader>lo", ":<C-u>CocList outline<Enter>", { noremap = true, silent = true, nowait = true })

-- Extensions List #############################################################

vim.g.coc_global_extensions = { 
    "coc-html", 
    "coc-css", 
    "coc-eslint",
    "coc-tsserver",
    "coc-prettier",   
    "coc-pyright",
    "coc-vetur",
    "coc-tailwindcss",
}
