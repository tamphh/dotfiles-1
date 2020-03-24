if M.name == "miami" then
  require("titlebars.smart-border")
elseif M.name == "worker" then
  require("titlebars.internal-border")
else
  require("titlebars.hide")
end
