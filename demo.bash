#!/bin/bash

exit | sqlplus admi18/admi@cienetdb @sql/creation.sql

g++ -std=c++0x -Ofast -W -Wall -Wextra -pedantic -Wno-sign-compare -Wno-unused-parameter Scripts/ScriptInsertion.cpp -o Scripts/ScriptInsertion && ./Scripts/ScriptInsertion CSV/mouvements-sociaux-depuis-2002.csv sql/tuples.sql

exit | sqlplus admi18/admi@cienetdb @sql/tuples.sql 
