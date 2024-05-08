require("config.mappings")
require("config.options")
require("config.lazy")

-- config.lazy より後にrequireしないと動かない
-- 具体的には、packpathの追加(1行目)がうまくいかない
require("config.vim_plugins")
