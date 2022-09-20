local get_buf_text = function(bufnr)
  return vim.fn.join(vim.api.nvim_buf_get_lines(bufnr or 0, 0, -1, true), "\n")
end

describe("messages", function()
  it("capture command", function()
    local bufnr = vim.fn.bufnr()
    vim.cmd('echomsg "foo"')
    vim.cmd('echomsg "bar"')
    vim.cmd("Messages messages")
    assert.are_not.equal(bufnr, vim.fn.bufnr())
    assert.are.equal(get_buf_text(), "foo\nbar")
    vim.cmd("q")
  end)

  it("capture thing", function()
    local bufnr = vim.fn.bufnr()
    require("messages.api").capture_thing({ "foo", "bar" }, { "other" })
    assert.are_not.equal(bufnr, vim.fn.bufnr())
    assert.are.equal(get_buf_text(), [[{ "foo", "bar" }, { "other" }]])
    vim.cmd("q")
  end)
end)
