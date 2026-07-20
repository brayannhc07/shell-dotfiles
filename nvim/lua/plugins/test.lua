-- Testing Helper.
return {
    'vim-test/vim-test',
    cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
    keys = {
        { '<Leader>tn', '<cmd>TestNearest<CR>', desc = 'Test Nearest' },
        { '<Leader>tf', '<cmd>TestFile<CR>', desc = 'Test File' },
        { '<Leader>ts', '<cmd>TestSuite<CR>', desc = 'Test Suite' },
        { '<Leader>tl', '<cmd>TestLast<CR>', desc = 'Test Last' },
        { '<Leader>tv', '<cmd>TestVisit<CR>', desc = 'Test Visit' },
    },
}
