vim.cmd [[
let g:lightline = {
  \    'colorscheme': 'one',
  \    'active': {
  \        'left': [ [],
  \                  [ 'readonly', 'filename', 'modified', 'helloworld' ] ],
  \        'right': [ [ 'lineinfo' ],
  \                   [ 'percent' ],
  \                   [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
  \     }
  \ }
  let g:lightline.tab = {}
]]
