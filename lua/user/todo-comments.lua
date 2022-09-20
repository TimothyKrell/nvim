local ok, comments = pcall(require, 'todo-comments')
if not ok then return end

comments.setup()
