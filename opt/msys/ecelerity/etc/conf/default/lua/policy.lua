require("msys.core");
require("msys.db");
require("msys.pcre");
require("msys.dumper");
require("msys.extended.message");
require("msys.extended.message_routing");
require("msys.extended.ac");

local mod = {};

--[[ Modify these as necessesary for your demo ]]--
local sinkdomain = "54.245.21.30"
local safedomains = { "validator.messagesystems.com", "messagesystems.com", "sparkpost.com", "momo.signalsdemo.trymsys.net", "fbl.momo.signalsdemo.trymsys.net" }

--[[ each rcpt_to function ]]--
function mod:validate_data_spool_each_rcpt (msg, accept, vctx)
--  print ("Using data_spool_each_rcpt");

  if msg:context_get(msys.core.VCTX_CONN, "can_relay") == "false" then
    msg:code("553", "Not today, buddy");
    vctx:set_code("553", "Not today, buddy");
    print("This sender can not relay");
  end

  return msys.core.VALIDATE_CONT;
end 

--[[ Set Binding function ]]--
function mod:validate_set_binding(msg)
  local domain_str = msys.core.string_new();
  local localpart_str = msys.core.string_new();
  msg:get_envelope2(msys.core.EC_MSG_ENV_TO, localpart_str, domain_str);
  local mydomain = tostring(domain_str);
  local mylocalpart = tostring(localpart_str);
  local validdomain = "false"
  local bindingname = msg:header("X-Binding")
  
-- Test to see if the TO domain is in the safe list
  for i,v in ipairs(safedomains) do
    if v == mydomain then
    --  print ("Routing to a valid domain: " .. mydomain);
      validdomain = "true"
      break
   end
  end

  if msg:context_get(msys.core.VCTX_CONN, "can_relay") == "true" then
    validdomain = "true"
  end


  if validdomain == "false" then
  --  print ("Sending this to sink: " .. sinkdomain .. " / " .. mydomain);
    msg:routing_domain(sinkdomain);
  end
    if ( ( bindingname[1] ~= "" ) and (bindingname[1] ~= nil ) )  then
      local err = msg:binding(bindingname[1]);
    else 
      local err = msg:binding("generic");
    end
  return msys.core.VALIDATE_CONT;
end;

msys.registerModule("policy", mod);

