@UTF8
RULENAME: pfx-adj
CTYPE: #
% first blocking
 if
 STARTCAT = [pcat OR adj n v]
 NEXTCAT = [scat adj]
 MATCHCAT [block]
 then
 RESULTCAT = ADD [scat pfx]
 RULEPACKAGE = {}
% then general
 if
 STARTCAT = [pcat
 NEXTCAT = [scat adj]
 then
 RESULTCAT = ADD [scat adj], DEL [allo], ADD [allo a0]
 RULEPACKAGE = {adj-degree, adj-v-degree, adj-suffix, adj-deriv, adv-ly}
