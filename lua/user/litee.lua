local ok, lib = pcall(require, 'litee.lib')
if not ok then
    return
end

local ok, calltree = pcall(require, 'litee.calltree')
if not ok then
    
end

local ok, symboltree = pcall(require, 'litee.symboltree')
if not ok then
    return
end

lib.setup()
calltree.setup()
symboltree.setup()
