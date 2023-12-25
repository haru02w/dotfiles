return {
	'mrjones2014/smart-splits.nvim',
	event = 'VeryLazy',
	opts = {},
	config = function(opts)
		require('smart-splits').setup(opts)
		require('nvc.keymaps').smart_splits()
	end,
}
