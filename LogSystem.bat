@echo off

call LogSetLevel INFO

call Log CRITICAL Critical message
call Log ERROR Error message
call Log WARNING Warning message
call Log INFO Info message
call Log TRACE Trace message
call Log DEBUG Debug message
call Log BLAD Blad message
call Log TMP Tmp message

call LogSetLevel ALL

call Log CRITICAL Critical message
call Log ERROR Error message
call Log WARNING Warning message
call Log INFO Info message
call Log TRACE Trace message
call Log DEBUG Debug message
call Log BLAD Blad message
call Log TMP Tmp message

