#!/bin/bash

exit | sqlplus admi18/admi@cienetdb @creation.sql

g++ -std=c++0x -Ofast -W -Wall -Wextra -pedantic -Wno-sign-compare -Wno-unused-parameter ScriptInsertion.cpp -o ScriptInsertion && ./ScriptInsertion mouvements-sociaux-depuis-2002.csv tuples.sql

exit | sqlplus admi18/admi@cienetdb @tuples.sql 