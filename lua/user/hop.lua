local ok, hop = pcall(require, "hop")
if not ok then
  return
end

hop.setup {
  keys = "wertzuiopghyxcvbnmalskdjf",
  extend_visual = true,
}
