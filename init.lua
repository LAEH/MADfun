#!/usr/bin/env th
require 'sys'
require 'xlua'
require('pl.text').format_operator()
local col = require 'async.repl'.colorize
local json = require 'cjson'
function h1(text) print(col._black(text)) end
function h2(text) print(col.red(text)) end
function h3(text) print(col._cyan(text)) end

local fun = {}

--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●

local a = {'a','b','c','d','e'}
h1('array =')
print(a)

function fun.permute(array)
  for i = 1, #array do
    local  j = torch.random(i,#array)
    array[i], array[j] = array[j], array[i]
  end
  return array
end
h1('fun.permute(array)')
print(fun.permute(a))


function fun.sample(array)
  return array[torch.random(1, #array)]
end
h1('fun.sample(array)')
print(fun.sample(a))


--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●

function fun.trueFalse(t,f)
   local t = t or 1
   local f = f or 1
   local pool = {}
   for i=1,t do
      table.insert(pool,true)
   end
   for i=1,f do
      table.insert(pool,false)
   end
   local res = fun.permute(pool)[1]
   return res
end
h1('fun.trueFalse(ntrue, nfalse)')
print(fun.trueFalse())

function fun.bernoulli(prob)
  return torch.bernoulli(prob) == 1
end
h1('fun.bernoulli(prob)')
print(fun.sample(a))

--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●

function fun.factorial(n)
   if n == 0 then
      return 1
   else
      return n * fun.factorial(n - 1)
   end
end
h1('fun.factorial(9)')
print(fun.factorial(9))

--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●


function fun.range(min,max,step)
   local step = step or 1
   local min = min or 1
   local nsteps = max/step
   local range = {}
   for i=min,nsteps do
      range[i]=i*step
   end
   return range
end
h1('fun.range(9)')
print(fun.range(1,9))
h1('fun.range(5,10)')
print(fun.range(5,10))
h1('fun.range(10,100,10)')
print(fun.range(10,100,10))


function fun.grid(ncol, nrow)
   local samples = {}
   for i = 1, ncol do
      for j = 1, nrow do
         local gridPositions = {
            ['a'] = {
               ['x'] = i,
               ['y'] = j,
            },
            ['b'] = {
               ['x'] = i+1,
               ['y'] = j+1,
            }
         }
         table.insert(samples,gridPositions)
      end
   end
   return samples
end
h1('fun.grid(10,10)')
print(fun.grid(2,2))

--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●

fun.json = {}
function fun.json.save(name, table)
   local j = json.encode(table)
   local f = io.open(name, 'w')
   f:write(j)
   f:close()
end

function fun.json.load(path)
   return json.decode(io.open(path):read('*all') )
end

--●●●●●●●●●●●●●●●
--●             ●
--●             ●
--●             ●
--●●●●●●●●●●●●●●●

function fun.stringSplit(s, p)
    local temp = {}
    local index = 0
    local last_index = string.len(s)

    while true do
        local i, e = string.find(s, p, index)

        if i and e then
            local next_index = e + 1
            local word_bound = i - 1
            table.insert(temp, string.sub(s, index, word_bound))
            index = next_index
        else
            if index > 0 and index <= last_index then
                table.insert(temp, string.sub(s, index, last_index))
            elseif index == 0 then
                temp = nil
            end
            break
        end
    end
    return temp
end

local test = "CO.monument.paris.eiffel"
print(fun.stringSplit(test, "%."))
-- print(res)

--●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●

return fun


