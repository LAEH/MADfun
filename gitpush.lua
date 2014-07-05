#!/usr/bin/env th

local command = {
   'git add -A',
   'git commit -a -m "feeling confident"',
   'git pull',
   'git push',
}

for i, c in ipairs(command) do
   os.execute(c)
end
