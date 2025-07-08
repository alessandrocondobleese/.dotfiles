return {
  'mcauley-penney/phobos-anomaly.nvim',
  priority = 1000,
  ---@param opts table Configuration options for the colorscheme.
  config = function(opts)
    vim.cmd.colorscheme 'phobos-anomaly'
    vim.api.nvim_set_hl(
      0,
      'VisualNonText',
      { foreground = '#5D5F71', background = '#24282d' }
    )
  end,
}
